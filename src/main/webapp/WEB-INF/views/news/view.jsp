<%@page import="voting.application.news.entities.News"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View News</title>
    <link rel="icon" href="../icons/favicon.png" type="image/png">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <style>
      

        .navbar {
            background-color: #0cd4f73e;
            overflow: hidden;
            position: fixed;
            top: 0;
            width: 100%;
            z-index: 999;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .navbar a {
            display: inline-block;
            color: white;
            text-align: center;
            padding: 16px 20px;
            text-decoration: none;
            font-size: 1.2rem;
        }

        .navbar-right {
            float: right;
        }

        .navbar a:hover {
            background-color: #575757;
        }

        .navbar a.active {
            background-color: #4CAF50;
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
		    padding-top: 100px; 
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


		.main-container {
		    width: 90%;
		    max-width: 1200px;
		    margin: 40px auto;
		    padding: 20px;
		    border-radius: 8px;
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		    background-color: rgba(255, 255, 255, 0.7);
		    
		}
        h1 {
            color: #003366;
            text-align: center;
            font-size: 2.5rem;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .message.error {
            background-color: #f8d7da;
            color: #721c24;
            padding: 15px;
            margin-bottom: 20px;
            border-radius: 5px;
            text-align: center;
            font-size: 1.1em;
        }

        .btn-add-news {
            display: inline-block;
            padding: 12px 20px;
            background-color: #4CAF50;
            color: white;
            font-size: 1.1rem;
            text-decoration: none;
            border-radius: 5px;
            margin-bottom: 20px;
            transition: background-color 0.3s;
            align-self: flex-end; 
        }

        .btn-add-news:hover {
            background-color: #45a049;
        }

        /* News Block */
        .news-list {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }

        .news-item {
            padding: 20px;
            margin-bottom: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .news-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15);
        }

        .news-item h3 {
            font-size: 1.6rem;
            color: #003366;
            margin-bottom: 10px;
            font-weight: bold;
        }

        .news-item .category {
            font-size: 1rem;
            font-weight: bold;
            color: #4CAF50;
            margin-bottom: 5px;
        }

        .news-item .date {
            font-size: 1rem;
            color: #888;
            margin-bottom: 10px;
        }

        .news-item .description {
            font-size: 1.1rem;
            color: #555;
            margin-bottom: 15px;
        }

        .news-item .btn {
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s, transform 0.3s;
        }

        .news-item .btn:hover {
            background-color: #0056b3;
            transform: scale(1.05);
        }

        @media (max-width: 768px) {
            .navbar a {
                font-size: 1rem;
            }

            .news-item h3 {
                font-size: 1.4rem;
            }

            .news-item .category, .news-item .date, .news-item .description {
                font-size: 1rem;
            }
        }
        
        .btn i {
		    margin-right: 8px; 
		    font-size: 1.2rem; 
		}	
    </style>
</head>
<body>

    <div class="navbar">
        <div class="navbar-right">
            <a href="/" class="btn"><i class="fas fa-home"></i>Home</a>
        	<a href="/superadmin/returnDashboard" class="btn"><i class="fas fa-tachometer-alt"></i>Dashboard</a>
        	<a href="/admin/openLoginPage" class="btn"><i class="fas fa-sign-out-alt"></i>Logout</a>
        </div>
    </div>

    <div class="main-container">
        <h1>All News</h1>

        <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
        %>
        <p class="message error"><%=error%></p>
        <%
        }
        %>

        <div style="display: flex; justify-content: flex-end; margin-bottom: 20px;">
            <a href="/news/openRegistrationPage" class="btn-add-news">Add News</a>
        </div>

        <%
        List<News> newsList = (List<News>) request.getAttribute("newsList");
        if (newsList == null || newsList.isEmpty()) {
        %>
        <p class="message error">
            No news available. <a href="/news/openRegistrationPage" class="btn-add-news">Add News</a>
        </p>
        <%
        } else {
        %>

        <ul class="news-list">
            <%
            for (News news : newsList) {
            %>
            <li class="news-item">
                <h3><%=news.getTitle()%></h3>
                <p class="category"><%=news.getCategory()%></p>
                <p class="date"><%=news.getDatePosted()%></p>
                <p class="description"><%=news.getDescription()%></p>
                <a href="/news/updateNewsPage?id=<%=news.getId()%>" class="btn">Update</a>
                <a href="/news/delete?id=<%=news.getId()%>" class="btn" onclick="return confirm('Are you sure?')">Delete</a>
            </li>
            <%
            }
            %>
        </ul>
        <%
        }
        %>
    </div>

</body>
</html>
