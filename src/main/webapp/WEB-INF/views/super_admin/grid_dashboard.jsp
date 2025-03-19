<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Super Admin | Dashboard</title>
<link rel="stylesheet" href="../css/grid_dashboard.css">
<!-- Favicon -->
<link rel="icon" href="../icons/favicon.png" type="image/png">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

</head>
<body>
	<!-- Header -->
	<header
		style="background-image: url('../icons/bg.png'); background-size: cover; background-position: center; padding: 10px 30px;">
		<div class="logo">
			<img src="../icons/logo1.png" alt="Logo">
		</div>
		<div class="header-text">
			<h1>Welcome to Super Admin Dashboard</h1>
			<p>Manage elections, sub-admins, and ensure smooth election
				operations.</p>
		</div>
		<!-- Navigation Bar -->
		<nav class="navbar">
			<!-- <ul> -->
			<a href="/"><i class="fas fa-home"></i>Home</a> 
			<a href="/admin/logout" class="btn"><i class="fas fa-sign-out-alt"></i>Logout</a>
		</nav>
	</header>

	<!-- Main Content -->
	<main>
		<section class="main-content"><br />
			<div class="grid-container">
				<div class="grid-item">
					<a href="/elections/openViewElectionsForSuperAdmin"
						style="text-decoration: none; color: inherit;"> 
						<img src="../icons/1.png" alt="Registration">
						<h3>Manage Elections</h3>
					</a>
				</div>
				<div class="grid-item">
					<a href="/superadmin/openViewSubAdminsPage"
						style="text-decoration: none; color: inherit;"> <img
						src="../icons/2.png" alt="Manage Sub-Admins">
						<h3>Manage Sub-Admins</h3>
					</a>
				</div>
				<div class="grid-item">
					<a href="/elections/upcoming"
						style="text-decoration: none; color: inherit;"> <img
						src="../icons/3.png" alt="Election Results">
						<h3>Manage Candidate</h3>
					</a>
				</div>
				<div class="grid-item">
					<a href="/reports/home" 
					style="text-decoration: none; color: inherit;">
					<img src="../icons/4.png" alt="What's on the Ballot">
					<h3>Results</h3>
					</a>					
				</div>
				<div class="grid-item">
				<a href="/elections/openlistOfElections"
						style="text-decoration: none; color: inherit;">
					<img src="../icons/5.png" alt="Where to Vote In Person">
					<h3>List Elections</h3>
					</a>
				</div>
				<div class="grid-item">
					<a href="/admin/openListOfAllAdminsPage"
						style="text-decoration: none; color: inherit;"> <img
						src="../icons/6.png" alt="Become an Election Worker">
						<h3>List Sub-Admins</h3>
					</a>
				</div>
				<div class="grid-item">
					<a href="/elections/openViewAllElections"
						style="text-decoration: none; color: inherit;"> <img
						src="../icons/1.png" alt="Campaign Resources">
						<h3>List Candidates</h3>
					</a>
				</div>
				<div class="grid-item">
					<a href="/news/all"
						style="text-decoration: none; color: inherit;">
						<img src="../icons/2.png" alt="News & Press Releases">
						<h3>News & Press Releases</h3>
					</a>
				</div>
			</div>
		</section>
	</main>

	<br />
	<!-- Footer -->
	<footer>
		<div class="footer-container">
			<p>&copy; Voting Application. All Rights Reserved.</p>
		</div>
	</footer>
</body>
</html>
