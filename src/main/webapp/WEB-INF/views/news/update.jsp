<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Update News</title>
<link rel="stylesheet" href="../css/news.css">
<!-- Favicon -->
<link rel="icon" href="../icons/favicon.png" type="image/png">
</head>
<body>
	<div class="container">
		<h1>Update News</h1>
		<c:if test="${not empty message}">
			<p class="message">${message}</p>
		</c:if>
		<form action="/news/updateNews" method="post">
			<input type="hidden" name="id" value="${news.id}"> <label
				for="title">Title:</label> <input type="text" id="title"
				name="title" value="${news.title}" required> <label
				for="description">Description:</label>
			<textarea id="description" name="description" required>${news.description}</textarea>
			<label for="category">Category:</label> <select id="category"
				name="category" required>
				<option value="Election Updates"
					${news.category == 'Election Updates' ? 'selected' : ''}>Election
					Updates</option>
				<option value="Educational Content"
					${news.category == 'Educational Content' ? 'selected' : ''}>Educational
					Content</option>
				<option value="Press Announcements"
					${news.category == 'Press Announcements' ? 'selected' : ''}>Press
					Announcements</option>
				<option value="Community Engagement"
					${news.category == 'Community Engagement' ? 'selected' : ''}>Community
					Engagement</option>
			</select> <label for="datePosted">Date:</label> <input type="date"
				id="datePosted" name="datePosted" value="${news.datePosted}"
				required> <label for="videoLink">Video Link:</label> <input
				type="url" id="videoLink" name="videoLink" value="${news.videoLink}">
			<button type="submit">Update</button>
		</form>
	</div>
</body>
</html>