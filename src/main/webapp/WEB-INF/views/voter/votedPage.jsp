<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home Page</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-image: url('/images/background.png'); 
        background-size: cover;
        background-position: center;
        text-align: center;
        padding: 50px;
        margin: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
    }
    .container {
        background-color: rgba(255, 255, 255, 0.8); 
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        max-width: 600px;
        width: 100%;
    }
    h2 {
        color: #2196F3;
    }
    a {
        display: inline-block;
        margin-top: 20px;
        padding: 10px 20px;
        background-color: #f44336;
        color: white;
        text-decoration: none;
        border-radius: 5px;
    }
    a:hover {
        background-color: #d32f2f;
    }
    
</style>
<!-- Favicon -->
<link rel="icon" href="../icons/favicon.png" type="image/png">
</head>
<body>

<div class="container">
    <h2>You have already voted</h2>
    <a href="#" onclick="goBack()">Back</a>
</div>

<script>
function goBack() {
    history.go(-3);
}
</script>

</body>
</html>