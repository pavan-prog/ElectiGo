<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reset Password</title>
<link href="../css/login.css" rel="stylesheet" type="text/css" />

<style>
.close-btn {
	position: absolute;
	top: 10px;
	right: 10px;
	background-color: transparent;
	border: none;
	font-size: 20px;
	color: #333;
	cursor: pointer;
	padding: 8px 12px;
	border-radius: 50%;
	display: flex;
	justify-content: center;
	align-items: center;
	transition: background-color 0.3s ease, transform 0.3s ease;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	z-index: 10; 
}

.close-btn {
	position: absolute;
	top: 10px;
	right: 10px;
	background-color: transparent;
	border: none;
	font-size: 28px; 
	color: #333; 
	cursor: pointer;
	padding: 5px 8px;
	border-radius: 50%;
	transition: all 0.3s ease;
	width: 30px;
	height: 30px;
	display: flex;
	justify-content: center;
	align-items: center;
	z-index: 10; 
}

.close-btn:hover {
	background-color: #ff6f61; 
	color: white; 
	transform: scale(1.2); 
}

.close-btn:active {
	background-color: #e03e2f; 
	transform: scale(1.1); 
}

.close-btn:focus {
	outline: none;
	box-shadow: 0 0 0 3px rgba(255, 111, 97, 0.5); 
}

.close-btn::before {
	content: "×"; 
	font-size: 22px; 
	font-weight: bold;
}
</style>
<link rel="icon" href="../icons/favicon.png" type="image/png">
</head>
<body>

	<div class="container">
		<button class="close-btn" onclick="window.history.back();"></button>

		<h2>Reset Your Password</h2>

		<!-- Email Form -->
		<div id="emailForm" style="display: none;">
			<form action="/auth/forgot_password" method="post">
				<div class="form-group">
					<label for="email">Enter your email address:</label> <input type="email" id="email"
						name="email" required>
				</div>
				<button type="submit"
					style="background-color: #007BFF; color: white; padding: 10px 15px; border: none; border-radius: 20px; cursor: pointer; width: 50%; position: relative; font-size: 16px; text-align: center; padding-left: 15px; padding-right: 40px; transition: transform 0.3s ease, background-color 0.3s ease;">Send
					OTP</button>
			</form>
		</div>

		<div id="otpForm" style="display: none;">
			<form action="/auth/verify_otp" method="post">
				<input type="hidden" name="email" value="${email}"> 
				<!-- <input type="hidden" name="timestamp" value="${timestamp}">  -->
				<label for="otp">Enter OTP:</label> 
				<input type="text" id="otp" name="otp" required>
				<button type="submit">Verify OTP</button>
			</form>
		</div>

		<div id="resetPasswordForm" style="display: none;">
			<form action="/auth/change_password" method="post"
				onsubmit="return validatePasswordForm();">
				<input type="hidden" name="email" value="${email}">
				<div class="form-group">
					<label for="newPassword">New Password:</label> <input
						type="password" id="newPassword" name="newPassword" required>
				</div>
				<div class="form-group">
					<label for="confirmPassword">Confirm Password:</label> <input
						type="password" id="confirmPassword" name="confirmPassword"
						required>
				</div>
				<button type="submit" class="btn">Submit</button>
			</form>
		</div>

		<div id="errorMessage" style="color: red;">
			<p>${error}</p>
		</div>
		<div class="green-bottom-horizontal"></div>
		<div class="green-bottom-vertical"></div>
	</div>

	<script>
		let step = "${step}"; 

		window.onload = function() {
			if (step == "email") {
				document.getElementById('emailForm').style.display = 'block';
				document.getElementById('otpForm').style.display = 'none';
				document.getElementById('resetPasswordForm').style.display = 'none';
			} else if (step == "otp") {
				document.getElementById('emailForm').style.display = 'none';
				document.getElementById('otpForm').style.display = 'block';
				document.getElementById('resetPasswordForm').style.display = 'none';
			} else if (step == "resetPassword") {
				document.getElementById('emailForm').style.display = 'none';
				document.getElementById('otpForm').style.display = 'none';
				document.getElementById('resetPasswordForm').style.display = 'block';
			}
			let successMessage = "${success}";
	        if (successMessage) {
	            alert(successMessage);
	            window.location.href = "/admin/login"; 
	        }

			document.querySelector('.container').classList.add('loaded');
		};
		
	</script>
</body>
</html>