<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home Page</title>
<link href="css/style.css" rel="stylesheet" type="text/css"/>
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f9;
        margin: 0;
        padding: 0;
    }
    .insert-form {
        color: #333;
        margin-top: 20px;
        font-size: 15px;
        letter-spacing: 1px;
    }
    .election-creation-heading {
        text-align: center;
        color: #333;
        margin-top: 20px;
        font-size: 25px;
        letter-spacing: 2px;
    }
    .election-creation-heading span {
        text-align: center;
        color: red;
        margin-top: 20px;
        font-size: 25px;
        letter-spacing: 2px;
    }
    form {
        max-width: 600px;
        margin: 20px auto;
        padding: 20px;
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }
    label {
        display: block;
        margin-bottom: 8px;
        font-weight: bold;
    }
    input[type="text"],
    input[type="date"],
    input[type="submit"] {
        width: 100%;
        padding: 10px;
        margin-bottom: 20px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }
    input[type="submit"] {
        background-color: #28a745;
        border: none;
        color: white;
        font-size: 16px;
        cursor: pointer;
    }
    input[type="submit"]:hover {
        background-color: #218838;
    }
    .container {
        padding: 20px;
    }
	    
	.close {
	    color: #aaa;
	    float: right;
	    font-size: 28px;
	    font-weight: bold;
	}
	 
	.close:hover,
	.close:focus {
	    color: black;
	    text-decoration: none;
	    cursor: pointer;
	}
	.close-btn {
	    position: absolute;
	    top: 10px;
	    right: 10px;
	    background-color: transparent;
	    border: none;
	    font-size: 28px; 
	    color: #333; 
	    cursor: pointer;
	    padding: 5px 8px;
	    border-radius: 50%;
	    transition: all 0.3s ease;
	    width: 30px; 
	    height: 30px;
	    display: flex;
	    justify-content: center;
	    align-items: center;
	    z-index: 10;
	    	}
	 
	.close-btn:hover {
	    background-color: #ff6f61; 
	    color: white; 
	    transform: scale(1.2); 
	}
	 
	.close-btn:active {
	    background-color: #e03e2f; 
	    transform: scale(1.1); 
	}
	 
	.close-btn:focus {
	    outline: none;
	    box-shadow: 0 0 0 3px rgba(255, 111, 97, 0.5); 
	}
	 
	.close-btn::before {
	    content: "×";
	    font-size: 22px; 
	    font-weight: bold;
	}
</style>
<script>
    function setMinEndDate() {
        var startDate = document.getElementById('startDate').value;
        document.getElementById('endDate').min = startDate;
    }
    function setMinStartDate() {
        var today = new Date().toISOString().split('T')[0];
        document.getElementById('startDate').min = today;
    }
</script>
<!-- Favicon -->
<link rel="icon" href="../icons/favicon.png" type="image/png">
</head>
<body onload="setMinStartDate()">

    <div class="container">
        <button class="close-btn" onclick="window.history.back();"></button>
    
        <p class="election-creation-heading">ELECTION <span>CREATION</span> </p>
    
        <form action="/elections/insertElection" method="post" class="insert-form">
            <label for="electionName">Election Name:</label>
            <input type="text" id="electionName" name="electionName" required>

            <label for="startDate">Start Date:</label>
            <input type="date" id="startDate" name="startDate" required onchange="setMinEndDate()">

            <label for="endDate">End Date:</label>
            <input type="date" id="endDate" name="endDate" required>

            <input type="submit" value="C R E A T E">
        </form>
    </div>

    <div>
        <%@include file="../message.jsp" %>
    </div>

</body>
</html>