<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home Page</title>
<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f0f0f0;
        text-align: center;
        padding: 50px;
        margin: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }
    .container {
        background-color: #ffffff;
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        max-width: 500px;
        width: 100%;
    }
    h1 {
        color: #4CAF50;
        font-size: 2.5em;
        margin-bottom: 20px;
    }
    h2 {
        color: #2196F3;
        font-size: 2em;
        margin-bottom: 30px;
    }
    a {
        display: inline-block;
        margin-top: 20px;
        padding: 15px 30px;
        background-color: #f44336;
        color: white;
        text-decoration: none;
        border-radius: 5px;
        font-size: 1.2em;
        transition: background-color 0.3s, transform 0.3s;
    }
    a:hover {
        background-color: #d32f2f;
        transform: scale(1.05);
    }
</style>
<!-- Favicon -->
<link rel="icon" href="../icons/favicon.png" type="image/png">
</head>
<body>

<div class="container">
    <h2>Successfully voted</h2>
    <a href="/voter/opendashboard">Back</a>
</div>

</body>
</html>