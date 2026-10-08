<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Currency Converter</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            padding-top: 100px;
            background-color: #f8fafc;
            font-family: Arial, sans-serif;
        }

        .converter-container {
            width: min(380px, calc(100% - 32px));
            padding: 40px;
            text-align: center;
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.10);
        }

        h2 {
            margin-top: 0;
            color: #1b2a7a;
        }

        .field {
            margin-top: 14px;
            text-align: left;
        }

        label {
            display: block;
            margin-bottom: 6px;
            color: #333;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 15px;
        }

        button {
            width: 100%;
            margin-top: 20px;
            padding: 12px 20px;
            color: white;
            background-color: #1b2a7a;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
        }

        button:hover {
            background-color: #121c54;
        }
    </style>
</head>

<body>
    <div class="converter-container">
        <h2>Chuyển đổi USD sang VNĐ</h2>

        <form action="convert" method="POST">
            <div class="field">
                <label for="rate">Tỉ giá (VND/USD):</label>
                <input
                    id="rate"
                    type="number"
                    name="rate"
                    value="25000"
                    placeholder="Ví dụ: 25000"
                    min="0.01"
                    step="any"
                    required
                >
            </div>

            <div class="field">
                <label for="usd">Lượng USD cần đổi:</label>
                <input
                    id="usd"
                    type="number"
                    name="usd"
                    placeholder="Nhập số USD"
                    min="0"
                    step="any"
                    required
                >
            </div>

            <button type="submit">Chuyển đổi</button>
        </form>
    </div>
</body>
</html>
