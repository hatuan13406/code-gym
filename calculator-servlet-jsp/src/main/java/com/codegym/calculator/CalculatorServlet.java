package com.codegym.calculator;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "CalculatorServlet", urlPatterns = "/calculate")
public class CalculatorServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect(request.getContextPath() + "/");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            String firstText = request.getParameter("firstOperand");
            String secondText = request.getParameter("secondOperand");
            String operator = request.getParameter("operator");

            if (firstText == null || firstText.isBlank()
                    || secondText == null || secondText.isBlank()) {
                throw new IllegalArgumentException("Thiếu toán hạng.");
            }

            double firstOperand = Double.parseDouble(firstText.trim());
            double secondOperand = Double.parseDouble(secondText.trim());
            double result = Calculator.calculate(firstOperand, secondOperand, operator);

            String symbol;
            switch (operator) {
                case "addition": symbol = "+"; break;
                case "subtraction": symbol = "-"; break;
                case "multiplication": symbol = "×"; break;
                case "division": symbol = "÷"; break;
                default: throw new IllegalArgumentException("Phép toán không hợp lệ.");
            }

            request.setAttribute("firstOperand", firstOperand);
            request.setAttribute("secondOperand", secondOperand);
            request.setAttribute("symbol", symbol);
            request.setAttribute("result", result);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Vui lòng nhập hai số hợp lệ.");
        } catch (ArithmeticException e) {
            request.setAttribute("error", e.getMessage());
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Dữ liệu hoặc phép toán không hợp lệ.");
        }

        request.getRequestDispatcher("/WEB-INF/views/result.jsp").forward(request, response);
    }
}
