<%@page import="java.util.List"%>
<%@page import="voting.application.election.entities.Election"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.time.LocalDate"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Assign Elections</title>
    <link href="/css/style.css" rel="stylesheet" type="text/css">
    <link href="/css/assign_elections.css" rel="stylesheet" type="text/css">
    
    <!-- Favicon -->
	<link rel="icon" href="../icons/favicon.png" type="image/png">
</head>
<body>
 
<div class="container">
    <button class="close-btn" onclick="window.history.back();"></button>
    <h2>Assign Elections <h2>
    <h3>Sub-admin: <%=request.getAttribute("subAdminName")%></h3>
 
    <form action="/superadmin/assignElections" method="post">
        <input type="hidden" name="subAdminId" value="<%=request.getAttribute("subAdminId")%>">
 
        <table>
            <thead>
                <tr>
                    <th>Election Type</th>
                    <th>Assign</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Election> elections = (List<Election>) request.getAttribute("elections");
                    List<Integer> assignedElectionIds = (List<Integer>) request.getAttribute("assignedElectionIds");
                    LocalDate currentDate = LocalDate.now();
                    for (Election election : elections) {
                        boolean isAssigned = assignedElectionIds.contains(election.getElectionId());
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
                 
                        if(status != "expired"){
                %>
              
                <tr>
                    <td>
                        <%= election.getElectionName() %></td>
                    <td>
                        <input type="checkbox" name="electionIds" value="<%= election.getElectionId() %>"
                               <% if (isAssigned) { %>checked<% } %>>
                    </td>
                </tr>
                <% } }%>
            </tbody>
        </table>
 
        <button type="submit" class="btn">Save Assignments</button>
    </form>
    <!-- Green glow at the bottom-left corner (both horizontal and vertical) -->
<div class="green-bottom-horizontal"></div>
<div class="green-bottom-vertical"></div>
</div>
 
</body>
</html>