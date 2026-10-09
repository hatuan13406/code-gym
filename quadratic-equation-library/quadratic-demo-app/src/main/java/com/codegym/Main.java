package com.codegym;

import java.util.Scanner;

/** Demonstrates usage of QuadraticEquationSolver from an external JAR. */
public class Main {
    public static void main(String[] args) {
        try (Scanner scanner = new Scanner(System.in)) {
            System.out.println("GIAI PHUONG TRINH BAC HAI: a*x^2 + b*x + c = 0");
            System.out.print("Nhap he so a: ");
            double a = scanner.nextDouble();
            System.out.print("Nhap he so b: ");
            double b = scanner.nextDouble();
            System.out.print("Nhap he so c: ");
            double c = scanner.nextDouble();

            QuadraticEquationSolver.Solution result =
                    QuadraticEquationSolver.solve(a, b, c);

            switch (result.getType()) {
                case TWO_REAL_ROOTS -> System.out.printf(
                        "Phuong trinh co 2 nghiem phan biet: x1 = %.6f, x2 = %.6f%n",
                        result.getRoots()[0], result.getRoots()[1]);
                case ONE_REAL_ROOT -> System.out.printf(
                        "Phuong trinh co nghiem kep: x = %.6f%n", result.getRoots()[0]);
                case NO_REAL_ROOTS -> System.out.println("Phuong trinh vo nghiem thuc.");
                case LINEAR_ONE_ROOT -> System.out.printf(
                        "Day la phuong trinh bac nhat, x = %.6f%n", result.getRoots()[0]);
                case NO_SOLUTION -> System.out.println("Phuong trinh vo nghiem.");
                case INFINITELY_MANY_SOLUTIONS -> System.out.println("Phuong trinh vo so nghiem.");
            }
        }
    }
}
