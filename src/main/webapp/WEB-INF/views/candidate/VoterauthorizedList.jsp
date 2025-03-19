<%@page import="voting.application.candidate.entities.Candidate"%>
<%@page import="voting.application.candidate.entities.Utils"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%> <!-- Added to create a mutable list -->
<%@page import="java.util.Collections"%> <!-- Import for sorting -->
<%@page import="java.util.Comparator"%> <!-- Import for Comparator -->
 
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Authorized Candidate List</title>
    <!-- Link to the external CSS -->
    <link rel="stylesheet" type="text/css" href="../css/VoterauthorizedCandidates.css">
    <!-- Favicon -->
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
                <th>Party Logo</th>
                <th>Voting</th>
            </tr>
        </thead>
        <tbody>
            <%
            // Retrieve the list of candidates
            List<Candidate> authorizedCandidates = (List<Candidate>) request.getAttribute("authorizedCandidates");
            
            // Check if the list is not null or empty
            if (authorizedCandidates != null && !authorizedCandidates.isEmpty()) {
                // Create a mutable copy of the list (ArrayList)
                List<Candidate> mutableCandidates = new ArrayList<>(authorizedCandidates);
                
                // Sort the list by candidate name (alphabetical order)
                Collections.sort(mutableCandidates, new Comparator<Candidate>() {
                    public int compare(Candidate c1, Candidate c2) {
                        return c1.getFull_name().compareToIgnoreCase(c2.getFull_name());
                    }
                });
 
                int serialNo = 0;
                for (Candidate candidate : mutableCandidates) {
            %>
            <tr>
                <td><%= ++serialNo %></td>
                <td><%= candidate.getFull_name().toUpperCase() %></td>
                <td><%= candidate.getParty_name() %></td>
                <td>
                    <img src="data:image/png;base64,<%= Utils.getBase64Image(candidate.getParty_image()) %>" alt="Party Image" style="width:35px; height:50px"/>
                </td>
                <td>
                    <form action="/candidate/vote" method="post">
                        <input type="hidden" name="candidateId" value="<%= candidate.get_id() %>">
                        <button type="submit" class="vote-btn">Vote</button>
                    </form>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="6" style="text-align: center;">No authorized candidates available</td>
            </tr>
            <% } %>
        </tbody>
    </table>
    <a href="/" class="back-btn">Back to Home</a>
</body>
</html>