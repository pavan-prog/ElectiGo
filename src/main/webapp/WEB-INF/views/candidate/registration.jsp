	<%@page import="voting.application.election.entities.Election"%>
	<%@ page language="java" contentType="text/html; charset=UTF-8"
	    pageEncoding="UTF-8"%>
	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="UTF-8">
	<title>Candidate | Registration</title>
	<link rel="stylesheet" type="text/css" href="../css/register.css">
	<script>
	    function validateForm(event) {
	        let isValid = true;
	 
	        const dob = document.getElementById("date_of_birth").value;
	        const nationality = document.getElementById("nationality").value.trim().toLowerCase();
	        const aadhar = document.getElementById("aadhar_number").value;
	 
	        const dobError = document.getElementById("dobError");
	        const nationalityError = document.getElementById("nationalityError");
	        const aadharError = document.getElementById("aadharError");
	 
	        dobError.textContent = "";
	        nationalityError.textContent = "";
	        aadharError.textContent = "";
	 
	        if (dob) {
	            const birthDate = new Date(dob);
	            const today = new Date();
	            const age = today.getFullYear() - birthDate.getFullYear();
	            const monthDiff = today.getMonth() - birthDate.getMonth();
	            if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
	                age--;
	            }
	 
	            if (age < 35) {
	                dobError.textContent = "Candidate should be at least 35 years old.";
	                isValid = false;
	            }
	        } else {
	            dobError.textContent = "Date of Birth is required.";
	            isValid = false;
	        }
	 
	        if (nationality !== "indian") {
	            nationalityError.textContent = "Nationality should be Indian.";
	            isValid = false;
	        }
	 
	        if (!/^\d{12}$/.test(aadhar)) {
	            aadharError.textContent = "Aadhar Number should be exactly 12 digits.";
	            isValid = false;
	        }
	 
	        if (!isValid) {
	            event.preventDefault();
	        }
	    }
	</script>
<link rel="icon" href="../icons/favicon.png" type="image/png">
	</head>
	<body>
	    <!-- Navigation Bar -->
	    <div class="navbar">
	        <a href="/home">Home</a>
        <a href="/superadmin/returnDashboard">Dashboard</a>
	    </div>
	 
	    <div class="container">
	        <h2>Candidate Registration</h2>
	        <c:if test="${not empty message}">
            <div class="server-error">
                <p>${message}</p>
            </div>
        	</c:if>
	        <% String electionId = request.getParameter("electionId"); %>
	        
	        <form action="/candidate/registration" method="post" enctype="multipart/form-data" onsubmit="validateForm(event)">
	 			
    <input type="hidden" name="electionId" value="${election.electionId}" />
	                  
	            <div class="form-group">
                <label for="full_name">Full Name:</label>
                <input type="text" id="full_name" name="full_name" required>
            </div>
            <div class="form-group">
                <label for="date_of_birth">Date of Birth:</label>
                <input type="date" id="date_of_birth" name="date_of_birth" required>
                <span id="dobError" class="error"></span>
            </div>
            <div class="form-group">
                <label for="nationality">Nationality:</label>
                <select id="nationality" name="nationality" required>
                    <option value="Indian">Indian</option>
                    <option value="Non-Indian">Non-Indian</option>
                </select>
                <span id="nationalityError" class="error"></span>
            </div>
            <div class="form-group">
                <label for="party_name">Party Name:</label>
                <input type="text" id="party_name" name="party_name" required>
            </div>
            <div class="form-group">
                <label for="party_image">Party Image:</label>
                <input type="file" id="party_image" name="party_image" required>
            </div>
            <div class="form-group">
                <label for="aadhar_number">Aadhar Number:</label>
                <input type="number" id="aadhar_number" name="aadhar_number" required>
                <span id="aadharError" class="error"></span>
            </div>
            <button type="submit" class="btn">Register</button>
	        </form>
	    </div>
	</body>
	</html>
