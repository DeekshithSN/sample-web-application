#!/bin/bash

# Path to the commit message file (passed as the first argument)
COMMIT_MSG_FILE=$1

if [ -z "$COMMIT_MSG_FILE" ]; then
    echo "Error: No commit message file provided."
    exit 1
fi

# Read the commit message lines into an array
IFS=$'\n' read -d '' -r -a LINES < "$COMMIT_MSG_FILE"

# 1. Check the first line prefix
FIRST_LINE="${LINES[0]}"
if [[ ! "$FIRST_LINE" =~ ^(feat:|fix:|hotfix:) ]]; then
    echo "❌ INVALID COMMIT MESSAGE FORMAT"
    echo "The first line must start with 'feat:', 'fix:', or 'hotfix:'."
    echo "Found: \"$FIRST_LINE\""
    exit 1
fi

# 2. Check the last line for Issue-ID
# Find the actual last line (ignoring trailing empty lines)
LAST_INDEX=$((${#LINES[@]} - 1))
while [ $LAST_INDEX -ge 0 ] && [ -z "${LINES[$LAST_INDEX]}" ]; do
    ((LAST_INDEX--))
done

if [ $LAST_INDEX -lt 0 ]; then
    echo "❌ INVALID COMMIT MESSAGE FORMAT: Message is empty."
    exit 1
fi

LAST_LINE="${LINES[$LAST_INDEX]}"
if [[ ! "$LAST_LINE" =~ ^Issue-ID:[[:space:]]*[A-Za-z0-9-]+ ]]; then
    echo "❌ INVALID COMMIT MESSAGE FORMAT"
    echo "The last line must contain a valid Issue-ID (e.g., 'Issue-ID: UIAPP-101')."
    echo "Found: \"$LAST_LINE\""
    exit 1
fi

echo "✅ Commit message format is valid!"
exit 0