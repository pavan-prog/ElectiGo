<%@page import="voting.application.admin.entities.Admin"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> Sub admins List</title>
<link href="../css/style.css" rel="stylesheet" type="text/css" />
<!-- Favicon -->
<link rel="icon" href="../icons/favicon.png" type="image/png">
</head>
<body>

	<%!String getUpperCase(String str) {
		return str.toUpperCase();
	}

	String maskPassword(String password) {
		return password.replaceAll(".", "*");
	}%>

	<%
		List<Admin> admins = (List<Admin>) request.getAttribute("listOfAdmins");
	%>

	<table>
		<caption>Admins List</caption>
		<thead>
			<tr>
				<th>Serial No</th>
				<th>Full Name</th>
				<th>Username</th>
				<th>Status</th>
			</tr>
		</thead>
		<tbody>
			<%
			int serialNo = 0;
			if (admins != null && !admins.isEmpty()) {
				for (Admin admin : admins) {
			%>
			<tr>
				<td class="serial_no"><%=++serialNo%></td>
				<td><%=(admin.getFirstName() + " " + admin.getLastName()).toUpperCase()%></td>
				<td><%=admin.getUsername()%></td>
				<td><%=admin.isAuthorized() ? "Yes" : "No"%></td>
			</tr>
			<%
			}
			} else {
			%>
			<tr>
				<td colspan="4" style="text-align: center;">No admins available</td>
			</tr>
			<%
			}
			%>
		</tbody>
	</table>

</body>
</html>