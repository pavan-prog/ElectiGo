<%@page import="voting.application.admin.entities.Admin"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../css/toggle.css" rel="stylesheet" type="text/css" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" type="text/css">

<style>

        body {
            margin: 0;
            font-family: 'Roboto', Arial, sans-serif;
            background-color: #f4f4f4;
        }
 
        /* Top navigation bar styles */
        .top-nav {
            display: flex;
            justify-content: flex-start;
            align-items: center;
            background: linear-gradient(90deg, #1e3c72, #2a5298);
            padding: 10px 20px;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.2);
        }
 
        /* Button styling */
        .top-nav a {
            text-decoration: none;
            color: white;
            padding: 10px 25px;
            margin-right: 15px;
            text-align: center;
            background: linear-gradient(90deg, #ff7e5f, #feb47b);
            border-radius: 25px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.2);
            font-weight: bold;
            font-size: 16px;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
        }
 
        /* Hover effect */
        .top-nav a:hover {
            background: linear-gradient(90deg, #feb47b, #ff7e5f);
            transform: translateY(-3px);
            box-shadow: 0px 6px 10px rgba(0, 0, 0, 0.3);
        }
 
        /* Add spacing to the content below */
        .content {
            padding-top: 70px;
            text-align: center;
        }
 
        /* Responsive Design */
        @media (max-width: 768px) {
            .top-nav a {
                padding: 10px 15px;
                font-size: 14px;
            }
        }
    
/* General Styles */
/* General Styles */
html, body {
	margin: 0;
	padding: 0;
	font-family: Arial, sans-serif;
	background-image: url('/images/background.png');
	background-size: cover;
	background-repeat: no-repeat;
	background-position: center;
}

/* Ensure the body can grow with the content */
body {
	font-family: Arial, sans-serif;
	background-color: #f9f9f9;
	min-height: 100vh;
	/* Ensure the body starts with full viewport height */
}

/* Container Styling */
.admin-list-container {
	background-color: #fff;
	border: 1px solid #ddd;
	border-radius: 8px;
	padding: 20px;
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	background-color: rgba(255, 255, 255, 0.7);
	width: 90%; /* Take up 90% of the viewport width */
	margin: 20px auto;
	/* Add spacing between the container and window edges */
}

/* Header Styling */
.admin-list-container h2 {
	text-align: center;
	color: #333;
	margin-bottom: 20px;
	font-size: 24px;
	font-weight: bold;
}
/* Action Bar */
.action-bar {
	display: flex;
	justify-content: flex-end;
	margin-bottom: 15px; /* Space between button and table */
}

/* Button Styling */
.add-btn {
	background-color: #28a745; /* Green background */
	color: white;
	border: none;
	padding: 8px 12px;
	border-radius: 5px;
	cursor: pointer;
	font-size: 14px;
	transition: background-color 0.3s ease;
}
/* Styling for the Add Subadmin button */
.add-subadmin-btn {
	background-color: #28a745; /* Green background */
	color: white; /* White text */
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	font-size: 16px;
	cursor: pointer;
	transition: background-color 0.3s ease, transform 0.2s ease, box-shadow
		0.2s ease;
	margin-right: 50px;
	/* Adjust the button position slightly to the left */
}

/* Hover effect for Add Subadmin button */
.add-subadmin-btn:hover {
	background-color: #218838; /* Darker green on hover */
	transform: translateY(-3px); /* Moves the button slightly upwards */
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
	/* Adds a subtle shadow for depth */
}

.add-btn:hover {
	background-color: #218838; /* Darker green on hover */
}
/* Table Styling */
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
	background-color: #3a7bff; /* #007bff;*/
	color: white;
}

table tbody tr:nth-child(even) {
	background-color: #f2f2f2;
}

table tbody tr:hover {
	background-color: #e6f7ff;
}

/* Toggle Styling */
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
	background-color: #28a745; /* Green color when checked */
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
/* Hover effect for Toggle Slider */
.toggle-slider:hover {
	background-color: #218838; /* Slightly darker green background */
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2); /* Adds a soft shadow */
	transform: scale(1.05); /* Slightly enlarges the slider for emphasis */
	transition: transform 0.3s ease, box-shadow 0.3s ease;
}

/* For unchecked toggle button hover */
.toggle-checkbox:not(:checked)+.toggle-slider:hover {
	background-color: #bbb; /* Slightly darker grey for inactive state */
}

/* Button/Link Styling */
.actions-cell {
	display: flex;
	justify-content: center;
	align-items: center;
}

.assign-btn, .disabled-link {
	background-color: #007bff;
	color: white;
	padding: 8px 12px;
	border: none;
	border-radius: 5px;
	text-decoration: none;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.assign-btn:hover {
	background-color: #0056b3;
}

.disabled-link {
	background-color: gray;
	cursor: not-allowed;
	pointer-events: none;
}
/* Styling for the header container */
.header-container {
	display: flex; /* Flexbox layout */
	justify-content: space-between; /* Space between heading and button */
	align-items: center; /* Center items vertically */
	margin-bottom: 20px; /* Add spacing below the header */
}

/* Styling for the heading */
.header-title {
	font-size: 24px;
	font-weight: bold;
	margin: 4;
	color: #333; /* Darker color for the heading */
	margin-left: 50px; /* Adjust this value to move the title left */
}

/* Styling for the Add Subadmin button */
.add-subadmin-btn {
	background-color: #28a745; /* Green background */
	color: white; /* White text */
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	font-size: 16px;
	cursor: pointer;
	transition: background-color 0.3s ease;
	margin-right: 50px;
	/* Adjust the button position slightly to the left */
	text-decoration: none; /* Remove underline */
}

.add-subadmin-btn:hover {
	background-color: #218838; /* Darker green on hover */
}

/* Table Styling */
/* Table Styling */
table {
	width: 100%;
	border-collapse: collapse;
	margin-top: 10px;
	font-size: 16px;
	background-color: #ffffff; /* White background for the table */
	border-radius: 8px; /* Smooth corners for the table */
	overflow: hidden; /* Ensures the rounded edges are visible */
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
}

/* Table Header */
table thead {
	background-color: #007bff; /* Blue background */
	color: white; /* White text for the header */
	text-transform: uppercase; /* Capitalize text */
}

/* Table Header Styling */
table th {
	padding: 18px; /* Increased padding for headers */
	text-align: center;
	border: 1px solid #ddd;
	background-color: #3a7bff; /* Blue background */
	color: white; /* White text */
	font-weight: bold;
	transition: background-color 0.3s ease, transform 0.2s ease, box-shadow
		0.2s ease;
	cursor: pointer; /* Makes it clear the header is interactive */
}

/* Table Body */
table tbody tr {
	background-color: #f9f9f9; /* Light gray background for rows */
	border-bottom: 1px solid #ddd; /* Divider between rows */
	height: 50px; /* Increased row height */
	transition: transform 0.2s ease, background-color 0.3s ease;
}

table tbody tr:nth-child(even) {
	background-color: #f1f1f1;
	/* Slightly darker background for alternating rows */
}

table tbody tr:hover {
	background-color: #e6f7ff; /* Light blue highlight on hover */
	transform: translateY(-3px); /* Moves the row slightly upwards */
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	/* Adds a subtle shadow for depth */
}

/* Table Cells */
table td {
	padding: 18px; /* Increased padding for table cells */
	text-align: center;
	vertical-align: middle; /* Center-align text vertically */
	border-bottom: 1px solid #ddd; /* Divider between rows */
	color: #333; /* Dark text for readability */
}

/* Highlighted First Column (Serial No) */
table tbody td:first-child {
	font-weight: bold;
	color: #007bff; /* Blue text for serial number */
}

/* Actions Cell */
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
	background-color: #0056b3; /* Darker blue on hover */
}

/* No Data Row */
table tbody tr td[colspan="5"] {
	font-style: italic;
	color: #777;
	font-size: 18px;
}
/* Table Row Hover Effect */
table tbody tr {
	background-color: #f9f9f9; /* Light gray background for rows */
	border-bottom: 1px solid #ddd; /* Divider between rows */
	transition: transform 0.2s ease, background-color 0.3s ease;
}

table tbody tr:nth-child(even) {
	background-color: #f1f1f1;
	/* Slightly darker background for alternating rows */
}

table tbody tr:hover {
	background-color: #e6f7ff; /* Light blue highlight on hover */
	transform: translateY(-3px); /* Moves the row slightly upwards */
	box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	/* Adds a subtle shadow for depth */
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
			<a href="/admin/openRegistrationPage" class="add-subadmin-btn">Add Subadmin</a>
		</div>
		<%
		// Fetch the list of admins
		List<Admin> admins = (List<Admin>) request.getAttribute("adminsList");
		%>

		<table id="adminTable">
			<thead>
				<tr>
					<th>Serial No</th>
					<th>Full Name</th>
					<th>Username</th>
					<th>Email</th>
					<th>Authorize</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				<%
				int serialNo = 0;
				if (admins != null && !admins.isEmpty()) {
					for (Admin admin : admins) {
						int adminId = admin.getId();
						boolean isAuthorized = admin.isAuthorized();
				%>
				<tr>
					<td class="serial_no"><%=++serialNo%></td>
					<td><%=(admin.getFirstName() + " " + admin.getLastName()).toUpperCase()%></td>
					<td><%=admin.getUsername()%></td>
					<td><%=admin.getEmail()%></td>
					<td>
					    <label class="toggle-container">
					        <input type="checkbox" class="toggle-checkbox" <%= isAuthorized ? "checked" : "" %>
					            onclick="return confirm('Are you sure?') && (window.location='/admin/changeAuth/<%= adminId %>')">
					        <span class="toggle-slider"></span>
					    </label>
					</td>
					<td>
						<%
						if (isAuthorized) {
						%> <a href="/superadmin/openAssignElectionsPage/<%=adminId%>"
						class="assign-btn">Assign Elections</a> <%
					 } else {
					 %> <a href="#" class="disabled-link">Assign Elections</a> <%
					 }
					 %>
					</td>
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