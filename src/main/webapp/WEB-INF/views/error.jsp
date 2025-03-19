<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Error</title>
<style>
body {
	font-family: 'Arial', sans-serif;
	background-color: white;
	margin: 0;
	padding: 0;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	height: 100vh;
	text-align: center;
}

h1 {
	color: #e74c3c;
	font-size: 48px;
	margin-bottom: 20px;
}

p {
	color: #333;
	font-size: 24px;
	margin-bottom: 20px;
}

.button {
	margin-top: 20px;
	padding: 10px 20px;
	color: #fff;
	background-color: #4CAF50;
	border: none;
	border-radius: 5px;
	text-decoration: none;
	cursor: pointer;
}

.button:hover {
	background-color: #45a049;
}

.cover {
	position: absolute;
	width:250px;
	background-color:white;
	top: 400px;
	right:510px;
	cursor: pointer;
	text-shadow: 0 0 10px rgba(255, 255, 255, 0.7); /* Shining effect */
	z-index: 2; /* Ensure the menu icon is above other elements */
}
</style>
<!-- Favicon -->
<link rel="icon" href="../icons/favicon.png" type="image/png">
</head>
<body>
	<img
		src="https://cdn.dribbble.com/users/774806/screenshots/3823110/something-went-wrong.gif"
		alt="Error Image" style="width: 50%; height: 450px;">
	<a href="/" class="button">Return to Home</a>

	<div class="cover">
		<p style="font-size: 15px">Sorry! For Inconvience &#128546;</p>
	</div>
</body>
</html>