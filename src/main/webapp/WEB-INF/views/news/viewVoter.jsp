<%@page import="voting.application.news.entities.News"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>View News</title>
<link rel="stylesheet" href="../css/news.css">
<!-- Favicon -->
<link rel="icon" href="../icons/favicon.png" type="image/png">
</head>
<body>
	<div class="container">
		<h1>All News</h1>
		<!-- Display error message if any -->
		<%
		String error = (String) request.getAttribute("error");
		if (error != null) {
		%>
		<p class="message error"><%=error%></p>
		<%
		}
		%>
		<!-- Display message if news list is empty -->
		<%
		List<News> newsList = (List<News>) request.getAttribute("newsList");
		if (newsList == null || newsList.isEmpty()) {
		%>
		<p>
			No news available. <a href="/news/openRegistrationPage">Add News</a>
		</p>
		<%
		} else {
		%>
		<!-- Display the news items in a table -->
		<table>
			<thead>
				<tr>
					<th>Title</th>
					<th>Description</th>
					<th>Category</th>
					<th>Date</th>
				</tr>
			</thead>
			<tbody>
				<!-- Iterate over the newsList -->
				<%
				for (News news : newsList) {
				%>
				<tr>
					<td><%=news.getTitle()%></td>
					<td><%=news.getDescription()%></td>
					<td><%=news.getCategory()%></td>
					<td><%=news.getDatePosted()%></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
		<%
		}
		%>
	</div>
</body>
</html>