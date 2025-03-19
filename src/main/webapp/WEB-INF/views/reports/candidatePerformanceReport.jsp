<%@page import="java.math.BigDecimal"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html>
<head>
<title>Candidate Performance Report</title>
<style>
body {
	font-family: 'Arial', sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f4f7fb;
	color: #333;
}

h2 {
	text-align: center;
	margin: 20px 0;
	font-size: 28px;
	color: #444;
}

table {
	width: 80%;
	margin: 20px auto;
	border-collapse: collapse;
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
	overflow: hidden;
}

th, td {
	padding: 12px 15px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

th {
	background-color: #4CAF50;
	color: white;
	text-transform: uppercase;
	font-weight: bold;
	letter-spacing: 1px;
}

tr:hover {
	background-color: #f1f1f1;
}

td {
	color: #555;
}

td:last-child {
	font-weight: bold;
	color: #333;
}

tr:last-child td {
	border-bottom: none;
}

.info-message {
	text-align: center;
	font-size: 18px;
	font-weight: bold;
	margin-top: 20px;
	color: #444;
}

.chart-container {
	width: 80%;
	margin: 40px auto;
	background-color: #fff;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
}
</style>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<!-- Favicon -->
<link rel="icon" href="../icons/favicon.png" type="image/png">
</head>
<body>
	<h2>Candidate Performance Report</h2>

	<%
	// Election end date logic
	Date electionEndDate = (Date) request.getAttribute("electionEndDate");
	List<Map<String, Object>> candidatePerformanceData = (List<Map<String, Object>>) request
			.getAttribute("candidatePerformanceData");

	String status = "active";
	String leadingCandidate = "N/A";
	String winner = "N/A";

	if (electionEndDate != null) {
		// Remove time part from currentDate to ensure proper comparison
		Date currentDate = new SimpleDateFormat("yyyy-MM-dd").parse(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));

		Date formattedEndDate = new SimpleDateFormat("yyyy-MM-dd")
		.parse(new SimpleDateFormat("yyyy-MM-dd").format(electionEndDate));

		status = currentDate.after(formattedEndDate) ? "expired" : "active";
	}

	// Determine leading candidate or winner
	if (candidatePerformanceData != null && !candidatePerformanceData.isEmpty()) {
		long maxVotes = 0L;

		for (Map<String, Object> report : candidatePerformanceData) {
			String candidateName = (String) report.get("candidate_name");
			BigDecimal totalVotesBigDecimal = (BigDecimal) report.get("total_votes");
			long totalVotes = totalVotesBigDecimal != null ? totalVotesBigDecimal.longValue() : 0L;

			if (totalVotes > maxVotes) {
		maxVotes = totalVotes;
		if (status.equals("expired")) {
			winner = candidateName;
		} else {
			leadingCandidate = candidateName;
		}
			}
		}
	}
	%>

	<!-- Display Election Status -->
	<div class="info-message">
		Election Status:
		<%=status.equals("expired") ? "Expired" : "Active"%><br>
		<%
		if (status.equals("expired")) {
		%>
		Winner: <strong><%=winner%></strong>
		<%
		} else {
		%>
		Leading Candidate: <strong><%=leadingCandidate%></strong>
		<%
		}
		%>
	</div>

	<table>
		<thead>
			<tr>
				<th>Candidate Name</th>
				<th>Total Votes</th>
			</tr>
		</thead>
		<tbody>
			<%
			if (candidatePerformanceData != null) {
				for (Map<String, Object> report : candidatePerformanceData) {
					String candidateName = (String) report.get("candidate_name");
					BigDecimal totalVotesBigDecimal = (BigDecimal) report.get("total_votes");
					long totalVotes = totalVotesBigDecimal != null ? totalVotesBigDecimal.longValue() : 0L;
			%>
			<tr>
				<td><%=candidateName%></td>
				<td><%=totalVotes%></td>
			</tr>
			<%
			}
			} else {
			%>
			<tr>
				<td colspan="2">No data available</td>
			</tr>
			<%
			}
			%>
		</tbody>
	</table>

	<div class="chart-container">
		<canvas id="candidateChart"></canvas>
	</div>

	<script>
        document.addEventListener("DOMContentLoaded", function () {
            const data = <%if (candidatePerformanceData != null) {
	out.print("[");
	for (int i = 0; i < candidatePerformanceData.size(); i++) {
		Map<String, Object> report = candidatePerformanceData.get(i);
		String candidateName = (String) report.get("candidate_name");
		BigDecimal totalVotesBigDecimal = (BigDecimal) report.get("total_votes");
		long totalVotes = totalVotesBigDecimal != null ? totalVotesBigDecimal.longValue() : 0L;

		out.print("{");
		out.print("\"candidate_name\":\"" + candidateName + "\",");
		out.print("\"total_votes\":" + totalVotes);
		out.print("}");

		if (i < candidatePerformanceData.size() - 1) {
			out.print(",");
		}
	}
	out.print("]");
} else {
	out.print("[]");
}%>;

            const labels = data.map(item => item.candidate_name || "Unknown");
            const votes = data.map(item => item.total_votes || 0);

            const ctx = document.getElementById('candidateChart').getContext('2d');
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Votes Received',
                        data: votes,
                        backgroundColor: 'rgba(75, 192, 192, 0.2)',
                        borderColor: 'rgba(75, 192, 192, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        });
    </script>
</body>
</html>
