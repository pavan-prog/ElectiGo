<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Voter Registration</title>
<style>
    body {
        font-family: Arial, sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 0;
        background-image: url('/images/background.png'); /* Add your background image URL here */
        background-size: cover;
        background-position: center;
    }

    .registration-container {
        background-color: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        height:80%;
        width: 100%;
        max-width: 400px;
        box-sizing: border-box;
        overflow: hidden;
    }

    h2 {
        text-align: center;
        color: #333;
        margin-bottom: 20px;
    }

    .form-group {
        margin-bottom: 15px;
    }

    label {
        display: block;
        margin-bottom: 5px;
        color: #333;
    }

    input[type="text"], input[type="date"], input[type="password"], select, input[type="file"] {
        width: 100%;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }

    .btn {
        display: block;
        width: 100%;
        padding: 10px;
        background-color: #4CAF50;
        color: white;
        text-align: center;
        text-decoration: none;
        border-radius: 4px;
        cursor: pointer;
        border: none;
    }

    .btn:hover {
        background-color: #45a049;
    }

    p {
        text-align: center;
        margin-top: 20px;
    }

    p a {
        color: #4CAF50;
        text-decoration: none;
    }

    p a:hover {
        text-decoration: underline;
    }

    .error {
        color: red;
        font-size: 12px;
    }
</style>
</head>
<body>

    <div class="registration-container">
        <h2>Voter Registration</h2>
        <form action="/voter/registration" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
            <div class="form-group">
                <label for="fullName">Full Name:</label>
                <input type="text" id="fullName" name="fullName" required>
                <span id="fullNameError" class="error"></span>
            </div>
            
            <div class="form-group">
                <label for="dob">Date of Birth:</label>
                <input type="date" id="dob" name="dob" required>
                <span id="dobError" class="error"></span>
            </div>
            
            <div class="form-group">
                <label for="mobile">Mobile No:</label>
                <input type="text" id="mobile" name="mobile" required>
                <span id="mobileError" class="error"></span>
            </div>
           
            <div class="form-group">
                <label for="aadharNumber">Aadhar Number:</label>
                <input type="text" id="aadharNumber" name="aadharNumber" required>
                <span id="aadharError" class="error"></span>
            </div>
            
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
                <span id="passwordError" class="error"></span>
            </div>
            
            <div class="form-group">
                <label for="nationality">Nationality:</label>
                <select id="nationality" name="nationality" required>
                    <option value="Indian">Indian</option>
                    <option value="Non-Indian">Non-Indian</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="profile">Upload Image:</label>
                <input type="file" id="profile" name="profilePic" required>
            </div>
            
            <button type="submit" class="btn">Register</button>
        </form>
       
        <p>Already registered? <a href="/voter/openLoginPage">Login here</a></p>
        
        <%@include file="../message.jsp" %>
    </div>

<script>
document.getElementById('fullName').addEventListener('input', function() {
    const fullName = this.value;
    const fullNameError = document.getElementById('fullNameError');
    const namePattern = /^[A-Za-z\s]+$/;
    if (!namePattern.test(fullName)) {
        fullNameError.textContent = 'Enter alphabets only';
    } else {
        fullNameError.textContent = '';
    }
});

document.getElementById('mobile').addEventListener('input', function() {
    const mobile = this.value;
    const mobileError = document.getElementById('mobileError');
    if (mobile.length !== 10 || isNaN(mobile)) {
        mobileError.textContent = 'Enter a valid 10-digit mobile number';
    } else {
        mobileError.textContent = '';
    }
});

document.getElementById('aadharNumber').addEventListener('input', function() {
    const aadharNumber = this.value;
    const aadharError = document.getElementById('aadharError');
    if (aadharNumber.length !== 12 || isNaN(aadharNumber)) {
        aadharError.textContent = 'Enter a valid 12-digit Aadhar number';
    } else {
        aadharError.textContent = '';
    }
});

document.getElementById('dob').addEventListener('change', function() {
    const dob = this.value;
    const dobError = document.getElementById('dobError');
    const birthDate = new Date(dob);
    const today = new Date();
    let age = today.getFullYear() - birthDate.getFullYear();
    const monthDifference = today.getMonth() - birthDate.getMonth();
    if (monthDifference < 0 || (monthDifference === 0 && today.getDate() < birthDate.getDate())) {
        age--;
    }
    if (age < 18) {
        dobError.textContent = 'You must be at least 18 years old to register';
    } else {
        dobError.textContent = '';
    }
});

document.getElementById('password').addEventListener('input', function() {
    const password = this.value;
    const passwordError = document.getElementById('passwordError');
    const passwordPattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[A-Z])(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
    if (!passwordPattern.test(password)) {
        passwordError.textContent = 'Password must be at least 8 characters long, contain both letters and numbers, one capital letter, and one special character';
    } else {
        passwordError.textContent = '';
    }
});

function validateForm() {
    const fullNameError = document.getElementById('fullNameError').textContent;
    const mobileError = document.getElementById('mobileError').textContent;
    const aadharError = document.getElementById('aadharError').textContent;
    const dobError = document.getElementById('dobError').textContent;
    const passwordError = document.getElementById('passwordError').textContent;

    if (fullNameError || mobileError || aadharError || dobError || passwordError) {
        return false;
    }
    return true;
}
</script>

</body> 
</html>