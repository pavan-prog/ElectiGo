<%@page import="java.util.List"%>
<%@page import="voting.application.election.entities.Election"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Election List</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" type="text/css">
    
    <style>
	   
		
		body {
		    margin: 0;
		    padding: 0;
		    box-sizing: border-box;
		    background: linear-gradient(44deg, orange, white, green); 
		    min-height: 100vh;
		    width: 100%;
		    background-attachment: fixed;
		    overflow: auto;
		    animation: wave-animation 5s infinite; 
		}
		
		@keyframes wave-animation {
		    0% {
		        background-position: 0% 50%;
		    }
		    50% {
		        background-position: 100% 50%;
		    }
		    100% {
		        background-position: 0% 50%;
		    }
		}
		
		body {
		    background-size: 200% 200%; }
		
    
	    body.viewAll-body {
		    margin: 0;
		    padding: 20px;
		    box-sizing: border-box;
		}
    
        .disabled-btn {
            pointer-events: none;
            opacity: 0.6;
            text-decoration: line-through;
        }
        .status-expired {
            color: red;
        }
        .status-active {
            color: green;
        }
        .status-upcoming {
            color: blue;
        }
		.header-container {
			display: flex; 
			justify-content: space-between; 
			align-items: center;
			margin-bottom: 20px; 
			position: relative;
    		z-index: 1;
		}

		.header-title {
			font-size: 24px;
			font-weight: bold;
			margin: 4;
			color: #333;
			margin-left: 50px; 
		}
		.election-list-container {
		    margin-top: 20px; 
		    background-color: #fff;
		    border: 1px solid #ddd; 
		    border-radius: 8px;
		    padding: 20px;
		    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
		    background-color: rgba(255, 255, 255, 0.7);
		    width: 95%;
		    margin: 20px auto; 
		    position: relative; 
    		top: 25px;
		}
		
		.election-list-container h1 {
			text-align: center;
			color: #333;
			margin-bottom: 20px;
			font-size: 24px;
			font-weight: bold;
		}
		
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

		table thead {
			background-color: #007bff; 
			color: white; 
			text-transform: uppercase; 
		}
		/* Table Header Styling */
		table th {
			padding: 18px;
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
				table thead {
					background-color: #3a7bff; 
					color: white;
				}
				th:after {
			content: '\25B2'; 
			position: absolute;
			right: 8px;
			visibility: hidden;
			font-size: 12px;
		}
		
		th:hover:after {
			visibility: visible;
		}
		.disabled-btn {
		    pointer-events: none;
		    opacity: 0.6;
		    text-decoration: none; 
		}
		
		
		[data-sort-direction="desc"] th:after {
			content: '\25BC'; 
		}
		
		.btn i {
		    margin-right: 8px; 
		    font-size: 1.2rem;
		}
		
		
		@media (max-width: 768px) {
		    table {
		        display: block;
		        overflow-x: auto;
		        white-space: nowrap;
		    }
		}
		.custom-navbar {
    background-color: #fb8f2a88; 
    border-bottom: 2px solid #fff; 
}

.custom-navbar .navbar-brand,
.custom-navbar .nav-link {
    color: #fff !important; 
    font-weight: bold;
}

.custom-navbar .navbar-toggler-icon {
    background-color: #fff; 
}
		
		
    </style>
    <!-- Favicon -->
	<link rel="icon" href="../icons/favicon.png" type="image/png">
</head>
<body class="viewAll-body">

	 <nav class="navbar navbar-expand-lg custom-navbar fixed-top">
	    <a class="navbar-brand" href="/"><i class="fas fa-home"></i> Home</a>
	    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
	        <span class="navbar-toggler-icon"></span>
	    </button>
	    <div class="collapse navbar-collapse" id="navbarNav">
	        <ul class="navbar-nav ml-auto">
	            <li class="nav-item">
	                <a class="nav-link" href="/superadmin/returnDashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
	            </li>
	            <li class="nav-item">
	                <a class="nav-link" href="/admin/logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
	            </li>
	        </ul>
	    </div>
	</nav>
    
    <div class="election-list-container">
        <div class="header-container">
            <h1 class="election-list-title">Election List</h1>
			<a href="/"  class="btn"><i class="fas fa-home"></i>Home</a> 
        	<a href="/superadmin/returnDashboard"  class="btn"><i class="fas fa-tachometer-alt"></i>Dashboard</a>
			<a href="/admin/logout" class="btn"><i class="fas fa-sign-out-alt"></i>Logout</a>
            <a href="/elections/openElectionInsertionPage" class="btn btn-success btn-create"><i class="fas fa-plus-circle"></i>Create New Election</a>
        </div>
        <table id="electionTable" class="table table-bordered election-table">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Election Name</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Status</th>
                    <th>Operation</th>
                    <th>Candidates</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    List<Election> elections = (List<Election>) request.getAttribute("listOfElections");
                    if (elections != null) {
                        LocalDate currentDate = LocalDate.now();
                        int serialNumber = 1;
                        for (Election election : elections) {
                            LocalDate startDate = LocalDate.parse(election.getElectionStartDate().toString());
                            LocalDate endDate = LocalDate.parse(election.getElectionEndDate().toString());
                            String status;
                            if (startDate.isAfter(currentDate)) {
                                status = "upcoming";
                            } else if (endDate.isBefore(currentDate)) {
                                status = "expired";
                            } else {
                                status = "active";
                            }
                %>
                <tr>
                    <td><%= serialNumber++ %></td>
                    <td><%= election.getElectionName() %></td>
                    <td><%= election.getElectionStartDate() %></td>
                    <td><%= election.getElectionEndDate() %></td>
                    <td class="status-<%= status %>"><%= status %></td>
                    <td>
                        <a href="/elections/openElectionUpdationPage/<%= election.getElectionId() %>" class="btn btn-primary btn-edit <%= status.equals("expired") || status.equals("active") ? "disabled-btn" : "" %>">Edit</a>
                        <!-- <a href="/elections/openElectionDeletionPage/<%-- <%= election.getElectionId() %>"--%> class="btn btn-danger btn-delete <%-- <%= status.equals("expired") --%>? "disabled-btn" : "" %>">Delete</a> -->
                    </td>
                    <td>
                        <a href="/candidate/listByElection?electionId=<%= election.getElectionId() %>" class="btn btn-primary btn-edit <%= status.equals("expired") || status.equals("active") ? "disabled-btn" : "" %>">Manage Candidates</a>
                    </td>
                </tr>
                <% 
                        }
                    } else {
                %>
                <tr>
                    <td colspan="7">No elections found.</td>
                </tr>
                <% 
                    }
                %>
            </tbody>
        </table>
        
    </div>
    <script>
		let sortDirection = {};
		 
		document.querySelectorAll('#electionTable th').forEach((header, index) => {
			header.addEventListener('click', () => {
			sortTable(index);
		});
			header.style.cursor = 'pointer';
			header.title = 'Click to sort';
		});
		 
		function sortTable(columnIndex) {
		    const table = document.getElementById('electionTable');
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
			const table = document.getElementById('electionTable');
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
