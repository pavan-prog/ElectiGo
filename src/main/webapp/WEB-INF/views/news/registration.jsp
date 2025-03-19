<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add News</title>
<link rel="stylesheet" href="../css/news.css">
</head>
<body>
	<div class="container">
		<h1>Add News</h1>
		<c:if test="${not empty message}">
			<p class="message">${message}</p>
		</c:if>
		<form action="/news/registration" method="post">
			<label for="title">Title:</label> <input type="text" id="title"
				name="title" required> <label for="description">Description:</label>
			<textarea id="description" name="description" required></textarea>
			<label for="category">Category:</label> <select id="category"
				name="category" required>
				<option value="Election Updates">Election Updates</option>
				<option value="Awareness">Awareness</option>
				<option value="Results">Results</option>
				<option value="Local News">Local News</option>
			</select> <label for="datePosted">Date:</label> <input type="date"
				id="datePosted" name="datePosted" required> <label
				for="videoLink">Video Link (optional):</label> <input type="url"
				id="videoLink" name="videoLink">
			<button type="submit">Submit</button>
		</form>
	</div>
</body>
</html>