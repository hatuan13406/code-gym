package com.codegym;

/**
 * Zero-dependency self-test for the library:
 * java -cp "target/classes:target/test-classes" com.codegym.QuadraticEquationSolverSelfTest
 */
public class QuadraticEquationSolverSelfTest {
    private static void check(boolean condition, String description) {
        if (!condition) {
            throw new AssertionError(description);
        }
    }

    public static void main(String[] args) {
        var two = QuadraticEquationSolver.solve(1, -3, 2);
        check(two.getType() == QuadraticEquationSolver.SolutionType.TWO_REAL_ROOTS,
                "two real roots type");
        check(two.getRoots().length == 2 && two.getRoots()[0] == 1.0
                && two.getRoots()[1] == 2.0, "two roots 1 and 2");

        var one = QuadraticEquationSolver.solve(1, -2, 1);
        check(one.getType() == QuadraticEquationSolver.SolutionType.ONE_REAL_ROOT
                && one.getRoots()[0] == 1.0, "double root");

        check(QuadraticEquationSolver.solve(1, 1, 1).getType()
                == QuadraticEquationSolver.SolutionType.NO_REAL_ROOTS, "no real roots");

        var linear = QuadraticEquationSolver.solve(0, 2, -8);
        check(linear.getType() == QuadraticEquationSolver.SolutionType.LINEAR_ONE_ROOT
                && linear.getRoots()[0] == 4.0, "linear equation");

        check(QuadraticEquationSolver.solve(0, 0, 5).getType()
                == QuadraticEquationSolver.SolutionType.NO_SOLUTION, "no solution");
        check(QuadraticEquationSolver.solve(0, 0, 0).getType()
                == QuadraticEquationSolver.SolutionType.INFINITELY_MANY_SOLUTIONS,
                "infinitely many solutions");

        try {
            QuadraticEquationSolver.solve(Double.NaN, 1, 1);
            throw new AssertionError("NaN must be rejected");
        } catch (IllegalArgumentException expected) {
            // Expected exception.
        }

        var roots = QuadraticEquationSolver.solve(1, -3, 2).getRoots();
        roots[0] = 999;
        check(QuadraticEquationSolver.solve(1, -3, 2).getRoots()[0] == 1.0,
                "defensive copy");
        System.out.println("PASS: 8 quadratic equation checks");
    }
}
