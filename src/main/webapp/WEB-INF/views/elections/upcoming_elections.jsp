<%@page import="java.util.List"%>
<%@page import="voting.application.election.entities.Election"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upcoming Elections</title>
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
	
    <style>
        /* General Reset */
        * { margin: 0; padding: 0; box-sizing: border-box; }
 
        body {
            font-family: 'Arial', sans-serif;
            background: #f4f7fc;
            color: #333;
        }
 
        /* Top navigation bar styles */
        .top-nav {
            display: flex;
            justify-content: flex-start;
            align-items: center;
            background: linear-gradient(90deg, #1e3c72, #2a5298);
            padding: 10px 20px;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            z-index: 1000;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.2);
        }
 
        /* Button styling */
        .top-nav a {
            text-decoration: none;
            color: white;
            padding: 10px 25px;
            margin-right: 15px;
            text-align: center;
            background: linear-gradient(90deg, #ff7e5f, #feb47b);
            border-radius: 25px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.2);
            font-weight: bold;
            font-size: 16px;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
        }
 
        /* Hover effect */
        .top-nav a:hover {
            background: linear-gradient(90deg, #feb47b, #ff7e5f);
            transform: translateY(-3px);
            box-shadow: 0px 6px 10px rgba(0, 0, 0, 0.3);
        }
 
        /* Page Content Styling */
        header {
            background: linear-gradient(to right, #1e3c72, #2a5298);
            color: white;
            padding: 50px 20px;
            text-align: center;
            margin-top: 70px; /* Adjusted to account for fixed top navigation */
        }
 
        header h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
        }
 
        header p {
            font-size: 1.2rem;
            opacity: 0.9;
        }
 
        .container {
            max-width: 1100px;
            margin: 20px auto;
            padding: 20px;
        }
 
        .elections-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
        }
 
        .election-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: center;
            transition: transform 0.3s, box-shadow 0.3s;
        }
 
        .election-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 10px rgba(0, 0, 0, 0.15);
        }
 
        .election-card h3 {
            font-size: 1.5rem;
            margin-bottom: 10px;
            color: #1e3c72;
        }
 
        .election-card p {
            font-size: 1rem;
            margin-bottom: 20px;
            color: #555;
        }
 
        .election-card button {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            background: #2a5298;
            color: white;
            font-size: 1rem;
            cursor: pointer;
            transition: background 0.3s;
        }
 
        .election-card button:hover {
            background: #1e3c72;
        }
 
        .no-elections {
            text-align: center;
            font-size: 1.2rem;
            color: #777;
            margin-top: 20px;
        }
 
        footer {
            background: linear-gradient(to right, #2a5298, #1e3c72);
            color: white;
            padding: 20px;
            text-align: center;
        }
 
        footer p {
            font-size: 0.9rem;
        }
 
        footer a {
            color: #ffd700;
            text-decoration: none;
            font-weight: bold;
        }
 
        footer a:hover {
            text-decoration: underline;
        }
 
        footer .social-links {
            margin-top: 10px;
        }
 
        footer .social-links a {
            margin: 0 10px;
            color: white;
            text-decoration: none;
            font-size: 1.5em;
        }
 
        footer .social-links a:hover {
            color: #ffd700;
        }
 
        .marquee-container {
            width: 100%;
            overflow: hidden;
            position: relative;
        }
 
        .marquee-text {
            display: inline-block;
            white-space: nowrap;
            animation: marquee 10s linear infinite;
        }
        .btn i {
		    margin-right: 8px; /* Adds space between the icon and text */
		    font-size: 1.2rem; /* Adjust the size of the icon */
		}	
		
		/* Top navigation bar styles */
		.top-nav {
		    display: flex;
		    justify-content: flex-end; /* Move items to the right */
		    align-items: center;
		    background: linear-gradient(90deg, #1e3c72, #2a5298);
		    padding: 10px 20px;
		    position: fixed;
		    top: 0;
		    left: 0;
		    right: 0;
		    z-index: 1000;
		    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.2);
		}
		
        
 
        @keyframes marquee {
            0% { transform: translateX(100%); }
            100% { transform: translateX(-100%); }
        }
    </style>
    <!-- Favicon -->
	<link rel="icon" href="../icons/favicon.png" type="image/png">
</head>
<body>
    <!-- Top Navigation Bar -->
    <div class="top-nav">
		<a href="/" class="btn"><i class="fas fa-home"></i>Home</a> 
        <a href="/superadmin/returnDashboard" class="btn"><i class="fas fa-tachometer-alt"></i>Dashboard</a>
        <a href="/admin/openLoginPage" class="btn"><i class="fas fa-sign-out-alt"></i>Logout</a>
    </div>
 
    <!-- Header Section -->
    <header>
        <h1>Discover Upcoming Elections</h1>
    </header>
 
    <div class="container">
        <!-- Marquee Container -->
        <div class="marquee-container">
            <span class="marquee-text">Nomination closes 2 days before the election start date. Add candidates by then.</span>
        </div>
 
        <!-- Elections Grid -->
        <div class="elections-grid">
            <% List<Election> elections = (List<Election>) request.getAttribute("listOfElections");
            if (elections != null && !elections.isEmpty()) {
                for (Election election : elections) { %>
                    <div class="election-card">
                        <h3><%= election.getElectionName() %></h3>
                        <p>Starts on: <%= election.getElectionStartDate() %></p>
                        <button onclick="window.location.href='/candidate/listByElection?electionId=<%= election.getElectionId() %>'">View Candidates</button>
                    </div>
            <% } } else { %>
                <p class="no-elections">No upcoming elections available for adding candidates.</p>
            <% } %>
        </div>
    </div>
 
    <footer>
        <p>© 2024 Voting Application | All Rights Reserved.</p>
    </footer>
</body>
</html>