<%@page import="voting.application.admin.entities.Admin"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Profile</title>
    <link href="../css/style.css" rel="stylesheet" type="text/css"/>
    
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
 
        .container {
            width: 30%; /* Reduce width of form container */
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
 
        h2 {
            text-align: center;
            color: #333;
        }
 
        .form-group {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }
 
        .form-group label {
            font-weight: bold;
            color: #333;
            width: 130px; /* Adjust label width */
            margin-right: 10px;
        }
 
        .form-group input {
            width: calc(100% - 140px); 
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }
 
        .btn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 48%; 
            margin-top: 20px;
            display: inline-block;
        }
 
        .btn:hover {
            background-color: #45a049;
        }
 
        .cancel-btn {
            background-color: #f44336; 
            width: 48%; 
            display: inline-block;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            width: 48%;
            margin-top: 20px;
            display: inline-block;
        }
 
        .cancel-btn:hover {
            background-color: #e53935;
        }
 
        .button-container {
            display: flex;
            justify-content: space-between; 
        }
 
        .green-bottom-horizontal, .green-bottom-vertical {
            background-color: #4CAF50;
            height: 10px;
        }
 
        .green-bottom-horizontal {
            width: 100%;
            position: absolute;
            bottom: 0;
        }
 
        .green-bottom-vertical {
            width: 10px;
            height: 100%;
            position: absolute;
            right: 0;
        }
        /* Close Button Styling */
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
    <!-- Favicon -->
	<link rel="icon" href="../icons/favicon.png" type="image/png">
</head>
<body>
 
    <div class="container">
    <a class="close-btn" href="/subadmin/opendashboard"></a>
        <!-- <button class="close-btn" onclick="window.history.back();"></button> -->
    
        <h2>Edit Your Profile</h2>
        
        <form action="/subadmin/updateProfile" method="post">
<input type="hidden" name="adminId" value="${admin.id}"/>
 
            <div class="form-group">
                <label for="firstName">First Name:</label>
                <input type="text" id="firstName" name="firstName" value="${admin.firstName}" required/>
            </div>
 
            <div class="form-group">
                <label for="lastName">Last Name:</label>
                <input type="text" id="lastName" name="lastName" value="${admin.lastName}" required/>
            </div>
 
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" value="${admin.username}" required/>
            </div>
 
            <div class="form-group">
                <label for="currentPassword">Verify Password:</label>
                <input type="password" id="currentPassword" name="currentPassword" required/>
            </div>
 
            <div class="form-group">
                <label for="password">New Password (optional):</label>
                <input type="password" id="password" name="password"/>
            </div>
 
            <div class="button-container">
                <button type = "button" class="cancel-btn" onclick="window.history.back();">Cancel</button>
				<button type="submit" class="btn">Update Profile</button>
            </div>
        </form>
        
        <br/>
        <%@include file="../message.jsp" %>
        
        <div class="green-bottom-horizontal"></div>
        <div class="green-bottom-vertical"></div>
    </div>

</body>
</html>