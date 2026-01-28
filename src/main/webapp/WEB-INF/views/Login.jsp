<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

<style>
    /* BODY */
    body {
        font-family: 'Poppins', sans-serif;
        min-height: 100vh;
        background: linear-gradient(135deg, #667eea, #764ba2);
        margin: 0;
        padding: 20px;
    }

    /* CENTER WRAPPER */
    .login-wrapper {
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    /* CARD */
    .login-card {
        background: rgba(255, 255, 255, 0.15);
        backdrop-filter: blur(15px);
        border-radius: 20px;
        padding: 30px;
        width: 100%;
        max-width: 420px;
        box-shadow: 0 8px 32px rgba(0,0,0,0.2);
        color: #fff;
    }

    .login-card h3 {
        font-weight: 600;
        font-size: 24px;
        text-align: center;
        margin-bottom: 25px;
    }

    /* INPUT FIELDS */
    .form-control {
        background: rgba(255, 255, 255, 0.2);
        border: none;
        color: #fff;
        border-radius: 12px;
        font-size: 14px;
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
        font-size: 13px;
    }

    /* BUTTON */
    .btn-custom {
        background: linear-gradient(135deg, #ff758c, #ff7eb3);
        border: none;
        border-radius: 30px;
        padding: 10px;
        font-weight: 500;
        font-size: 15px;
        transition: 0.3s;
        width: 100%;
    }

    .btn-custom:hover {
        transform: scale(1.03);
        opacity: 0.95;
    }

    /* LINKS */
    a {
        color: #ffe6f0;
        text-decoration: none;
    }

    a:hover {
        text-decoration: underline;
    }

    /* MOBILE */
    @media (max-width: 576px) {
        .login-card {
            padding: 20px;
        }

        .login-card h3 {
            font-size: 20px;
        }
    }
</style>
</head>

<body>

<!-- CENTER WRAPPER -->
<div class="login-wrapper">
    <div class="login-card">
        <h3>Login ✨</h3>

        <form action="LoginServlet" method="post">

            <!-- Email -->
            <div class="mb-3">
                <label>Email</label>
                <input type="email" name="email" class="form-control" placeholder="Enter email" required>
            </div>

            <!-- Password -->
            <div class="mb-3">
                <label>Password</label>
                <input type="password" name="password" class="form-control" placeholder="Enter password" required>
            </div>

            <!-- Submit Button -->
            <div class="d-grid mt-4">
                <button type="submit" class="btn btn-custom text-white">Login</button>
            </div>

            <!-- Signup Link -->
            <div class="text-center mt-3">
                <small>Don't have an account? <a href="signup">Sign Up</a></small>
            </div>
            
            <div class="text-center mt-3">
                <small>Forget Password? <a href="forgetpassword">Click Here</a></small>
            </div>

        </form>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
