<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@page import="voting.application.voter.entities.Voter"%>
<%@page import="voting.application.election.entities.Election"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Voter | Dashboard</title>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<!-- Favicon -->
<link rel="icon" href="../icons/favicon.png" type="image/png">
</head>	
<body>

    <%
    Voter voter = (Voter) request.getAttribute("voter");
    if (voter != null) {
    %>
    <nav>
        <ul>
            <li><a href="/voter/opendashboard">Dashboard</a></li>
            <li><a href="/voter/openhomepage">Home</a></li>
            <li><a href="/voter/logout">Logout</a></li>
        </ul>
    </nav>
    
    <p class="welcome-message">WELCOME <%= voter.getFullName() %></p>
    
    <div class="vote-container">
        <a href="#" class="profile-button" onclick="toggleModal()"> 
            <i class="fas fa-user profile-icon"></i> Profile
        </a>

        <div class="links">
            <a href="/voter/openActiveElection/<%= voter.getId()%>" class="view-elections-link">CAST YOUR VOTE HERE</a>

        </div>
             <br>
    </div>
<br><br>
    <div id="profileModal" class="modal">
        <div class="modal-content">
            <span class="close" onclick="toggleModal()">&times;</span>
            <div class="voter-info">
                <table>
                    <tr>
                        <th>Voter Id</th>
                        <td><%=voter.getId()%></td>
                    </tr>
                    <tr>
                        <th>Full Name</th>
                        <td><%=voter.getFullName()%></td>
                    </tr>
                    <tr>
                        <th>Aadhar Number (<span style="color:red; font-size:10px">Not Editable</span>)</th>
                        <td><%=voter.getAadharNumber()%></td>
                    </tr>
                    <tr>
                        <th>Mobile</th>
                        <td><%=voter.getMobile()%></td>
                    </tr>
                    <tr>
                        <th>Date of Birth(<span style="color:red; font-size:10px">Not Editable</span>)</th>
                        <td><%=voter.getDateOfBirth()%></td>
                    </tr>
                    <tr>
                        <th>Nationality (<span style="color:red; font-size:10px">Not Editable</span>)</th>
                        <td><%=voter.getNationality()%></td>
                    </tr>
                </table>

                <br><br>
                <a href='/voter/edit/<%=voter.getAadharNumber()%>' class='edit-link'>Edit</a>

                <%
                } else {
                out.print("<div>No voter data available.</div>");
                }
                %>
            </div>
        </div>
    </div>

    <div class="instructions">
        <h2>Instructions to Cast Your Vote Online</h2>
        <ul>
            <li>Log in to your voter account using your credentials.</li>
            <li>Navigate to the 'Vote' section on the dashboard.</li>
            <li>Select the active election you wish to participate in.</li>
            <li>Review the candidates and their manifestos.</li>
            <li>Cast your vote by selecting your preferred candidate.</li>
            <li>Confirm your vote to ensure it is recorded.</li>
            <li>Log out of your account once you have finished voting.</li>
        </ul>
    </div>

    <div class="contact-us">
        <h2>Contact Us</h2>
        <p>Email: support@PrajaVote.com</p>
        <p>Phone: +91-1234567890</p>
        <p>Address: 123 Kolkata, New Town, India</p>
    </div>

    <script>
        function toggleModal() {
            var modal = document.getElementById("profileModal");
            modal.style.display = (modal.style.display === "block") ? "none" : "block";
        }
    </script>


</body>
<style>
    body {
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        align-items: center;
        min-height: 100vh;
        margin: 0;
        font-family: Arial, sans-serif;
        background-image: url('/images/background.png'); 
        background-size: cover;
        background-position: center;
    }

 nav {
        width: 100%;
        background-color: rgba(0, 123, 255, 0.8); 
        padding: 30px 0;
        box-shadow: 0 5px 15px rgba(0, 0, 128, 0.3);
    }

    nav ul {
        list-style: none;
        display: flex;
        margin: 0;
        padding: 0;
    }

    nav ul li {
        margin: 0 15px;
    }

    nav ul li a {
        color: #ffffff;
        text-decoration: none;
        font-size: 1.2em;
        transition: color 0.3s;
    }

    nav ul li a:hover {
        color: #ff9933; /* Saffron color */
    }

    .profile-button {
        position: absolute;
        top: 20px;
        right: 20px;
        background-color: white; 
        color: #000; 
        border: none;
        padding: 10px 20px;
        border-radius: 50px;
        cursor: pointer;
        display: flex;
        align-items: center;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        transition: background-color 0.3s, box-shadow 0.3s;
    }

    .profile-button .profile-icon {
        width: 20px;
        height: 20px;
        margin-right: 10px;
    }

    .profile-button:hover {
        background-color: #f1f1f1; 
        box-shadow: 0 8px 20px rgba(0, 0, 0, 0.5);
    }

    h1 {
        text-align: center;
        color: #000080;
        font-size: 2.5em;
        margin-bottom: 20px;
    }

    .links {
        text-align: center;
        margin-top: 20px;
    }

    .links a {
        display: inline-block;
        margin: 10px;
        padding: 15px 30px;
        text-align: center;
        background-color: #138808; 
        color: #ffffff;
        text-decoration: none;
        border-radius: 50px;
        box-shadow: 0 5px 15px rgba(19, 136, 8, 0.3);
        transition: background-color 0.3s, box-shadow 0.3s;
    }

    .links a:hover {
        background-color: #0F6A06; 
        box-shadow: 0 8px 20px rgba(15, 106, 6, 0.5);
    }

    .modal {
        display: none;
        position: fixed;
        z-index: 1;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto;
        background-color: rgba(0, 0, 0, 0.5);
        padding-top: 60px;
    }

    .modal-content {
        background-color: #ffffff;
        margin: 5% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 80%;
        border-radius: 10px;
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        animation: slideIn 0.5s ease-in-out;
        position: relative;
    }

    @keyframes slideIn {
        from { transform: translateY(-50px); opacity: 0; }
        to { transform: translateY(0); opacity: 1; }
    }

    .close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
        cursor: pointer;
        transition: color 0.3s;
    }

    .close:hover, .close:focus {
        color: #000;
        text-decoration: none;
    }

    .voter-info {
        margin: 20px 0;
        position: relative;
    }

    .voter-info table {
        width: 100%;
        border-collapse: collapse;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
    }

    .voter-info th, .voter-info td {
        padding: 15px;
        border: 1px solid #ddd;
        text-align: left;
        background: #f9f9f9;
        transition: background 0.3s;
    }

    .voter-info th {
        background-color: #FF9933; 
        color: #ffffff;
    }

    .voter-info tr:hover td {
        background: #f1f1f1;
    }

    .edit-link {
        display: block;
        margin-top: 10px;
        text-align: right;
        color: #FF9933; 
        text-decoration: none;
        font-weight: bold;
        transition: color 0.3s;
        position: absolute;
        right: 0;
        bottom: 0;
    }

    .edit-link:hover {
        color: #CC7A00;
    }

    .logout-link {
        display: block;
        margin-top: 10px;
        text-align: right;
        color: #FF9933; 
        text-decoration: none;
        font-weight: bold;
        transition: color 0.3s;
        position: absolute;
        left: 0;
        bottom: 0;
    }

    .logout-link:hover {
        color: #CC7A00; 
    }

    .modal .edit-link {
        display: inline-block;
        margin-top: 10px;
        color: #FF9933;
        text-decoration: none;
        font-weight: bold;
    }

    .modal .edit-link:hover {
        color: #CC7A00; 
    }

    .contact-us {
        text-align: center;
        padding: 20px;
        background-color: #000080; 
        color: #ffffff;
        border-radius: 10px;
        box-shadow: 0 5px 15px rgba(0, 0, 128, 0.3);
        width: 100%;
        margin-top: 20px; 
    }

    .contact-us h2 {
        margin-bottom: 20px;
    }

    .contact-us p {
        margin: 5px 0;
    }

    .instructions {
        text-align: left;
        margin: 20px;
        padding: 20px;
        background-color: #ffffff;
        border-radius: 10px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        width: 80%; /* Adjusted width */
        margin-top: 20px; 
    }

    .instructions h2 {
        color: #000080; 
    }

    .instructions ul {
        list-style-type: disc;
        margin-left: 20px;
    }

    .instructions li {
        margin-bottom: 10px;
    }

    .vote-container {
        background-color: rgba(255, 255, 255, 0.8); 
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        width: 30%; 
        text-align: center;
        margin-top: 60px; 
    }
    
    .welcome-message {
font-family:;
        text-align: center;
        font-size: 1.5em;
        color: #000080; 
        margin-top: 20px;
        padding: 10px 20px;
        background-color: rgba(255, 255, 255, 0.8); 
        border-radius: 10px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
    }
</style>
</html>