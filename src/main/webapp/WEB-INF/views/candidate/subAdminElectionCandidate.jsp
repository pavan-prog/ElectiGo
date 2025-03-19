<%@page
	import="voting.application.candidate.entities.CandidateWithElection"%>
<%@page import="voting.application.candidate.entities.Candidate"%>
<%@page import="voting.application.candidate.entities.Utils"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Candidate Election List</title>
<link href="../css/subAdminelection.css" rel="stylesheet"
	type="text/css" />
<link href="../css/toggle.css" rel="stylesheet" type="text/css" />

<style>
html, body {
	margin: 0;
	padding: 0;
	font-family: Arial, sans-serif;
	background-image: url('/images/background.png');
	background-size: cover;
	background-repeat: no-repeat;
	background-position: center;
}

body {
	font-family: Arial, sans-serif;
	background-color: #f9f9f9;
	min-height: 100vh;
}

.candidate-list-container {
	background-color: #fff;
	border: 1px solid #ddd;
	border-radius: 8px;
	padding: 20px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	background-color: rgba(255, 255, 255, 0.7);
	width: 90%; 
	margin: 20px auto;
	
}


.candidate-list-container h2 {
	text-align: center;
	color: #333;
	margin-bottom: 20px;
	font-size: 24px;
	font-weight: bold;
}
.action-bar {
	display: flex;
	justify-content: flex-end;
	margin-bottom: 15px; 
}

.add-btn {
	background-color: #28a745;
	color: white;
	border: none;
	padding: 8px 12px;
	border-radius: 5px;
	cursor: pointer;
	font-size: 14px;
	transition: background-color 0.3s ease;
}
.add-candidate-btn {
	background-color: #28a745; 
	color: white; 

	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	font-size: 16px;
	cursor: pointer;
	transition: background-color 0.3s ease, transform 0.2s ease, box-shadow
		0.2s ease;
	margin-right: 50px;
}

.add-candidate-btn:hover {
	background-color: #218838;
	transform: translateY(-3px); 
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
}

.add-btn:hover {
	background-color: #218838; 
}
table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 10px;
}

table caption {
	font-size: 18px;
	font-weight: bold;
	margin-bottom: 10px;
}

table th, table td {
	padding: 12px;
	text-align: center;
	border: 1px solid #ddd;
}

table thead {
	background-color: #3a7bff; 
	color: white;
}

table tbody tr:nth-child(even) {
	background-color: #f2f2f2;
}

table tbody tr:hover {
	background-color: #e6f7ff;
}

.toggle-container {
	display: inline-block;
	position: relative;
	width: 70px;
	height: 35px;
}

.toggle-checkbox {
	display: none;
}

.toggle-slider {
	position: absolute;
	cursor: pointer;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background-color: #ccc;
	transition: 0.4s;
	border-radius: 35px;
}

.toggle-checkbox:checked+.toggle-slider {
	background-color: #28a745; 
}

.toggle-slider:before {
	position: absolute;
	content: "";
	height: 26px;
	width: 26px;
	left: 4px;
	bottom: 4px;
	background-color: white;
	transition: 0.4s;
	border-radius: 50%;
}

.toggle-checkbox:checked+.toggle-slider:before {
	transform: translateX(35px);
}
.toggle-slider:hover {
	background-color: #218838; 
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2); 
	transform: scale(1.05); 
	transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.toggle-checkbox:not(:checked)+.toggle-slider:hover {
	background-color: #bbb; 
}

.actions-cell {
	display: flex;
	justify-content: center;
	align-items: center;
}

.header-container {
	display: flex; 
	justify-content: space-between; 
	align-items: center; 
	margin-bottom: 20px; 
}

.header-title {
	font-size: 24px;
	font-weight: bold;
	margin: 4;
	color: #333; 
	margin-left: 50px; 
}

.add-candidate-btn {
	background-color: #28a745; 
	color: white;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	font-size: 16px;
	cursor: pointer;
	transition: background-color 0.3s ease;
	margin-right: 50px;
	text-decoration: none; 
}

.add-candidate-btn:hover {
	background-color: #218838; 
}


table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 10px;
	font-size: 16px;
	background-color: #ffffff;
	border-radius: 8px; 
	overflow: hidden; 
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); }

table thead {
	background-color: #007bff; 
	color: white; 
	text-transform: uppercase; 
}

table th {
	padding: 18px;
	text-align: center;
	border: 1px solid #ddd;
	background-color: #3a7bff; 
	color: white; 
	font-weight: bold;
	transition: background-color 0.3s ease, transform 0.2s ease, box-shadow
		0.2s ease;
	cursor: pointer; 
}


table tbody tr {
	background-color: #f9f9f9; 
	border-bottom: 1px solid #ddd; 
	height: 50px; 
	transition: transform 0.2s ease, background-color 0.3s ease;
}

table tbody tr:nth-child(even) {
	background-color: #f1f1f1;
	
}

table tbody tr:hover {
	background-color: #e6f7ff; 
	transform: translateY(-3px);
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	
}

table td {
	padding: 18px; 
	text-align: center;
	vertical-align: middle; 
	border-bottom: 1px solid #ddd; 
	color: #333; 
}

table tbody td:first-child {
	font-weight: bold;
	color: #007bff; 
}

table .actions-cell a {
	text-decoration: none;
	font-size: 20px;
	padding: 6px 10px;
	border-radius: 5px;
	color: white;
	background-color: #007bff;
	transition: background-color 0.3s ease;
}

table .actions-cell a:hover {
	background-color: #0056b3; 
}

table tbody tr td[colspan="5"] {
	font-style: italic;
	color: #777;
	font-size: 18px;
}
table tbody tr {
	background-color: #f9f9f9; 
	border-bottom: 1px solid #ddd; 
	transition: transform 0.2s ease, background-color 0.3s ease;
}

table tbody tr:nth-child(even) {
	background-color: #f1f1f1;
}

table tbody tr:hover {
	background-color: #e6f7ff; 
	transform: translateY(-3px); 
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

th:after {
	position: absolute;
	right: 8px;
	visibility: hidden;
	font-size: 12px;
}

th:hover:after {
	visibility: visible;
}
</style>
<!-- Favicon -->
<link rel="icon" href="../icons/favicon.png" type="image/png">
</head>
<body>

	<div class="candidate-list-container">
		<div class="header-container">
			<h2 class="header-title">Manage Candidates</h2>
			<a href="/">Home</a>
	        <a href="/subadmin/opendashboard">Dashboard</a>
	        <a href="/admin/openLoginPage">Logout</a>
			<a href="/candidate/openRegistrationPageForSubAdmin?election_id=<%= session.getAttribute("electionId") %>" class="add-candidate-btn">Add the Candidate</a>

		</div>
		<%
		// Retrieve the candidates list from the request
		List<CandidateWithElection> candidatesWithElection = (List<CandidateWithElection>) request.getAttribute("candidateWithElection");
		%>
		<table id="candidateTable">
			<thead>
				<tr>
					<th>Serial No</th>
					<th>Candidate Name</th>
					<th>Party Name</th>
					<th>Party Logo</th>
					<th>Authorize</th>
					<th>Change Nomination</th>
					<th>Edit</th>
				

				</tr>
			</thead>
			<tbody>
				<%
				int serialNo = 0;
				if (candidatesWithElection != null && !candidatesWithElection.isEmpty()) {
					for (CandidateWithElection candidate : candidatesWithElection) {
						int candidateId = candidate.getCandidateId();
						boolean isAuthorized = candidate.getAuthorised();
				%>
				<tr>
					<td class="serial_no"><%=++serialNo%></td>
					<td><%=candidate.getFullName().toUpperCase()%></td>
					<td><%=candidate.getPartyName()%></td>
					<td>
					<img src="data:image/png;base64,<%=Utils.getBase64Image(candidate.getPartyLogo())%>"
						alt="Party Image" style="width: 35px; height: 50px" /></td>
					<td><label class="toggle-container"> <input
							type="checkbox" class="toggle-checkbox" <%if (isAuthorized) {%>
							checked <%}%>
							onclick="window.location='/candidate/changeAuthForSubAdmin/<%=candidateId%>'">
							<span class="toggle-slider"></span>
					</label></td>
					<td><a href="/candidate/changeNominationForSubAdmin/<%= candidate.getCandidateId() %>">Change Nomination</a></td>
					<td><a
						href="/candidate/updateCandidatePage?aadhar=<%=candidate.getAadharNumber()%>"
						class="btn btn-edit">Edit</a></td>
					

				</tr>
				<%
				}
				} else {
				%>
				<tr>
					<td colspan="5" style="text-align: center;">No candidates
						available</td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>
	<script>
		let sortDirection = {};
		 
		document.querySelectorAll('#candidateTable th').forEach((header, index) => {
			header.addEventListener('click', () => {
			sortTable(index);
		});
			header.style.cursor = 'pointer';
			header.title = 'Click to sort';
		});
		 
		function sortTable(columnIndex) {
		    const table = document.getElementById('candidateTable');
		    const rows = Array.from(table.tBodies[0].rows);
		    const isAscending = sortDirection[columnIndex] !== true;
		    sortDirection[columnIndex] = isAscending;
		 
		    rows.sort((rowA, rowB) => {
		        const cellA = rowA.cells[columnIndex].textContent.trim().toLowerCase();
		        const cellB = rowB.cells[columnIndex].textContent.trim().toLowerCase();
		 
		        if (!isNaN(cellA) && !isNaN(cellB)) {
		            return isAscending ? cellA - cellB : cellB - cellA;
		        }
		        return isAscending ? cellA.localeCompare(cellB) : cellB.localeCompare(cellA);
		    });
		 
		    rows.forEach(row => table.tBodies[0].appendChild(row));
		}
	</script>
</body>
</html>