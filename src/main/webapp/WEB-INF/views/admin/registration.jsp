<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin | Registration</title>
    <link href="../css/style.css" rel="stylesheet" type="text/css"/>
    <style type="text/css">
 
        .modal {
            display: none; 
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0,0,0,0.4); 
        }
        
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto;
            padding: 20px;
            border: 1px solid #888;
            width: 40%;
        }
        
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
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
        <h2>Admin Registration</h2>
        <form id="registrationForm" action="/admin/registration" method="post" onsubmit="return handleSubmit()">
            <div class="form-group">
                <label for="firstName">First Name:</label>
                <input type="text" id="firstName" name="firstName" required>
            </div>
            
            <div class="form-group">
                <label for="lastName">Last Name:</label>
                <input type="text" id="lastName" name="lastName" required>
            </div>
            
            <div class="form-group">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" required>
            </div>
            
            <div class="form-group">
                <label for="email">Sub-Admin Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            
            <div>
                <input type="hidden" name="roleId" value="2">
            </div>
            
            <button type="submit" class="btn">Add Sub-Admin</button>
        </form>
        
        <!-- Success Popup Modal -->
        <div id="successModal" class="modal">
            <div class="modal-content">
                <span class="close">&times;</span>
                <h3>Form Submitted Successfully!</h3>
                <p>Sub-Admin has been added. Click OK to continue.</p>
                <button onclick="closePopup()">OK</button>
            </div>
        </div>
        
        <%@include file="../message.jsp" %>
        
        <div class="green-bottom-horizontal"></div>
        <div class="green-bottom-vertical"></div>
    </div>
    
    <script>
        function handleSubmit() {
            localStorage.setItem("formSubmitted", "true");
            return true;  
        }
        
        window.onload = function() {
            var formSubmitted = localStorage.getItem("formSubmitted");
            if (formSubmitted === "true") {
                showSuccessPopup();
                localStorage.removeItem("formSubmitted"); 
            }
        };
        
        function showSuccessPopup() {
            var modal = document.getElementById("successModal");
            modal.style.display = "block";
        }
        
        var closeBtn = document.getElementsByClassName("close")[0];
        closeBtn.onclick = function() {
            var modal = document.getElementById("successModal");
            modal.style.display = "none";
        }
        
        window.onclick = function(event) {
            var modal = document.getElementById("successModal");
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
        
        function closePopup() {
            var modal = document.getElementById("successModal");
            modal.style.display = "none";
            window.location.href = "/superadmin/openViewSubAdminsPage";
        }

        window.onload = function() {
            var success = '<%= request.getAttribute("success") %>';
            if (success === 'true') {
                showSuccessPopup();
            }
        };
    </script>
</body>
</html>
