<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chuyển đổi tiền tệ</title>
    <style>
        body { font-family: Arial, sans-serif; display: flex; justify-content: center; padding: 90px 16px; margin: 0; background-color: #f8fafc; }
        .converter-container { box-sizing: border-box; background: white; padding: 35px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0, 0, 0, .1); text-align: center; width: 100%; max-width: 390px; }
        h2 { color: #1b2a7a; }
        label { display: block; text-align: left; font-weight: bold; color: #333; margin: 14px 0 8px; }
        input { box-sizing: border-box; padding: 10px; width: 100%; border: 1px solid #ccc; border-radius: 4px; }
        button { background: #1b2a7a; color: white; padding: 12px 20px; border: none; border-radius: 4px; cursor: pointer; width: 100%; font-weight: bold; margin-top: 20px; }
        button:hover { background: #121c54; }
    </style>
</head>
<body>
    <main class="converter-container">
        <h2>USD to VND Converter</h2>
        <form action="converter.jsp" method="POST">
            <label for="rate">Tỉ giá (VND/USD):</label>
            <input type="number" id="rate" name="rate" value="25000" min="0.01" required step="any">

            <label for="usd">Lượng USD cần đổi:</label>
            <input type="number" id="usd" name="usd" placeholder="Nhập số lượng USD" min="0" required step="any">

            <button type="submit">Tính toán</button>
        </form>
    </main>
</body>
</html>
