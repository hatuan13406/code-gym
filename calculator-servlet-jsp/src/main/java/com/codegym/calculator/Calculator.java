package com.codegym.calculator;

/**
 * Thực hiện bốn phép toán cơ bản cho ứng dụng máy tính.
 */
public class Calculator {
    public static double calculate(double firstOperand, double secondOperand, String operator) {
        if (!Double.isFinite(firstOperand) || !Double.isFinite(secondOperand)) {
            throw new IllegalArgumentException("Toán hạng không hợp lệ.");
        }

        if (operator == null) {
            throw new IllegalArgumentException("Vui lòng chọn phép toán.");
        }

        double result;
        switch (operator) {
            case "addition":
                result = firstOperand + secondOperand;
                break;
            case "subtraction":
                result = firstOperand - secondOperand;
                break;
            case "multiplication":
                result = firstOperand * secondOperand;
                break;
            case "division":
                if (secondOperand == 0) {
                    throw new ArithmeticException("Không thể chia cho 0.");
                }
                result = firstOperand / secondOperand;
                break;
            default:
                throw new IllegalArgumentException("Phép toán không hợp lệ.");
        }

        if (!Double.isFinite(result)) {
            throw new ArithmeticException("Kết quả vượt giới hạn xử lý.");
        }
        return result;
    }
}
