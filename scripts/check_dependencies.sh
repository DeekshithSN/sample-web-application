#!/bin/bash

# Define your tools and their URLs in an associative array
declare -A TOOLS=(
    ["SonarQube"]="http://13.206.186.122:9000/"
    # Add other tools here as needed, for example:
    # ["Nexus"]="http://13.206.186.122:8081/"
    # ["Artifactory"]="http://13.206.186.122:8082/"
)

# Timeout in seconds for each request
TIMEOUT=5
FAILED_TOOLS=0

echo "========================================="
echo "Checking Dependent Tools Status..."
echo "========================================="

for TOOL in "${!TOOLS[@]}"; do
    URL="${TOOLS[$TOOL]}"
    echo -n "Checking $TOOL ($URL)... "

    # Perform a curl request fetching only the HTTP response code
    # --silent: hide progress bar
    # --head: fetch headers only (faster)
    # --connect-timeout: don't hang forever if the server is completely down
    # --output /dev/null: ignore the actual body output
    # -w "%{http_code}": print only the numeric status code
    STATUS_CODE=$(curl --write-out "%{http_code}" \
                       --silent \
                       --head \
                       --connect-timeout $TIMEOUT \
                       --output /dev/null \
                       "$URL")

    # A successful web service usually returns a 200 OK, 
    # but some login walls/dashboards might redirect (301/302) or require auth (401)
    if [[ "$STATUS_CODE" -ge 200 && "$STATUS_CODE" -lt 400 ]] || [[ "$STATUS_CODE" -eq 401 ]]; then
        echo "✅ ONLINE (HTTP $STATUS_CODE)"
    else
        echo "❌ DOWN or UNREACHABLE (HTTP status: $STATUS_CODE)"
        ((FAILED_TOOLS++))
    fi
done

echo "========================================="
if [ $FAILED_TOOLS -eq 0 ]; then
    echo "🎉 All dependent tools are up and running smoothly!"
    exit 0
else
    echo "⚠️  Warning: $FAILED_TOOLS tool(s) failed the health check."
    exit 1
fi