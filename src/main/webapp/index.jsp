<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Chuyển đổi tiền tệ USD sang VNĐ</title>
    <style>
        body { font-family: Arial, sans-serif; display: flex; justify-content: center; padding: 80px 16px; margin: 0; background: #f8fafc; }
        .box { box-sizing: border-box; background: white; padding: 32px; border-radius: 10px; box-shadow: 0 4px 12px #0001; width: 100%; max-width: 410px; }
        h2 { color: #1b2a7a; text-align: center; }
        label { display: block; font-weight: bold; margin-top: 16px; }
        input { box-sizing: border-box; display: block; width: 100%; padding: 11px; margin-top: 8px; border: 1px solid #bbb; border-radius: 5px; }
        button { margin-top: 20px; width: 100%; padding: 12px; background: #1b2a7a; color: white; border: 0; border-radius: 5px; font-weight: bold; cursor: pointer; }
        button:hover { background: #121c54; }
    </style>
</head>
<body>
    <main class="box">
        <h2>USD to VND Converter</h2>
        <form action="converter.jsp" method="POST" accept-charset="UTF-8">
            <label for="rate">Tỉ giá (VND/USD):</label>
            <input id="rate" type="number" name="rate" value="25000" min="0.01" step="any" required>
            <label for="usd">Lượng USD cần đổi:</label>
            <input id="usd" type="number" name="usd" placeholder="Nhập số lượng USD" min="0" step="any" required>
            <button type="submit">Tính toán</button>
        </form>
    </main>
</body>
</html>
