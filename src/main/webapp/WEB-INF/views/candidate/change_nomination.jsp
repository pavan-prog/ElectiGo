<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="voting.application.election.entities.Election" %>
<!DOCTYPE html>
<html>
<head>
    <title>Change Candidate Nomination</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .container {
            width: 80%;
            margin: auto;
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
        }
        table th, table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: center;
        }
        table th {
            background: #007bff;
            color: #fff;
        }
        .form-actions {
            text-align: center;
            margin-top: 20px;
        }
        .form-actions button {
            padding: 10px 20px;
            background: #28a745;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .form-actions button:hover {
            background: #218838;
        }
        
.close {
    color: #aaa;
    float: right;
    font-size: 28px;
    font-weight: bold;
}
 
.close:hover,
.close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}
.close-btn {
    position: absolute;
    top: 10px;
    right: 10px;
    background-color: transparent;
    border: none;
    font-size: 28px; 
    color: #333; 
    cursor: pointer;
    padding: 5px 8px;
    border-radius: 50%;
    transition: all 0.3s ease;
    width: 30px; 
    height: 30px;
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 10; 
}
 
.close-btn:hover {
    background-color: #ff6f61; 
    color: white;
    transform: scale(1.2); 
}
 
.close-btn:active {
    background-color: #e03e2f;
    transform: scale(1.1); 
}
 
.close-btn:focus {
    outline: none;
    box-shadow: 0 0 0 3px rgba(255, 111, 97, 0.5); 
}
 
.close-btn::before {
    content: "×"; 
    font-size: 22px; 
    font-weight: bold;
}
 
    </style>
<link rel="icon" href="../icons/favicon.png" type="image/png">
</head>
<body>
    <div class="container">
	    <button class="close-btn" onclick="window.history.back();"></button>
	    <h2>Change Nomination</h2>
	    <h3>Candidate: <%=request.getAttribute("candidateName")%></h3>
 
        <h2>Change Candidate Nomination</h2>
        <form action="/candidate/updateNomination" method="post">
            <input type="hidden" name="candidateId" value="<%=request.getAttribute("candidateId")%>">
            <table>
                <thead>
                    <tr>
                        <th>Election ID</th>
                        <th>Election Name</th>
                        <th>Start Date</th>
                        <th>End Date</th>
                        <th>Nominate</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        List<Election> elections = (List<Election>) request.getAttribute("elections");
            	        Integer nominatedElectionId = (Integer) request.getAttribute("nominatedElectionId");
                        for (Election election : elections) {

                        	boolean isAssigned = (nominatedElectionId != null && nominatedElectionId == election.getElectionId());

                    %>
                    <tr>
                        <td><%= election.getElectionId() %></td>
                        <td><%= election.getElectionName() %></td>
                        <td><%= election.getElectionStartDate() %></td>
                        <td><%= election.getElectionEndDate() %></td>
                        <td>
                            <input 
                                type="radio" 
                                name="electionId" 
                                value="<%= election.getElectionId() %>" 
                                <%= election.getElectionId() == nominatedElectionId ? "checked" : "" %>>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <div class="form-actions">
                <button type="submit">Submit</button>
            </div>
        </form>
    </div>
</body>
</html>
