<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Voter | Login</title>
<link href="../css/voter_styles.css" rel="stylesheet" type="text/css" />
<!-- Favicon -->
<link rel="icon" href="../icons/favicon.png" type="image/png">
</head>
<body>
	<nav>
		<a href="/">Home</a>
	</nav>

	<div class="login-container">
		<h2>Voter Login</h2>
		<form action="/voter/login" method="post">
			<div class="form-group">
				<label for="aadharNumber">Aadhar Number:</label> <input type="text"
					id="aadharNumber" name="aadharNumber" required>
			</div>
			<div class="form-group">
				<label for="password">Password:</label> <input type="password"
					id="password" name="password" required>
			</div>
			<button type="submit" class="btn">Login</button>
		</form>

		<p>
			Not registered? <a href="/voter/openRegistrationPage">Register
				here</a>
		</p>
		<p class="forgot-password">
			<a href="/auth/forgot_password_page">Forgot password?</a>
		</p>
		<%@include file="../message.jsp"%>
	</div>

</body>
<style>
body {
	font-family: Arial, sans-serif;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
	background-image: url('/images/background.png');
	/* Add your background image URL here */
	background-size: cover;
	background-position: center;
}

.login-container {
	background-color: #fff;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	width: 100%;
	max-width: 400px;
	box-sizing: border-box;
	overflow: hidden;
}

h2 {
	text-align: center;
	color: #333;
	margin-bottom: 20px;
}

.form-group {
	margin-bottom: 15px;
}

label {
	display: block;
	margin-bottom: 5px;
	color: #333;
}

input[type="text"], input[type="password"] {
	width: 100%;
	padding: 8px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
}

.btn {
	display: block;
	width: 100%;
	padding: 10px;
	background-color: #4CAF50;
	color: white;
	text-align: center;
	text-decoration: none;
	border-radius: 4px;
	cursor: pointer;
	border: none;
}
nav {
	width: 100%;
	overflow: hidden;
	padding: 10px 0;
	position: fixed;
	top: 16px;
	left: 30px;
	z-index: 1000;
}

nav a {
	border-radius: 10px; 
	float : left;
	display: block;
	color: white;
	background-color: green;
	text-align: center;
	padding: 14px 20px;
	text-decoration: none;
	float: left;
}

nav a:hover {
	background-color: #ddd;
	color: black;
}

.btn:hover {
	background-color: #45a049;
}

p {
	text-align: center;
	margin-top: 20px;
}

p a {
	color: #4CAF50;
	text-decoration: none;
}

p a:hover {
	text-decoration: underline;
}

.forgot-password {
	text-align: center;
	margin-top: 10px;
}
</style>
</html>