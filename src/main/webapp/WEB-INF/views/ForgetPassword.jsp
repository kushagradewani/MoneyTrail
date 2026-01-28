<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Forgot Password</title>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

<style>
html, body {
    height: 100%;
    overflow: hidden;
}

body {
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(135deg, #667eea, #764ba2);
    margin: 0;
}

.fp-wrapper {
    height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 15px;
}

.fp-card {
    background: rgba(255, 255, 255, 0.15);
    backdrop-filter: blur(15px);
    border-radius: 20px;
    padding: 30px;
    width: 100%;
    max-width: 420px;
    box-shadow: 0 8px 32px rgba(0,0,0,0.2);
    color: #fff;
}

.fp-card h3 {
    text-align: center;
    font-weight: 600;
    margin-bottom: 25px;
}

.form-control {
    background: rgba(255,255,255,0.2);
    border: none;
    border-radius: 12px;
    color: #fff;
    font-size: 14px;
}

.form-control::placeholder {
    color: #e0e0e0;
}

.form-control:focus {
    background: rgba(255,255,255,0.25);
    box-shadow: none;
    color: #fff;
}

label {
    font-size: 13px;
}

.btn-custom {
    background: linear-gradient(135deg, #ff758c, #ff7eb3);
    border: none;
    border-radius: 30px;
    padding: 10px;
    font-size: 15px;
    width: 100%;
}

a {
    color: #ffe6f0;
    text-decoration: none;
}

a:hover {
    text-decoration: underline;
}

@media (max-width: 576px) {
    .fp-card {
        padding: 20px;
    }
}
</style>
</head>

<body>

<div class="fp-wrapper">
    <div class="fp-card">
        <h3>Forgot Password ✨</h3>

        <form action="ForgotPasswordServlet" method="post">
            <div class="mb-3">
                <label>Registered Email</label>
                <input type="email" name="email" class="form-control" placeholder="Enter email" required>
            </div>

            <button type="submit" class="btn btn-custom text-white mt-3">
                Reset Password
            </button>

            <div class="text-center mt-3">
                <small>
                    Back To Login <a href="login">Click Here</a>
                </small>
            </div>
        </form>
    </div>
</div>

</body>
</html>
