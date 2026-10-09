package com.codegym;

import java.security.NoSuchAlgorithmException;

/** Standalone zero-dependency test: execute with java, not Maven Surefire. */
public class CalculatorSelfTest {
    public static void main(String[] args) throws Exception {
        if (Calculator.sum(5, 9) != 14) throw new AssertionError("sum");
        if (Calculator.sub(5, 9) != -4) throw new AssertionError("sub");
        if (Calculator.mul(5, 9) != 45) throw new AssertionError("mul");
        if (Calculator.divide(10, 5) != 2) throw new AssertionError("divide");
        try {
            Calculator.divide(10, 0);
            throw new AssertionError("zero divisor must throw");
        } catch (NoSuchAlgorithmException expected) {
            System.out.println("divide by zero: expected exception");
        }
        System.out.println("All Calculator self-tests passed.");
    }
}
