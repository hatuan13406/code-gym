<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Calculator - Máy tính đơn giản</title>
    <style>
        * { box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f4f7fb; margin: 0; padding: 70px 16px; }
        .card { max-width: 450px; margin: auto; background: #fff; padding: 32px; border-radius: 12px; box-shadow: 0 6px 24px #17255416; }
        h1 { color: #1b2a7a; margin: 0 0 8px; font-size: 26px; }
        p { color: #637085; margin: 0 0 22px; }
        label { display: block; margin-top: 15px; margin-bottom: 7px; font-weight: bold; }
        input, select { display: block; width: 100%; padding: 12px; border: 1px solid #bfc9d8; border-radius: 6px; font-size: 16px; background: white; }
        button { width: 100%; border: 0; border-radius: 6px; background: #1b2a7a; color: white; font-size: 16px; padding: 13px; cursor: pointer; margin-top: 25px; }
        button:hover { background: #121c54; }
    </style>
</head>
<body>
    <main class="card">
        <h1>Calculator</h1>
        <p>Máy tính với bốn phép toán cơ bản.</p>
        <form action="${pageContext.request.contextPath}/calculate" method="post">
            <label for="firstOperand">Toán hạng thứ nhất</label>
            <input type="number" step="any" id="firstOperand" name="firstOperand" required placeholder="Nhập số thứ nhất">

            <label for="operator">Phép toán</label>
            <select id="operator" name="operator" required>
                <option value="addition">Cộng (+)</option>
                <option value="subtraction">Trừ (-)</option>
                <option value="multiplication">Nhân (×)</option>
                <option value="division">Chia (÷)</option>
            </select>

            <label for="secondOperand">Toán hạng thứ hai</label>
            <input type="number" step="any" id="secondOperand" name="secondOperand" required placeholder="Nhập số thứ hai">

            <button type="submit">Tính toán</button>
        </form>
    </main>
</body>
</html>
