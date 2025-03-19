<%@page import="voting.application.candidate.entities.Candidate"%>
<%@page import="voting.application.candidate.entities.CandidateWithElection"%>
<%@page import="voting.application.candidate.entities.Utils"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- Favicon -->
<link rel="icon" href="../icons/favicon.png" type="image/png">
</head>
<body>
    <div class="navbar">
        <a href="/voter/home">Home</a>
        <a href="/voter/opendashboard">Dashboard</a>
        <a href="/voter/logout">Logout</a>
    </div>

    <div class="container">
        <%
        List<CandidateWithElection> candidatesList = (List<CandidateWithElection>) request.getAttribute("candidatesList");
        int voterId = (int) request.getAttribute("voterId");
        %>

        <table>
            <tr>
                <th>Serial No</th>
                <th>Full Name</th>
                <th>Party Name</th>
                <th>Party Logo</th>
                <th>Vote here</th>
            </tr>
            <%
            int serialNo = 0;
            for (CandidateWithElection candidate : candidatesList) {
            %>
            <tr>
                <td class="serial_no"><%=++serialNo%></td>
                <td><%=candidate.getFullName()%></td>
                <td><%=candidate.getPartyName()%></td>
                <td><img src="data:image/png;base64,<%=Utils.getBase64Image(candidate.getPartyLogo())%>" alt="Party Image" style="width: 100px; height: 100px" /></td>
                <td>
                    <a href="#" class="vote-link" onclick="castVote(<%=candidate.getCandidateId()%>, <%=candidate.getElectionId()%>,<%=voterId%>)">V O T E</a>
                    <div class="red-light"></div>
                </td>
            </tr>
            <%
            }
            %>
        </table>
        <br>
    </div>

    <script>
    function castVote(candidateId, electionId, voterId) {
        if (confirm("Are you voting this candidate?")) {
            alert("Your vote casted successfully");
            window.location.href = "/voter/castVote/" + candidateId + "/" + electionId + "/" + voterId;
        }
    }
    </script>
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

    .container {
        width: 80%;
        max-width: 800px;
        margin: 0 auto;
        padding: 20px;
        border: 1px solid #ccc;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        text-align: center;
        background-color: rgba(255, 255, 255, 0.5); 
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        background-color: rgba(255, 255, 255, 0.5); 
    }

    th, td {
        padding: 10px;
        border: 1px solid #ccc;
        background-color: rgba(255, 255, 255, 0.5); 
    }

    th {
        background-color: rgba(244, 244, 244, 0.5);
        }
        

    .red-light {
        width: 10px;
        height: 10px;
        background-color: red;
        border-radius: 50%;
        margin-right: 10px;
        opacity: 0;
        transition: opacity 0.3s;
        display: inline-block;
    }

    .vote-link {
        color: blue;
        text-decoration: none;
        position: relative;
    }

    .vote-link:hover + .red-light {
        animation: blink 1s infinite;
    }

    @keyframes blink {
        0%, 100% { opacity: 1; }
        50% { opacity: 0; }
    }
</style>
</html>