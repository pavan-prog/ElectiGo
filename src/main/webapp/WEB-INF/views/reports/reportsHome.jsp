<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Reports Section</title>
    <!-- Font Awesome for Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet" type="text/css">
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #f4f7fb, #e8ebf0);
            margin: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh; 
        }

		body {
		    margin: 0;
		    padding: 0;
		    box-sizing: border-box;
		    background: linear-gradient(44deg, orange, white, green); 
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
		
        .custom-navbar {
            background-color: #fb861988; 
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .custom-navbar .navbar-brand,
        .custom-navbar .nav-link {
            color: white !important;
            font-weight: bold;
        }

        .custom-navbar .nav-link i {
            margin-right: 5px;
        }

        /* Page Heading */
        h2 {
            margin-top: 100px;
            font-size: 32px;
            font-weight: bold;
            color: #333;
            text-align: center;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .content {
            flex: 1; 
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .button-container {
            margin: 40px auto;
            display: flex;
            justify-content: center;
            gap: 30px;
            flex-wrap: wrap;
        }

        .report-card {
            width: 500px;
            padding: 30px 20px;
            background: white;
            border: none;
            border-radius: 10px;
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
            transition: all 0.3s ease;
            overflow: hidden;
            text-align: center;
        }

        .report-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
        }

        .report-card i {
            font-size: 48px;
            color: #4CAF50;
            margin-top: 20px;
        }

        .report-card-title {
            font-size: 18px;
            font-weight: bold;
            margin: 20px 0;
            color: #444;
        }

        .report-card a {
            display: block;
            text-decoration: none;
            color: white;
            background-color: #4CAF50;
            padding: 12px;
            border-radius: 0 0 10px 10px;
            font-weight: bold;
            transition: background 0.3s ease;
        }

        .report-card a:hover {
            background-color: #45a049;
        }

        .footer {
            background-color: #fb8f2a88;
            color: white;
            text-align: center;
            padding: 10px;
        }

        @media (max-width: 768px) {
            h2 {
                font-size: 28px;
            }

            .report-card {
                width: 90%;
            }
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
                    <a class="nav-link" href="/superadmin/returnDashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/admin/openLoginPage"><i class="fas fa-sign-out-alt"></i> Logout</a>
                </li>
            </ul>
        </div>
    </nav>

    <div class="content">
        <h2>Reports Section</h2>

        <div class="button-container">
            <div class="report-card">
                <i class="fas fa-chart-line"></i>
                <div class="report-card-title">Candidate Performance Report</div>
                <a href="/elections/candidateReportByElection">View Report</a>
            </div>

            <div class="report-card">
                <i class="fas fa-users"></i>
                <div class="report-card-title">Voter Participation Report</div>
                <a href="<%=request.getContextPath()%>/reports/voter-participation">View Report</a>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p>&copy; 2024 Voting System | All Rights Reserved</p>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
