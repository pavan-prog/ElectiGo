<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="voting.application.election.entities.Election"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home Page</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f9;
	margin: 0;
	padding: 0;
}

.update-form {
	color: #333;
	margin-top: 20px;
	font-size: 15px;
	letter-spacing: 1px;
}

.election-updation-heading {
	text-align: center;
	color: #333;
	margin-top: 20px;
	font-size: 25px;
	letter-spacing: 2px;
}

.election-updation-heading span {
	text-align: center;
	color: red;
	margin-top: 20px;
	font-size: 25px;
	letter-spacing: 2px;
}

form {
	max-width: 600px;
	margin: 20px auto;
	padding: 20px;
	background: #fff;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

label {
	display: block;
	margin-bottom: 8px;
	font-weight: bold;
}

input[type="text"], input[type="date"], input[type="submit"] {
	width: 100%;
	padding: 10px;
	margin-bottom: 20px;
	border: 1px solid #ccc;
	border-radius: 4px;
	box-sizing: border-box;
}

input[type="submit"] {
	background-color: #28a745;
	border: none;
	color: white;
	font-size: 16px;
	cursor: pointer;
}

input[type="submit"]:hover {
	background-color: #218838;
}

.update-election-container {
	padding: 20px;
}
</style>
<script>
	function setMinEndDate() {
		var startDate = document.getElementById('startDate').value;
		document.getElementById('endDate').min = startDate;
	}
	function preventEditElectionName() {
		alert("You cannot edit the Election Name.");
	}
	document.addEventListener('DOMContentLoaded', function() {
		var today = new Date().toISOString().split('T')[0];   
		document.getElementById('startDate').setAttribute('min', today);
	});
</script>
<!-- Favicon -->
<link rel="icon" href="../icons/favicon.png" type="image/png">
</head>
<body>
	<%
	Election election = (Election) request.getAttribute("election");
	%>
	<div class="update-election-container">
		<p class="election-updation-heading">
			ELECTION <span>UPDATION</span>
		</p>
		<form action="/elections/updateElection" method="post"
			class="update-form">
			<label for="electionName">Election Name:</label> 
			<input type="text"
				id="electionName" name="electionName"
				value="<%=election.getElectionName()%>"
				onclick="preventEditElectionName()" readonly> 
			<label
				for="startDate">Start Date:</label> 
				<input type="date"
				id="startDate" name="startDate"
				value="<%=election.getElectionStartDate()%>" required
				onchange="setMinEndDate()"> <label for="endDate">End
				Date:</label> <input type="date" id="endDate" name="endDate"
				value="<%=election.getElectionEndDate()%>" required> 
				<input type="submit" value="U P D A T E">
		</form>
	</div>
</body>
</html>