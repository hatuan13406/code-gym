<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Discount Calculator</title>

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
            padding: 80px 20px;
            background: #f8fafc;
            font-family: Arial, sans-serif;
        }

        .calculator {
            width: min(420px, 100%);
            background: white;
            padding: 32px;
            border-radius: 10px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);
        }

        h1 {
            margin-top: 0;
            color: #1b2a7a;
            font-size: 28px;
        }

        .field {
            margin-top: 16px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
            color: #333;
        }

        input {
            width: 100%;
            padding: 11px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 15px;
        }

        button {
            width: 100%;
            margin-top: 22px;
            padding: 12px 18px;
            border: none;
            border-radius: 4px;
            background: #1b2a7a;
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover {
            background: #121c54;
        }
    </style>
</head>

<body>
    <div class="calculator">
        <h1>Product Discount Calculator</h1>

        <form action="display-discount" method="POST">
            <div class="field">
                <label for="productDescription">Product Description</label>
                <input
                    id="productDescription"
                    type="text"
                    name="productDescription"
                    placeholder="Enter product description"
                    required
                >
            </div>

            <div class="field">
                <label for="listPrice">List Price</label>
                <input
                    id="listPrice"
                    type="number"
                    name="listPrice"
                    min="0"
                    step="any"
                    placeholder="Enter list price"
                    required
                >
            </div>

            <div class="field">
                <label for="discountPercent">Discount Percent</label>
                <input
                    id="discountPercent"
                    type="number"
                    name="discountPercent"
                    min="0"
                    max="100"
                    step="any"
                    placeholder="Enter discount percent"
                    required
                >
            </div>

            <button type="submit">Calculate Discount</button>
        </form>
    </div>
</body>
</html>
