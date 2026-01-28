<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Account</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

<style>
    body {
        font-family: 'Poppins', sans-serif;
        min-height: 100vh;
        background: linear-gradient(135deg, #667eea, #764ba2);
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .signup-card {
        background: rgba(255, 255, 255, 0.15);
        backdrop-filter: blur(15px);
        border-radius: 20px;
        padding: 30px;
        width: 100%;
        max-width: 420px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.2);
        color: #fff;
    }

    .signup-card h3 {
        font-weight: 600;
    }

    .form-control {
        background: rgba(255, 255, 255, 0.2);
        border: none;
        color: #fff;
        border-radius: 12px;
    }

    .form-control::placeholder {
        color: #e0e0e0;
    }

    .form-control:focus {
        background: rgba(255, 255, 255, 0.25);
        box-shadow: none;
        color: #fff;
    }

    label {
        font-size: 14px;
    }

    .btn-custom {
        background: linear-gradient(135deg, #ff758c, #ff7eb3);
        border: none;
        border-radius: 30px;
        padding: 10px;
        font-weight: 500;
        transition: 0.3s;
    }

    .btn-custom:hover {
        transform: scale(1.03);
        opacity: 0.95;
    }

    a {
        color: #ffe6f0;
        text-decoration: none;
    }

    a:hover {
        text-decoration: underline;
    }
</style>
</head>

<body>

<div class="signup-card">
    <h3 class="text-center mb-4">Create Account ✨</h3>

    <form action="register" method="post">

        <div class="mb-3">
            <label>First Name</label>
            <input type="text" name="firstName" class="form-control" placeholder="Enter first name" required>
        </div>

        <div class="mb-3">
            <label>Last Name</label>
            <input type="text" name="lastName" class="form-control" placeholder="Enter last name" required>
        </div>

        <div class="mb-3">
            <label>Email</label>
            <input type="email" name="email" class="form-control" placeholder="Enter email" required>
        </div>
        
        <div class="mb-3">
            <label class="form-label">Mobile Number</label>
            <input type="text" name="mobile" class="form-control" placeholder="Enter Mobile Number" maxlength="10" required />
        </div>

        <div class="mb-3">
            <label>Password</label>
            <input type="password" name="password" class="form-control" placeholder="Create password" required>
        </div>

        <div class="d-grid mt-4">
            <button type="submit" class="btn btn-custom text-white">
                Sign Up
            </button>
        </div>

        <div class="text-center mt-3">
            <small>Already have an account?
                <a href="login">Login</a>
            </small>
        </div>

    </form>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
