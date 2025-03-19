<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Voter Participation Report</title>
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
	<link rel="icon" href="../icons/favicon.png" type="image/png">
</head>
<body>
    <h2>Voter Participation Report</h2>
    <table>
        <thead>
            <tr>
                <th>Election Name</th>
                <th>Total Voters</th>
            </tr>
        </thead>
        <tbody>
            <%
                // Assuming reportData is an attribute added to the model with a List of Maps
                List<Map<String, Object>> voterParticipationData = (List<Map<String, Object>>) request.getAttribute("voterParticipationData");

                if (voterParticipationData != null) {
                    for (Map<String, Object> report : voterParticipationData) {
                        String electionName = (String) report.get("election_name");
                        Long totalVoters = (Long) report.get("total_voters");  // Assuming total_voters is stored as Long
            %>
                        <tr>
                            <td><%= electionName %></td>
                            <td><%= totalVoters %></td>
                        </tr>
            <%
                    }
                } else {
            %>
                    <tr>
                        <td colspan="2">No data available</td>
                    </tr>
            <%
                }
            %>
        </tbody>
    </table>
</body>
</html>
