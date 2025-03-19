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
    <link href="../css/style.css" rel="stylesheet" type="text/css"/>
    <style>
        .disabled-btn { pointer-events: none; opacity: 0.6; text-decoration: line-through; }
        .status-expired { color: red; }
        .status-active { color: green; }
        .status-upcoming { color: blue; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; font-size: 16px; background-color: #ffffff; border-radius: 8px; }
        table thead { background-color: #007bff; color: white; text-transform: uppercase; }
        table th, table td { padding: 18px; text-align: center; border: 1px solid #ddd; }
        table tbody tr:hover { background-color: #e6f7ff; transform: translateY(-3px); box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); }
        table .actions-cell a { text-decoration: none; font-size: 20px; padding: 6px 10px; border-radius: 5px; color: white; background-color: #007bff; transition: background-color 0.3s ease; }
        table .actions-cell a:hover { background-color: #0056b3; }
    </style>
    <!-- Favicon -->
	<link rel="icon" href="../icons/favicon.png" type="image/png">
</head>
<body class="viewAll-body">
    <div class="election-list-container">
        <div class="header-container">
            <h1 class="election-list-title">Election List</h1>
        <!--     <a href="/">Home</a>
            <a href="/subadmin/returnDashboard">Dashboard</a>
            <a href="/admin/openLoginPage">Logout</a> -->
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
                        <a href="/elections/openElectionUpdationPage/<%= election.getElectionId() %>" class="btn btn-primary btn-edit <%= status.equals("expired") ? "disabled-btn" : "" %>">Edit</a>
                    </td>
                    <td>
                        <% if (status.equals("upcoming")) { %>
                            <a href="/candidate/listByElection?electionId=<%= election.getElectionId() %>">View Candidates</a>
                        <% } else { %>
                            <a href="/candidate/listByElection1?electionId=<%= election.getElectionId() %>">View Candidates</a>
                        <% } %>
                    </td>
                </tr>
                <% } } else { %>
                <tr>
                    <td colspan="7">No elections found.</td>
                </tr>
                <% } %>
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