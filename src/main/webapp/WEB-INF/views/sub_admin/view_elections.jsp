<%@ page import="voting.application.election.entities.Election" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Assigned Elections</title>
    <link href="../css/style.css" rel="stylesheet" type="text/css" />
    <link href="../css/toggle.css" rel="stylesheet" type="text/css" />
    <div class="vamshi">
    
        <a href="/">Home</a>
        <a href="/subadmin/opendashboard">Dashboard</a>
    
    </div>
</head>
<body>
    <%
        // Retrieve elections list from the request attribute
        List<Election> elections = (List<Election>) request.getAttribute("listOfElections");
    %>
    <table>
        <caption>Assigned Elections</caption>
        <thead>
            <tr>
                <th>Serial No</th>
                <th>Name</th>
                <th>Start Date</th>
                <th>End Date</th>
                <th scope="col">Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                int serialNo = 0;
                if (elections != null && !elections.isEmpty()) {
                    LocalDate currentDate = LocalDate.now();
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
 
                        // Only display rows for elections with "upcoming" status
                        if ("upcoming".equals(status)) {
                            int electionId = election.getElectionId();
            %>
            <tr>
                <td><%= ++serialNo %></td>
                <td><%= election.getElectionName() %></td>
                <td><%= election.getElectionStartDate() %></td>
                <td><%= election.getElectionEndDate() %></td>
                <td class="status-<%= status %>"><%= status %></td>
                <td>
                    <button onclick="window.location.href='/candidate/listByElectionForSubAdmin?electionId=<%= electionId %>'">View Candidate</button>
                </td>
            </tr>
            <%
                        }
                    }
                } else {
            %>
            <tr>
                <td colspan="6" style="text-align: center;">No elections assigned to you.</td>
            </tr>
            <% } %>
        </tbody>
    </table>
</body>
<style>

body {
    font-family: Arial, sans-serif;
    background-color: #f8f9fa;
    margin: 0;
    padding: 0;
}

.vamshi {
    background-color: #007bff;
    padding: 10px;
    text-align: center;
    position: fixed;
    width: 100%;
    top: 0;
    z-index: 1000;
    display: flex;
    justify-content: center;
}

body {
    padding-top: 50px; 
}

.vamshi a {
    color: white;
    margin: 0 15px;
    text-decoration: none;
    font-size: 18px;
    letter-spacing: 2px; 
}

.vamshi a:hover {
    text-decoration: underline;
}

.table-container {
    max-width: 1200px;
    margin: 20px auto;
    padding: 20px;
    background-color: rgba(255, 255, 255, 0.8); 
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    margin-left: 50px; 
    margin-right: 40px; 
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
    font-size: 16px;
    background-color: #ffffff;
    border-radius: 8px;
     margin-left: 50px; 
    margin-right: 40px; 
}

table thead {
    background-color: #007bff;
    color: white;
    text-transform: uppercase;
}

table th, table td {
    padding: 18px;
    text-align: center;
    border: 1px solid #ddd;
}

table tbody tr:hover {
    background-color: #e6f7ff;
    transform: translateY(-3px);
    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
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

button {
    padding: 6px 12px;
    font-size: 16px;
    color: white;
    background-color: #007bff;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

button:hover {
    background-color: #0056b3;
}


</style>
</html>