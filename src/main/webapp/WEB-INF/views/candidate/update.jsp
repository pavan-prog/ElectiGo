<%@page import="voting.application.candidate.entities.Candidate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Page</title>
    <link href="../css/candidate_update.css" rel="stylesheet" type="text/css"/>
    <!-- Favicon -->
	<link rel="icon" href="../icons/favicon.png" type="image/png">
</head>
<body>
	<% String message = (String) request.getAttribute("message"); %>
    <% if (message != null) { %>
        <div class="message">
            <p><%= message %></p>
        </div>
    <% } %>
    <h2>Update Candidate Details</h2>
    <form action="/candidate/updateCandidate" method="post" enctype="multipart/form-data">
    <div class="form-group">
        <label for="full_name">FULLNAME:</label>				
        <input type="text" id="full_name" name="full_name" value="${candidate.full_name}" required>
    </div>
    <div class="form-group">
        <label for="date_of_birth">Date of Birth:</label>
        <input type="date" id="date_of_birth" name="date_of_birth" value="${candidate.date_of_birth}" readonly>
    </div>
    <div class="form-group">
        <label for="nationality">Nationality:</label>
        <input type="text" id="nationality" name="nationality" value="${candidate.nationality}" readonly>
    </div>
    <div class="form-group">
        <label for="party_name">Party Name:</label>
        <input type="text" id="party_name" name="party_name" value="${candidate.party_name}" required>
    </div>
    <div class="form-group">
        <label for="party_image">Party Image:</label>
        <input type="file" id="party_image" name="party_image">
    </div>
    <div class="form-group">
        <label for="aadhar_number">Aadhar Number:</label>
        <input type="text" id="aadhar_number" name="aadhar_number" value="${candidate.aadhar_number}" readonly>
    </div>
    <button type="submit" class="btn">Update</button>
</form>

</body>
</html>
</html>