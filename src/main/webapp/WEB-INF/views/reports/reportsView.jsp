<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Election Reports</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
            color: #333;
        }

        h2 {
            text-align: center;
            font-size: 24px;
            margin-top: 30px;
            color: #4CAF50;
        }

        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 12px 15px;
            text-align: center;
            border: 1px solid #ddd;
        }

        th {
            background-color: #4CAF50;
            color: white;
            font-weight: bold;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        td[colspan="2"] {
            text-align: center;
            font-style: italic;
            color: #777;
        }

        @media screen and (max-width: 768px) {
            table {
                width: 100%;
                margin: 10px 0;
            }

            th, td {
                padding: 8px 10px;
            }

            h2 {
                font-size: 20px;
            }
        }
    </style>
    <!-- Favicon -->
	<link rel="icon" href="../icons/favicon.png" type="image/png">
</head>
<body>
    <h2>Election Reports</h2>
    <table>
        <thead>
            <tr>
                <th>Election Name</th>
                <th>Total Votes</th>
            </tr>
        </thead>
        <tbody>
            <% 
                // Loop through the report data passed from the controller
                List<Map<String, Object>> reportData = (List<Map<String, Object>>) request.getAttribute("reportData");
                if (reportData != null && !reportData.isEmpty()) {
                    for (Map<String, Object> report : reportData) {
                        String electionName = (String) report.get("election_name");
                        Long totalVotes = (Long) report.get("total_votes");  // Changed to Long to avoid casting errors
            %>
                <tr>
                    <td><%= electionName %></td>
                    <td><%= totalVotes %></td>
                </tr>
            <% 
                    }
                } else {
            %>
                <tr>
                    <td colspan="2">No data available</td>
                </tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>
