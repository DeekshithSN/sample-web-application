package com.example;

import static org.junit.Assert.assertEquals;
import org.junit.Test;

/**
 * Unit tests for the {@link Utility} class.
 */
public class UtilityTest {

    /**
     * Tests that the add method correctly sums two positive integers.
     */
    @Test
    public void testAddPositiveNumbers() {
        assertEquals(5, Utility.add(2, 3));
    }

    /**
     * Tests that the add method correctly sums negative integers.
     */
    @Test
    public void testAddNegativeNumbers() {
        assertEquals(-5, Utility.add(-2, -3));
    }

    /**
     * Tests that the add method correctly handles adding zero.
     */
    @Test
    public void testAddWithZero() {
        assertEquals(10, Utility.add(10, 0));
    }
}
