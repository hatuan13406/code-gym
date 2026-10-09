package com.codegym;

import java.util.Arrays;

/**
 * Reusable library for solving a*x^2 + b*x + c = 0 over the real numbers.
 * Also handles degenerate (linear and constant) equations.
 */
public final class QuadraticEquationSolver {

    private QuadraticEquationSolver() {
        // Utility class: do not instantiate.
    }

    public enum SolutionType {
        TWO_REAL_ROOTS,
        ONE_REAL_ROOT,
        NO_REAL_ROOTS,
        LINEAR_ONE_ROOT,
        NO_SOLUTION,
        INFINITELY_MANY_SOLUTIONS
    }

    /** Immutable result; roots are always returned in ascending order. */
    public static final class Solution {
        private final SolutionType type;
        private final double[] roots;

        private Solution(SolutionType type, double... roots) {
            this.type = type;
            this.roots = roots.clone();
            Arrays.sort(this.roots);
        }

        public SolutionType getType() {
            return type;
        }

        public double[] getRoots() {
            return roots.clone();
        }

        @Override
        public String toString() {
            return type + " " + Arrays.toString(roots);
        }
    }

    /**
     * Solves a*x^2 + b*x + c = 0.
     *
     * @throws IllegalArgumentException if any coefficient is NaN or infinite
     */
    public static Solution solve(double a, double b, double c) {
        if (!Double.isFinite(a) || !Double.isFinite(b) || !Double.isFinite(c)) {
            throw new IllegalArgumentException("Coefficients must be finite real numbers");
        }

        if (a == 0.0) {
            if (b == 0.0) {
                return new Solution(c == 0.0
                        ? SolutionType.INFINITELY_MANY_SOLUTIONS
                        : SolutionType.NO_SOLUTION);
            }
            return new Solution(SolutionType.LINEAR_ONE_ROOT, -c / b);
        }

        double delta = b * b - 4.0 * a * c;
        if (delta < 0.0) {
            return new Solution(SolutionType.NO_REAL_ROOTS);
        }
        if (delta == 0.0) {
            return new Solution(SolutionType.ONE_REAL_ROOT, -b / (2.0 * a));
        }

        double sqrtDelta = Math.sqrt(delta);
        double root1 = (-b - sqrtDelta) / (2.0 * a);
        double root2 = (-b + sqrtDelta) / (2.0 * a);
        return new Solution(SolutionType.TWO_REAL_ROOTS, root1, root2);
    }
}
