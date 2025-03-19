<%@page import="java.util.List"%>
<%@page import="voting.application.news.entities.News"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home Page</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
}

.menu-icon {
	position: absolute;
	top: 10px;
	right: 10px;
	cursor: pointer;
	font-size: 36px; 
	color: black;
	text-shadow: 0 0 10px rgba(255, 255, 255, 0.7); 
	z-index: 3; 
}

.menu {
	display: none;
	position: absolute;
	width: 30%;
	height: auto;
	top: 70px; 
	right: 40px;
	background-color: #f9f9f9;
	z-index: 2;
	align-content: center;
	align-items: center;
	justify-content: center;
	box-shadow: 1px 3px 6px black;
}

.menu a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
	letter-spacing: 1px;
}

.menu a:hover {
	background-color: #D3D3D3;
	letter-spacing: 2px;
}

.carousel {
	position: relative;
	width: 100%;
	height: 600px;
	margin: 0; 
	overflow: hidden;
	text-align: center;
}

.carousel img {
	display: none;
	width: 100%;
	height:100%;
}

.carousel img.active {
	display: inline-block;
}

.news-container {
	display: flex;
	flex-wrap: wrap;
	justify-content: space-around;
	padding: 20px;
}

.news-item {
	background-color: #f4f4f4;
	margin: 10px;
	padding: 20px;
	border-radius: 8px;
	width: 30%;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.top-container {
	align-content: center;
	justify-content: center;
	align-items: center;
	display: flex;
}

.marquee {
	position: absolute;
	width: 100%;
	top: 100px;
	z-index: 1; 
}

.news {
	width: 100%;
	display: none; 
}

.news-category {
	width: 90%;
	margin: 10px auto;
	padding: 20px;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	transition: transform 0.3s ease, box-shadow 0.3s ease;
	display: none; 
}

.news-category:hover {
	transform: translateY(-5px);
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}

.news-category h3 {
	font-weight: bold;
	margin-bottom: 10px;
}

.news-category p {
	margin: 5px 0;
}

.category-buttons {
	text-align: center;
	margin: 20px 0;
}

.category-buttons button {
	color: white;
	padding: 10px 20px;
	margin: 5px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 16px;
}

.category-buttons button:hover {
	opacity: 0.8;
}

.category-buttons button.active {
	opacity: 0.4;
	padding: 20px 30px;
}

button[data-category="Election Updates"] {
	background-color: #4CAF50; /* Green */
}

button[data-category="Local News"] {
	background-color: #2196F3; /* Blue */
}

button[data-category="Awareness"] {
	background-color: #FF9800; 
}

button[data-category="Results"] {
	background-color: #F44336; 
}

button[data-category="all"] {
	background-color: #9E9E9E;
}

.results {
	background-color: white;
	border: 1px solid green;
	color: black;
	padding: 7px;
	border-radius: 5px;
}

.results:hover {
	background-color: #4CAF50;
	opacity: 0.4; color : white;
	letter-spacing: 2px;
	color: white;
}

.logo {
	width: 100px;
	position: absolute;
	top: 15px;
	left: 15px;
	z-index: 2;
}
.logo-title {
	position: absolute;
	top: 3px;
	left: 100px;
	z-index: 2;
}

.footer {
	background-color: #333;
	color: white;
	text-align: center;
	padding: 10px 0;
	width: 100%;
	bottom: 0;
}
</style>
<link rel="preload" href="images/hands.jpg" as="image">
<script>
	function toggleMenu() {
		var menu = document.getElementById('menu');
		if (menu.style.display === 'block') {
			menu.style.display = 'none';
		} else {
			menu.style.display = 'block';
		}
	}

	function closeMenu(event) {
		var menu = document.getElementById('menu');
		if (menu.style.display === 'block' && !event.target.closest('.menu')
				&& !event.target.closest('.menu-icon')) {
			menu.style.display = 'none';
		}
	}

	document.addEventListener('click', closeMenu);

	// Carousel functionality
	let currentIndex = 0;
	function showNextImage() {
		const images = document.querySelectorAll('.carousel img');
		images[currentIndex].classList.remove('active');
		currentIndex = (currentIndex + 1) % images.length;
		images[currentIndex].classList.add('active');
	}

	setInterval(showNextImage, 3000); // Change image every 3 seconds

	// Function to filter news by category
	function filterNews(category) {
		const newsSection = document.getElementById('news');
		const newsCategories = document.querySelectorAll('.news-category');
		const buttons = document.querySelectorAll('.category-buttons button');
		newsSection.style.display = 'block'; // Show the news section
		newsCategories.forEach(news => {
			if (news.dataset.category === category || category === 'all') {
				news.style.display = 'block';
				news.style.backgroundColor = getButtonColor(category);
			} else {
				news.style.display = 'none';
			}
		});
		buttons.forEach(button => {
			if (button.dataset.category === category || category === 'all') {
				button.classList.add('active');
			} else {
				button.classList.remove('active');
			}
		});
		newsSection.scrollIntoView({ behavior: 'smooth' });
	}

	// Function to get button color based on category
	function getButtonColor(category) {
		switch (category) {
			case 'Election Updates':
				return '#E8F5E9'; // Light green
			case 'Local News':
				return '#E3F2FD'; // Light blue
			case 'Awareness':
				return '#FFF3E0'; // Light orange
			case 'Results':
				return '#FFEBEE'; // Light red
			default:
				return '#F5F5F5'; // Light grey
		}
	}

	// Set default category to "Election Updates" when "News" is clicked
	function showNews() {
		filterNews('Election Updates');
	}

	document.addEventListener('DOMContentLoaded', () => {
		showNextImage(); // Start the carousel
	});
</script>
</head>
<body>
	<div class="carousel">
		<img alt="image" src="images/hands.jpg" loading="lazy" class="active">
		<!-- Add more images here -->
		<div class="menu-icon" onclick="toggleMenu()">☰</div>
		<div id="menu" class="menu">
			<a href="/admin/openLoginPage">ADMIN LOGIN</a> <a
				href="/voter/openLoginPage">VOTER LOGIN</a> <a
				href="javascript:void(0)" onclick="showNews()">NEWS</a>
		</div>
	</div>

	<div class="marquee">
		<marquee>
			<%
			List<News> news = (List) request.getAttribute("news");
			for (News newss : news) {
				if ("Results".equals(newss.getCategory())) {
			%>
			<%=newss.getTitle()%>
			<%="- "%><button class="results" onclick="filterNews('Results')">Results</button>

			<%
			}
			}
			%>
		</marquee>
	</div>

	<div class="news" id="news">
		<div class="category-buttons">
			<button data-category="Election Updates"
				onclick="filterNews('Election Updates')">Election Updates</button>
			<button data-category="Local News" onclick="filterNews('Local News')">Local
				News</button>
			<button data-category="Awareness" onclick="filterNews('Awareness')">Awareness</button>
			<button data-category="Results" onclick="filterNews('Results')">Results</button>
		</div>
		<%
		for (News newss : news) {
		%>
		<div class="news-category" data-category="<%=newss.getCategory()%>">
			<h3><%=newss.getTitle()%></h3>
			<p>
				Category:
				<%=newss.getCategory()%></p>
			<p><%=newss.getDescription()%></p>
			<p>
				Posted Date:
				<%=newss.getDatePosted()%></p>

			<p>
				<a href="<%=newss.getVideoLink()%>">Video</a>
			</p>
		</div>
		<%
		}
		%>
	</div>

	<div class="footer">@Voting Application. All Rights Reserved 2024
	</div>

	<div class="logo">
		<img alt="logo image" src="icons/logo.jpeg"
			style="width: 70px; height: 70px; border-radius: 50%; border: 2px solid black">
	</div>
	<div class="logo-title">
		<p style="font-family:cursive; font-size: 30px">Electi<span style="color:red">Go</span> </p>
	</div>
</body>
</html>