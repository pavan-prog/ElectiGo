<%@page import="voting.application.admin.entities.Admin"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<style>
/* General Styles */
html, body {
	margin: 0;
	height: 100%;
	font-family: Arial, sans-serif;
	background-image: url('/images/background.png');
	background-size: cover;
	background-repeat: no-repeat;
	background-position: center;
}

body {
	font-family: Arial, sans-serif;
	background-color: #f9f9f9;
	margin: 0;
	padding: 0;
	height: 100vh; /* Full height of the viewport */
	display: flex;
	justify-content: center;
	align-items: center;
}
/* Container Styling */
.admin-list-container {
	background-color: #fff;
	border: 1px solid #ddd;
	border-radius: 8px;
	padding: 20px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	background-color: rgba(255, 255, 255, 0.7);
	width: 90%;
	height: 90%;
	overflow: auto;
}
/* Header Styling */
.admin-list-container h2 {
	text-align: center;
	color: #333;
	margin-bottom: 20px;
	font-size: 24px;
	font-weight: bold;
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
	color: #333;
	margin-left: 50px;
}
/* Table Styling */
table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 10px;
	font-size: 16px;
	background-color: #ffffff;
	border-radius: 8px;
	overflow: hidden;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

table th {
	padding: 18px;
	text-align: center;
	border: 1px solid #ddd;
	background-color: #3a7bff;
	color: white;
	font-weight: bold;
	cursor: pointer;
}

table th.sorted-asc {
	background-color: #4caf50; /* Green for ascending */
	color: white;
}

table th.sorted-desc {
	background-color: #f44336; /* Red for descending */
	color: white;
}

table td {
	padding: 12px;
	text-align: center;
	border: 1px solid #ddd;
}

table tbody tr:nth-child(even) {
	background-color: #f1f1f1;
}

table tbody tr:hover {
	background-color: #e6f7ff;
	transform: translateY(-3px);
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
}

.search-container {
	display: flex;
	justify-content: flex-end;
	margin-bottom: 20px;
	margin-right: 50px;
}

.search-box {
	padding: 10px;
	border: 1px solid #ddd;
	border-radius: 5px;
	width: 300px;
	font-size: 16px;
}

th {
	cursor: pointer;
	position: relative;
}

th:after {
	content: '\25B2'; /* Up arrow */
	position: absolute;
	right: 8px;
	visibility: hidden;
	font-size: 12px;
}

th:hover:after {
	visibility: visible;
}

[data-sort-direction="desc"] th:after {
	content: '\25BC'; /* Down arrow */
}

.btn i {
		    margin-right: 8px; /* Adds space between the icon and text */
		    font-size: 1.2rem; /* Adjust the size of the icon */
		}	
		
		
</style>
<!-- Favicon -->
<link rel="icon" href="../icons/favicon.png" type="image/png">
</head>
<body>

	<div class="admin-list-container">
		<div class="header-container">
		
	
			<h2 class="header-title">List of Sub-admins</h2>
			<a href="/" class="btn"><i class="fas fa-home"></i>Home</a>
        	<a href="/superadmin/returnDashboard" class="btn"><i class="fas fa-tachometer-alt"></i>Dashboard</a>
        	<a href="/admin/openLoginPage" class="btn"><i class="fas fa-sign-out-alt"></i>Logout</a>
			<input type="text" id="searchBox" class="search-box"
				placeholder="Search by name, username, or email..."
				onkeyup="filterAdmins()">
		</div>

		<%
		List<Admin> admins = (List<Admin>) request.getAttribute("listOfAdmins");
		%>

		<table id="adminTable">
			<thead>
				<tr>
					<th>Serial No</th>
					<th>Full Name</th>
					<th>Username</th>
					<th>Email</th>
					<th>Status</th>
				</tr>
			</thead>
			<tbody>
				<%
				int serialNo = 0;
				if (admins != null && !admins.isEmpty()) {
					for (Admin admin : admins) {
				%>
				<tr>
					<td class="serial_no"><%=++serialNo%></td>
					<td><%=(admin.getFirstName() + " " + admin.getLastName()).toUpperCase()%></td>
					<td><%=admin.getUsername()%></td>
					<td><%=admin.getEmail()%></td>
					<td><%=admin.isAuthorized() ? "Authorized" : "Unauthorized"%></td>
				</tr>
				<%
				}
				} else {
				%>
				<tr>
					<td colspan="5" style="text-align: center;">No admins
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
	 
	document.querySelectorAll('#adminTable th').forEach((header, index) => {
	header.addEventListener('click', () => {
	sortTable(index);
	});
	header.style.cursor = 'pointer';
	header.title = 'Click to sort';
	});
	 
	function sortTable(columnIndex) {
	    const table = document.getElementById('adminTable');
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
	 
	function filterAdmins() {
		const searchInput = document.getElementById('searchBox').value.toLowerCase();
		const table = document.getElementById('adminTable');
		const rows = table.getElementsByTagName('tr');
		 
		for (let i = 1; i < rows.length; i++) {
			const cells = rows[i].getElementsByTagName('td');
			let match = false;
			 
			for (let j = 1; j < cells.length - 1; j++) {
				if (cells[j] && cells[j].textContent.toLowerCase().includes(searchInput)) {
					match = true;
					break;
				}
			}
			 
			rows[i].style.display = match ? '' : 'none';
		}
	}
</script>
</body>
</html>