<%@page import="java.util.List"%>
<%@page import="voting.application.election.entities.Election"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Election List</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" type="text/css">
    
    <style>
        /* General Styles */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f7fb;
            margin: 0;
            padding: 0;
        }
        body {
		    margin: 0;
		    padding: 0;
		    box-sizing: border-box;
		    background: linear-gradient(44deg, orange, white, green); /* Initial gradient */
		    min-height: 100vh;
		    width: 100%;
		    background-attachment: fixed;
		    overflow: auto;
		    animation: wave-animation 5s infinite; 
		    padding-top: 1px; 
		    background-size: 400% 400%; 
		    
		}
		
		@keyframes wave-animation {
		    0% {
		        background-position: 0% 50%;
		    }
		    50% {
		        background-position: 100% 50%;
		    }
		    100% {
		        background-position: 0% 50%;
		    }
		}
		
		body {
		    background-size: 200% 200%; 
		}

        .election-list-container {
            width: 90%;
            margin: 40px auto;
            padding: 30px;
            background-color: rgba(255, 255, 255, 0.8); 
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.5);
            margin-top: 100px;
            
        }

        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
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
		    padding: 20px; /* Reduced padding to shrink the gap inside the card */
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
        .footer {
            background-color: #3db675a0;
            color: white;
            text-align: center;
            padding: 10px;
        }
	    .custom-navbar {
		    background-color: #fb8f2a88; 
		    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.5);
		}

        .custom-navbar .navbar-brand,
        .custom-navbar .nav-link {
            color: white !important;
            font-weight: bold;
            margin-right: 50px; 
            
        }

        .custom-navbar .nav-link i 
        {
            margin-right: 5px;
        }
    </style>
	<link rel="icon" href="../icons/favicon.png" type="image/png">
</head>
<body>

    <nav class="navbar navbar-expand-lg custom-navbar fixed-top">
        <a class="navbar-brand" href="/"><i class="fas fa-home"></i> Home</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="/subadmin/opendashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/admin/openLoginPage"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </li>
            </ul>
        </div>
    </nav>
    
    <div class="election-list-container">
        <div class="header-container">
            <h1 class="header-title">Elections List</h1>
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

            
			<a class="view-candidates" href="/reports/candidate-performance?electionName=<%= election.getElectionName() %>">View Candidates</a>
           
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
   
    </div>
    <!-- Footer -->
    <div class="footer">
        <p>&copy; 2024 Voting System | All Rights Reserved</p>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    
</body>
</html> 
