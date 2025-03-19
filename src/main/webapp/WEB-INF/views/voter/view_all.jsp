<%@page import="voting.application.voter.entities.Voter"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View All Voters</title>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f9;
        margin: 0;
        padding: 0;
        background-image: url('/images/background.png'); /* Add your background image path here */
        background-size: cover;
        background-position: center;
        background-repeat: no-repeat;
    }

    nav {
        background-color: #333;
        width: 100%;
        overflow: hidden;
        padding: 10px 0;
        position: fixed;
        top: 0;
        left: 0;
        z-index: 1000;
    }

    nav a {
        float: left;
        display: block;
        color: white;
        text-align: center;
        padding: 14px 20px;
        text-decoration: none;
    }

    nav a:hover {
        background-color: #ddd;
        color: black;
    }

    h1 {
        text-align: center;
        color: #333;
        margin-top: 80px; 
        font-size: 2.5em;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.2);
    }

    .content {
        margin-top: 80px; 
        width: 100%;
        display: flex;
        justify-content: center;
    }

    table {
        width: 80%;
        margin: 20px auto;
        border-collapse: collapse;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        background-color: #fff;
        border-radius: 10px;
        overflow: hidden;
    }

    table, th, td {
        border: 1px solid #ddd;
    }

    th, td {
        padding: 10px;
        text-align: left;
    }

    th {
        background-color: #4CAF50;
        color: white;
        font-size: 1.2em;
        text-transform: uppercase;
    }

    tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    tr:hover {
        background-color: #f1f1f1;
        cursor: pointer;
    }

    .delete-link {
        color: red;
        text-decoration: none;
        font-weight: bold;
    }

    .delete-link:hover {
        text-decoration: underline;
        color: darkred;
    }

    .message {
        width: 80%;
        margin: 20px auto;
        padding: 10px;
        text-align: center;
        background-color: #e7f3fe;
        border: 1px solid #b3d4fc;
        color: #31708f;
        border-radius: 5px;
    }

    .switch {
        position: relative;
        display: inline-block;
        width: 34px;
        height: 20px;
    }

    .switch input {
        opacity: 0;
        width: 0;
        height: 0;
    }

    .slider {
        position: absolute;
        cursor: pointer;
        top: 0;
        left: 0;
        right: 0;
        bottom: 0;
        background-color: red; 
        transition: .4s;
        border-radius: 34px;
    }

    .slider:before {
        position: absolute;
        content: "";
        height: 14px;
        width: 14px;
        left: 3px;
        bottom: 3px;
        background-color: white;
        transition: .4s;
        border-radius: 50%;
    }

    input:checked + .slider {
        background-color: green; 
    }

    input:checked + .slider:before {
        transform: translateX(14px);
    }

    a {
        text-decoration: none;
        color: #4CAF50;
        padding: 10px;
        font-weight: bold;
    }

    a:hover {
        color: #45a049;
    }
</style>
</head>
<body>

    <nav>
        <a href="/">Home</a>
        <a href="/subadmin/opendashboard">Dashboard</a>
    </nav>

    <div class="content">
        <div>
            <% 
                List<Voter> voters = (List<Voter>)request.getAttribute("listOfVoters");
            %>
                
            <table>
                <caption>Voters List</caption>
                <tr>
                    <th>Serial No</th>
                    <th>Full Name</th>
                    <th>Date Of Birth</th>
                    <th>Mobile No</th>
                    <th>Aadhar No</th>
                    <th>Nationality</th>
                    <th>Authorized</th>
                    <th>Action</th>
                </tr>
                
                <% 
                    int serialNo = 0;
                    for (Voter voter : voters) { 
                        String aadharNumber = voter.getAadharNumber();
                %>
                <tr>
                    <td class="serial_no"><%= ++serialNo %></td>
                    <td><%= voter.getFullName() %></td>
                    <td><%= voter.getDateOfBirth() %></td>
                    <td><%= voter.getMobile() %></td>
                    <td><%= voter.getAadharNumber() %></td>
                    <td><%= voter.getNationality() %></td>
                    <td>
                        <label class="switch">
                            <input type="checkbox" <%= voter.isAuthorized() ? "checked" : "" %> onclick="toggleAuthority('<%= aadharNumber %>')">
                            <span class="slider round"></span>
                        </label>
                    </td>
                    <td><a href="/voter/delete/<%= aadharNumber %>" class="delete-link" onclick="return confirmDelete()">Delete</a></td>
                </tr>
                <% } %>
                
            </table>
        </div>
    </div>
    
    <script>
        function toggleAuthority(aadharNumber) {
            window.location.href = '/voter/changeAuth/' + aadharNumber;
        }

        function confirmDelete() {
            if (confirm("Are you sure you want to delete this voter?")) {
                alert("Deleted successfully");
                return true;
            }
            return false;
        }
        if (performance.navigation.type === 2) {
            location.reload(true);
        }
    </script>
</body>
</html>