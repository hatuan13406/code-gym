<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>

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

        .login-container {
            width: min(380px, calc(100% - 32px));
            padding: 30px;
            text-align: center;
            background: white;
            border-radius: 8px;
            box-shadow: 0 4px 14px rgba(0, 0, 0, 0.10);
        }

        h2 {
            margin-top: 0;
            color: #1b2a7a;
        }

        input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 15px;
        }

        button {
            width: 100%;
            margin-top: 10px;
            padding: 10px 20px;
            color: white;
            background-color: #1b2a7a;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #111d5c;
        }
    </style>
</head>

<body>
    <div class="login-container">
        <h2>System Login</h2>

        <form action="login" method="POST">
            <input
                type="text"
                name="username"
                placeholder="Enter username"
                autocomplete="username"
                required
            >

            <input
                type="password"
                name="password"
                placeholder="Enter password"
                autocomplete="current-password"
                required
            >

            <button type="submit">Login</button>
        </form>
    </div>
</body>
</html>
