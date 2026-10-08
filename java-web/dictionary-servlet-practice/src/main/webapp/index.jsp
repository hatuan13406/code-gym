<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Từ điển Anh - Việt</title>

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

        .dictionary-container {
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

        input {
            width: 100%;
            padding: 12px;
            margin: 15px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
        }

        button {
            width: 100%;
            padding: 12px 20px;
            color: white;
            background-color: #1b2a7a;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
        }

        button:hover {
            background-color: #121c54;
        }

        .hint {
            margin-top: 16px;
            color: #64748b;
            font-size: 13px;
        }
    </style>
</head>

<body>
    <div class="dictionary-container">
        <h2>Từ Điển Anh - Việt</h2>

        <form action="translate" method="POST">
            <input
                type="text"
                name="word"
                placeholder="Nhập từ tiếng Anh..."
                required
                autofocus
            >

            <button type="submit">Tìm kiếm</button>
        </form>

        <p class="hint">
            Thử: hello, book, computer, student
        </p>
    </div>
</body>
</html>
