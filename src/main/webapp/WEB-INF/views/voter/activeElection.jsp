<%@page import="java.util.List"%>
<%@ page import="java.util.Map" %>
<%@page import="voting.application.election.entities.Election"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Favicon -->
<link rel="icon" href="../icons/favicon.png" type="image/png">
</head>

<body class="viewAll-body">

    <div class="navbar">
        <a href="/voter/opendashboard">Dashboard</a>
        <a href="/voter/openhomepage">Home</a>
        <a href="/voter/logout">Logout</a>
    </div>

    <div class="election-list-container">
        <div class="header-container">
            <h1 class="election-list-title">Election List</h1>
        </div>
        <table id="electionTable" class="table table-bordered election-table">
            <thead>
                <tr>
                    <th>Election Name</th>
                    <th>Start Date</th>
                    <th>End Date</th>
                    <th>Candidates</th>
                    <th>Voter Status</th>
                </tr>
            </thead>
            <tbody>
                <%
                List<Election> elections = (List<Election>) request.getAttribute("listOfElections");
                int voterId = (int) request.getAttribute("voterId");
                Map<Integer, Boolean> votingStatusMap = (Map<Integer, Boolean>) request.getAttribute("votingStatusMap");

                if (elections != null) {
                    LocalDate currentDate = LocalDate.now();
                    for (Election election : elections) {
                        LocalDate startDate = LocalDate.parse(election.getElectionStartDate().toString());
                        LocalDate endDate = LocalDate.parse(election.getElectionEndDate().toString());
                        if (!startDate.isAfter(currentDate) && !endDate.isBefore(currentDate)) {
                            boolean isVoted = votingStatusMap.get(election.getElectionId());
                %>
                <tr>
                    <td><%=election.getElectionName()%></td>
                    <td><%=election.getElectionStartDate()%></td>
                    <td><%=election.getElectionEndDate()%></td>
                    <td>
                        <% if (!isVoted) { %>
                            <a href="/voter/openVotingPage/<%=election.getElectionId()%>/<%= voterId%>" class="button button-green">View Candidates</a>
                        <% } else { %>
                            <span class="button button-grey">View Candidates</span>
                        <% } %>
                    </td>
                    <td><%= isVoted ? "You already voted" : "Not voted" %></td>
                </tr>
                <%
                        }
                    }
                } else {
                %>
                <tr>
                    <td colspan="5">No elections found.</td>
                </tr>
                <%
                }
                %>
            </tbody>
        </table>
    </div>
</body>
<style>
    body {
        display: flex;
        flex-direction: column;
        align-items: center;
        min-height: 100vh;
        margin: 0;
        font-family: Arial, sans-serif;
        background-image: url('/images/background.png'); 
        background-size: cover;
        background-position: center;
    }

    .navbar {
        width: 100%;
        background-color: rgba(0, 123, 255, 0.8); 
        padding: 10px 0;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }

    .navbar a {
        color: white;
        text-decoration: none;
        padding: 14px 20px;
        display: inline-block;
        font-size: 1.2em;
    }

    .navbar a:hover {
        background-color: rgba(0, 123, 255, 1); 
    }

    .election-list-container {
        width: 80%;
        margin: 50px auto;
        background: rgba(255, 255, 255, 0.8); 
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        backdrop-filter: blur(10px); 
    }

    .header-container {
        text-align: center;
        margin-bottom: 20px;
    }

    .election-list-title {
        font-size: 2.5em;
        color: #343a40;
        margin: 0;
    }

    .table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
        background-color: rgba(255, 255, 255, 0.8); 
    }

    .table th, .table td {
        padding: 15px;
        text-align: left;
        border: 1px solid #dee2e6;
        background-color: rgba(255, 255, 255, 0.8); 
    }

    .table th {
        background-color: rgba(0, 123, 255, 0.8); 
        color: #ffffff;
    }

    .table tr:nth-child(even) {
        background-color: rgba(248, 249, 250, 0.8); 
    }

    .table tr:hover {
        background-color: rgba(226, 230, 234, 0.8); 
    }

    .button {
        display: inline-block;
        padding: 10px 20px;
        font-size: 1em;
        color: #ffffff;
        text-align: center;
        text-decoration: none;
        border-radius: 5px;
        transition: background-color 0.3s;
    }

    .button-green {
        background-color: #28a745; 
    }

    .button-green:hover {
        background-color: #218838;
    }

    .button-grey {
        background-color: #6c757d; 
    }

    .button-grey:hover {
        background-color: #5a6268; 
    }
</style>
</html>