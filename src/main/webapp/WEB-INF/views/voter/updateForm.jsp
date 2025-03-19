<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Form</title>
<!-- Favicon -->
<link rel="icon" href="../icons/favicon.png" type="image/png">
<script>
    function validateForm() {
        let name = document.getElementById("fullName").value;
        let mobile = document.getElementById("mobile").value;
        let namePattern = /^[A-Za-z\s]+$/;
        let mobilePattern = /^\d{10}$/;
        let valid = true;
 
        if (!namePattern.test(name)) {
            alert("Name should contain only alphabets.");
            valid = false;
        }
 
        if (!mobilePattern.test(mobile)) {
            alert("Mobile number should be 10 digits.");
            valid = false;
        }
 
        return valid;
    }
</script>
</head>
<body>
    <h1>Update Form</h1>
    <form action="/voter/update" method="post" id="userForm" onsubmit="return validateForm()">
        <label for="id">Voter Id:</label>
        <input type="text" id="id" name="id" value="${voter.id}" readonly >
        
        <label for="aadharNumber">Aadhar Number:</label>
        <input type="text" id="aadharNumber" name="aadharNumber" value="${voter.aadharNumber}" readonly >
        
        <label for="fullName">Name:</label>
        <input type="text" id="fullName" name="fullName" value="${voter.fullName}" required>
        
        <label for="dateOfBirth">Date of Birth:</label>
        <input type="date" id="dateOfBirth" name="dateOfBirth" value="${voter.dateOfBirth}" readonly>
        
        <label for="mobile">Mobile:</label>
        <input type="text" id="mobile" name="mobile" value="${voter.mobile}" required>
 
        <label for="nationality">Nationality:</label>
        <input type="text" id="nationality" name="nationality" value="${voter.nationality}" readonly>
   
        <button type="submit" class="button">Submit</button>
    </form>
</body>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-image: url('/images/background.png'); /* Add your background image URL here */
            background-size: cover;
            background-position: center;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            flex-direction: column;
        }
 
        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 20px;
        }
 
        form {
            background-color: #fff;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 350px;
            box-sizing: border-box;
        }
 
        label, input[type="text"], input[type="date"], .button {
            width: 100%;
            margin-bottom: 15px;
            box-sizing: border-box;
        }
 
        input[type="text"], input[type="date"] {
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
 
        .button {
            display: inline-block;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 4px;
            cursor: pointer;
        }
 
        .button:hover {
            background-color: #45a049;
        }
 
        @media (max-width: 600px) {
            form {
                padding: 10px;
            }
            input[type="text"], input[type="date"], .button {
                padding: 6px;
            }
        }
    </style>
 
</html>
 