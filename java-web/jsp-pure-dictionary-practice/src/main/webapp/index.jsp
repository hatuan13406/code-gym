<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Từ điển Anh - Việt</title>
    <style>
        body { font-family: Arial, sans-serif; display: flex; justify-content: center; background: #f8fafc; margin: 0; padding: 100px 16px; }
        .dictionary-container { box-sizing: border-box; background: white; padding: 40px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0, 0, 0, .1); text-align: center; width: 100%; max-width: 420px; }
        h2 { color: #1b2a7a; }
        input { box-sizing: border-box; padding: 12px; margin: 15px 0; width: 100%; border: 1px solid #ccc; border-radius: 4px; font-size: 16px; }
        button { background: #1b2a7a; color: white; padding: 12px 20px; border: none; border-radius: 4px; cursor: pointer; width: 100%; font-weight: bold; font-size: 16px; margin-top: 10px; }
        button:hover { background: #121c54; }
    </style>
</head>
<body>
    <main class="dictionary-container">
        <h2>Từ Điển Anh - Việt</h2>
        <form action="dictionary.jsp" method="POST" accept-charset="UTF-8">
            <input type="text" name="search" placeholder="Nhập từ tiếng Anh..." required autofocus>
            <button type="submit">Tìm kiếm</button>
        </form>
    </main>
</body>
</html>
