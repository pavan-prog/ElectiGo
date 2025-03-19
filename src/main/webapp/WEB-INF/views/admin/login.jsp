<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin | Login</title>
<link href="../css/login.css" rel="stylesheet" type="text/css" />

<style>
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
</style>
<!-- Favicon -->
<link rel="icon" href="../icons/favicon.png" type="image/png">
</head>
<body>
	<nav>
		<a href="/">Home</a>
	</nav>
	<div class="container">

		<h2>Admin Login</h2>

		<form action="/admin/login" method="post">
			<div class="form-group">
				<label for="username">Username:</label> <input type="text"
					id="username" name="username" required>
			</div>
			<div class="form-group">
				<label for="password">Password:</label> <input type="password"
					id="password" name="password" required>
			</div>
			<button type="submit" class="btn">Login</button>
		</form>

		<p class="forgot-password">
			<a href="/auth/forgot_password_page">Forgot password?</a>
		</p>


		<%@include file="../message.jsp"%>

		<!-- Green glow at the bottom-left corner (both horizontal and vertical) -->
		<div class="green-bottom-horizontal"></div>
		<div class="green-bottom-vertical"></div>
	</div>

	</div>
	<script>
		document.addEventListener("DOMContentLoaded", function() {
			document.querySelector(".container").classList.add("loaded");
		});
	</script>
</body>

</body>
</html>