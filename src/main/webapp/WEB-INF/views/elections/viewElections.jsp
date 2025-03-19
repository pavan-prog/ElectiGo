<%@page import="java.util.List"%>
<%@page import="voting.application.election.entities.Election"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Election List</title>
    <link href="../css/style.css" rel="stylesheet" type="text/css"/>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <style>
        
html, body {
    height: 100%; 
    margin: 0;
    padding: 0;
}
body {
    font-family: 'Arial', sans-serif;
    background-color: #f4f7fb;
    background-image: url('/images/background.png');
    background-size: cover;
    background-repeat: no-repeat;
    background-position: center;
    height: 100%; 
    margin: 0;
    padding: 0;
    display: flex;
    flex-direction: column;
}
 
.election-list-container {
    width: 90%; 
    margin: 20px auto;
    padding: 20px; 
    background-color: rgba(255, 255, 255, 0.8);
    border-radius: 15px;
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
    border: 2px solid #ddd;
    max-height: 90vh; 
    overflow-y: auto; 
}
 
 
 
.election-list-container::before {
    content: "";
    display: block;
    height: 10px; 
    width: 100%;
    background: transparent;
}
.header-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 10px;
}
.header-title {
    font-size: 34px;
    font-weight: 700;
    color: #333;
    letter-spacing: 0.5px;
}
 
 
        .election-cards {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
            gap: 30px;
        }
 
       .election-card {
    background: #fff;
    border-radius: 15px;
    box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
    padding: 20px; 
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    position: relative;
    overflow: hidden;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    border: 1px solid #e5e5e5;
}
 
        .election-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }
 
        .election-card .title {
            font-size: 26px;
            font-weight: 600;
            color: #333;
            margin-bottom: 15px;
            text-transform: capitalize;
            letter-spacing: 1px;
        }
 
        .election-card .date {
            font-size: 14px;
            color: #666;
            margin-bottom: 15px;
        }
 
        .election-card .status {
            font-size: 16px;
            padding: 8px 15px;
            border-radius: 25px;
            font-weight: bold;
            text-transform: capitalize;
            display: inline-block;
            margin-bottom: 10px;
        }
 
.status {
    font-size: 16px;
    padding: 8px 15px;
    border-radius: 25px;
    font-weight: bold;
    text-transform: capitalize;
    display: inline-block;
    margin-bottom: 5px; 
}
        .status-upcoming {
            color: #009688; 
        }
 
        .status-active {
            color: #4CAF50; 
        }
 
        .status-expired {
            color: #F44336; 
        }
 
.progress-bar-container {
    width: 100%;
    height: 15px;
    background-color: #f0f0f0;
    border-radius: 10px;
    overflow: hidden;
    margin-top: 5px;
    position: relative;
}
        .election-card .view-candidates {
            display: inline-block;
            padding: 10px 20px;
            background-color: #ff6f61;
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 600;
            transition: background-color 0.3s ease;
            text-transform: uppercase;
            margin-top: 15px;
            align-self: flex-start;
        }
 
        .election-card .view-candidates:hover {
            background-color: #e55b49;
        }
 
       .progress-bar-container {
    width: 100%;
    height: 15px;
    background-color: #f0f0f0;
    border-radius: 10px;
    overflow: hidden;
    margin-top: 5px; 
    position: relative; 
}
 
 
        .progress-bar {
            height: 100%;
            width: 0%;
            background-color: #008C00;
            text-align: center;
            color: white;
            border-radius: 10px;
            font-size: 12px;
        }
 
        .no-elections {
            text-align: center;
            font-style: italic;
            color: #888;
            font-size: 20px;
        }
        
        .btn i {
		    margin-right: 8px; 
		    font-size: 1.2rem; 
		}		
		
    </style>
	<link rel="icon" href="../icons/favicon.png" type="image/png">
</head>
<body>
    <div class="election-list-container">
        <div class="header-container">
            <h1 class="header-title">Elections List</h1>
            <a href="/" class="btn"><i class="fas fa-home"></i>Home</a>
        	<a href="/superadmin/returnDashboard" class="btn"><i class="fas fa-tachometer-alt"></i>Dashboard</a>
        	<a href="/admin/openLoginPage" class="btn"><i class="fas fa-sign-out-alt"></i>Logout</a>
        </div>
 
        <div class="election-cards">
            <%
                List<Election> elections = (List<Election>) request.getAttribute("listOfElections");
                if (elections != null && !elections.isEmpty()) {
                    LocalDate currentDate = LocalDate.now();
                    for (Election election : elections) {
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
 
                        // Calculate progress bar width
                        long totalDuration = java.time.temporal.ChronoUnit.DAYS.between(startDate, endDate);
                        long remainingDuration = java.time.temporal.ChronoUnit.DAYS.between(currentDate, endDate);
                        int progress = (int) ((1 - ((double) remainingDuration / totalDuration)) * 100);
            %>
            <div class="election-card">
                <div class="title"><%= election.getElectionName() %></div>
                <div class="date">
                    Start Date: <%= election.getElectionStartDate() %><br/>
                    End Date: <%= election.getElectionEndDate() %>
                </div>
                <div class="status <%= "status-" + status %>"><%= status %></div>
 
                <!-- Progress Bar -->
                <div class="progress-bar-container">
                    <div class="progress-bar" style="width: <%= progress %>%;">
                    </div>
                </div>
 
            
                <a class="view-candidates" href="/candidate/viewByElection?electionId=<%= election.getElectionId() %>">View Candidates</a>
           
            <!-- Countdown Timer for Upcoming Elections -->
            <%
                if (status.equals("upcoming")) {
                    long daysUntilStart = java.time.Duration.between(currentDate.atStartOfDay(), startDate.atStartOfDay()).toDays();
            %>
            <div class="time-countdown">
                Starts in <%= daysUntilStart %> Days
            </div>
            <%
                }
            %>
            </div>
            <%
                    }
                } else {
            %>
            
            <div class="no-elections">No elections found.</div>
            <%
                }
            %>
        </div>
        <!-- Footer -->
    </div>
    <footer>
<div class="footer-container">
<p>&copy; Voting Application. All Rights Reserved.</p>
</div>
</footer>
</body>
</html>