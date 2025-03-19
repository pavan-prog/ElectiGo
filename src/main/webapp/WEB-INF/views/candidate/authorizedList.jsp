<%@page import="voting.application.candidate.entities.Candidate"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Authorized Candidate List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f9f9f9;
            color: #333;
        }
 
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background: white;
            border: 1px solid #ccc;
        }
 
        table caption {
            font-size: 1.5em;
            font-weight: bold;
            margin-bottom: 10px;
        }
 
        th, td {
            text-align: left;
            padding: 10px;
            border: 1px solid #ddd;
        }
 
        th {
            background-color: #007BFF;
            color: white;
        }
 
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
 
        tr:hover {
            background-color: #e9ecef;
            transition: background-color 0.3s;
        }
 
        .back-btn {
            display: inline-block;
            margin: 20px auto;
            padding: 10px 15px;
            background-color: #28a745;
            color: white;
            font-size: 16px;
            text-align: center;
            border-radius: 5px;
            text-decoration: none;
        }
 
        .back-btn:hover {
            background-color: #218838;
        }
    </style>
<link rel="icon" href="../icons/favicon.png" type="image/png">
</head>
<body>
    <table>
        <caption>Authorized Candidate List</caption>
        <thead>
            <tr>
                <th>Serial No</th>
                <th>Candidate Name</th>
                <th>Party Name</th>
                <th>AadharCard Number</th>
            </tr>
        </thead>
        <tbody>
            <%
                List<Candidate> authorizedCandidates = (List<Candidate>) request.getAttribute("authorizedCandidates");
                int serialNo = 0;
 
                if (authorizedCandidates != null && !authorizedCandidates.isEmpty()) {
                    for (Candidate candidate : authorizedCandidates) {
            %>
            <tr>
                <td><%= ++serialNo %></td>
                <td><%= candidate.getFull_name().toUpperCase() %></td>
                <td><%= candidate.getParty_name() %></td>
                <td><%= candidate.getAadhar_number() %></td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="4" style="text-align: center;">No authorized candidates available</td>
            </tr>
            <% } %>
        </tbody>
    </table>
 
    <a href="/" class="back-btn">Back to Home</a>
</body>
</html>
