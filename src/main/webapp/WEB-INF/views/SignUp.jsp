<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Registration</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <meta name="viewport" content="width=device-width, initial-scale=1">

    <style>
        html, body {
            height: 100%;
            overflow-y: auto;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea, #764ba2);
            margin: 0;
        }

        .login-wrapper {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 15px;
        }

        .login-card {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(15px);
            border-radius: 20px;
            padding: 30px;
            width: 100%;
            max-width: 480px;
            box-shadow: 0 8px 32px rgba(0,0,0,0.2);
            color: #fff;
        }

        .login-card h3 {
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
            margin-bottom: 4px;
        }

        .btn-custom {
            background: linear-gradient(135deg, #ff758c, #ff7eb3);
            border: none;
            border-radius: 30px;
            padding: 10px;
            font-size: 15px;
            width: 100%;
            color: #fff;
            font-weight: 500;
        }

        .form-check-label {
            font-size: 13px;
        }
        
        a {
		    color: #ffe6f0;
		    text-decoration: none;
		}
		
		a:hover {
		    text-decoration: underline;
		}

        @media (max-width: 576px) {
            .login-card {
                padding: 20px;
            }
        }
    </style>
</head>

<body>

<div class="login-wrapper">
    <div class="login-card">

        <h3>Create Account ✨</h3>

        <form action="register" method="post" >  <!--enctype="multipart/form-data"-->

            <div class="mb-3">
                <label>First Name</label>
                <input type="text" name="firstName" class="form-control" placeholder="John" required>
            </div>

            <div class="mb-3">
                <label>Last Name</label>
                <input type="text" name="lastName" class="form-control" placeholder="Doe" required>
            </div>

            <div class="mb-3">
                <label>Email</label>
                <input type="email" name="email" class="form-control" placeholder="john@example.com" required>
            </div>

            <div class="mb-3">
                <label>Password</label>
                <input type="password" name="password" class="form-control" placeholder="••••••••" required>
            </div>

            <div class="mb-3">
                <label class="d-block">Gender</label>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="gender" value="MALE" required>
                    <label class="form-check-label">Male</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="gender" value="FEMALE">
                    <label class="form-check-label">Female</label>
                </div>
                <div class="form-check form-check-inline">
                    <input class="form-check-input" type="radio" name="gender" value="OTHER">
                    <label class="form-check-label">Other</label>
                </div>
            </div>

            <div class="mb-3">
                <label>Birth Year</label>
                <input type="number" name="birthYear" class="form-control" min="1900" max="2100" required>
            </div>

            <div class="mb-3">
                <label>Contact Number</label>
                <input type="text" name="contactNum" class="form-control" placeholder="+91 9876543210" required>
            </div>

            <div class="mb-4">
                <label>Profile Picture</label>
                <input type="file" name="profilePicURL" class="form-control">
            </div>

            <div class="d-grid mt-4">
	            <button type="submit" class="btn btn-custom text-white">
	                Sign Up
	            </button>
	        </div>
            
            <div class="text-center mt-3">
                <small>
                    Already have an account? <a href="login">Login</a>
                </small>
            </div>

        </form>

    </div>
</div>

</body>
</html>
