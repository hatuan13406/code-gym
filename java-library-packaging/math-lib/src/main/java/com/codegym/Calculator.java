package com.codegym;

import java.security.NoSuchAlgorithmException;

/**
 * Static arithmetic functions provided by the standalone math-lib JAR.
 */
public class Calculator {

    public static int sum(int a, int b) {
        return a + b;
    }

    public static int sub(int a, int b) {
        return a - b;
    }

    public static int mul(int a, int b) {
        return a * b;
    }

    /**
     * @throws NoSuchAlgorithmException if the divisor is zero
     *         (required by the CodeGym exercise).
     */
    public static int divide(int a, int b) throws NoSuchAlgorithmException {
        if (b == 0) {
            throw new NoSuchAlgorithmException("Cannot divide by zero");
        }
        return a / b;
    }
}
