<%@page import="voting.application.admin.entities.Admin"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sub Admin | Dashboard</title>

<style>
	body, html {
		height: 100%; 
		font-family: Arial, sans-serif;
		background-color: rgba(186, 194, 246, 0.412);
	}
	
	header {
		display: flex;
		align-items: center;
		justify-content: space-between;
		padding: 4px 30px;
		background-size: cover;
		background-position: center;
		background-repeat: no-repeat;
	}
	
	.logo {
		margin-right: 1px;
		width: 75px;
		height: 75px;
		display: flex;
		justify-content: center;
		align-items: center;
		border: 4px solid #fff;
		border-radius: 50%;
		overflow: hidden;
	}
	
	.logo img {
		width: 70px;
		height: 70px;
		border-radius: 50%;
		object-fit: contain;
		transform: scale(2.5);
	}
	
	.header-text h1 {
		font-size: 2rem;
		color: navy;
		margin: 0;
		padding-left: 0px;
	}
	
	.header-text p {
		font-size: 1rem;
		color: rgba(0, 0, 128, 0.759);
		margin: 10px 0 0 0;
	}
	
	.navbar {
		display: flex;
		justify-content: space-around;
		align-items: center;
		padding: 0;
		margin: 0;
		box-sizing: border-box;
	}
	
	.navbar ul {
		list-style-type: none;
		margin: 0;
		padding: 0;
		display: flex;
		flex-wrap: nowrap;
	}
	
	.navbar li {
		margin: 0 15px;
	}
	
	.navbar a {
		text-decoration: none;
		color: navy;
		font-size: 1rem;
		padding: 10px 15px;
		transition: background-color 0.3s ease;
		border-radius: 4px;
	}
	
	.navbar a:hover {
		background-color: #333;
		border-radius: 5px;
	}
	
	.grid-container {
		display: grid;
		grid-template-columns: repeat(3, 1fr); 
    	gap: 40px 30px; 
		padding: 0 10px; 
		grid-template-rows: 250px 250px; 
		width: 100%;
	}
	
	.grid-item {
		background-color: #fefbfb;
		text-align: center;
		padding: 10px; 
		border-radius: 20px; 
		box-shadow: 0 3px 5px rgba(0, 0, 0, 0.1); 
		transition: transform 0.3s ease, box-shadow 0.3s ease;
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		height: 100%;
	}
	
	.grid-item:hover {
		transform: translateY(-3px); 
		box-shadow: 0 6px 8px rgba(0, 0, 0, 0.15);
		background-color: rgb(231, 254, 254);
	}
	
	.grid-item img {
		width: 80px; 
		height: 80px;
		margin-bottom: 8px;
	}
	
	.grid-item h3 {
		font-size: 0.9rem; 
		color: #333;
		margin-top: 5px;
		text-align: center;
	}
	main {
    flex: 1; 
}
.page-container {
    display: flex;
    flex-direction: column;
    min-height: 100vh; 
}


footer {
    background-color: #0056b3; 
    color: white;
    text-align: center; 
    padding: 10px 10;
    font-size: 0.8rem; 
    position: fixed;
    bottom: 0;
    width: 100%;
}

	@media ( max-width : 1024px) {
		.grid-container {
			grid-template-columns: repeat(2, 1fr);
		}
	}
	
	@media ( max-width : 768px) {
		.grid-container {
			grid-template-columns: repeat(2, 1fr);
		}
	}
	
	@media ( max-width : 480px) {
		.grid-container {
			grid-template-columns: 1fr; 
		}
	}	
</style>
<link rel="icon" href="../icons/favicon.png" type="image/png">
</head>
<body>

	<header>
		<div class="logo">
			<img src="../icons/logo1.png" alt="Logo">
		</div>
		<div class="header-text">
			<h1>Welcome to Sub Admin Dashboard</h1>
			<p>Manage elections, candidates, and ensure smooth election
				operations.</p>
		</div>
		<nav class="navbar">
			<a href="/">Home</a> <a href="/admin/logout" class="btn">Logout</a> <a
				href="#">FAQs</a>
		</nav>
	</header>

	<main>
		<section class="main-content">
			<div class="grid-container">
				<!-- Grid Items -->
				<div class="grid-item">
					<a href="/subadmin/profile?adminId=${admin.id}"
						style="text-decoration: none; color: inherit;"> <img
						src="../icons/user.png" class="card-img-top" alt="Profile Change">
						<h3>Profile</h3>
					</a>
				</div>

				<div class="grid-item">
					<a href="/subadmin/manageElections?adminId=${admin.id}"
						style="text-decoration: none; color: inherit;"> <img
						src="../icons/2.png" alt="Manage Elections">
						<h3>Manage Elections</h3>
					</a>
				</div>

				<div class="grid-item">
					<a href="/subadmin/viewElections?adminId=${admin.id}"
						style="text-decoration: none; color: inherit;"> <img
						src="../icons/3.png" alt="Manage Candidate">
						<h3>Manage Candidate</h3>
					</a>
				</div>

				<div class="grid-item">
					<a href="/subadmin/openViewAllElectionsforsubadmin"
						style="text-decoration: none; color: inherit;"> 
						<img src="../icons/3.png" alt="Election Results">
						<h3>List Candidates</h3>
					</a>
				</div>
				<div class="grid-item">
					<a href="/voter/openview_allPage"
						style="text-decoration: none; color: inherit;"> <img
						src="../icons/3.png" alt="Election Results">
						<h3>Authorize Voters</h3>
					</a>
				</div>

				<div class="grid-item">
					<a href="/subadmin/reportsHomeForsubadmin"
						style="text-decoration: none; color: inherit;"> <img
						src="../icons/4.png" alt="What's on the Ballot">
						<h3>Results</h3>
					</a>
				</div>
			</div>
		</section>
	</main>

	<!-- Footer -->
	<footer>
		<div class="footer-container">
			<p>&copy; Voting Application. All Rights Reserved.</p>
		</div>
	</footer>

</body>
</html>