<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Forgot Password</title>

    <!-- Bootstrap CSS -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

    <style>
        body {
            background: #000000;
        }

        .bg-secondary {
            background: #191C24 !important;
            border-radius: 12px;
            border: 1px solid #2a2e39;
        }

        .form-control {
            background: #000000;
            border: 1px solid #6C7293;
            color: #fff;
        }

        .form-control:focus {
            border-color: #EB1616;
            box-shadow: 0 0 8px #EB1616;
        }

        .btn-primary {
            background: #EB1616;
            border: none;
        }

        .btn-primary:hover {
            background: #c51212;
        }

        .text-primary {
            color: #EB1616 !important;
        }

        .message {
            font-size: 13px;
            margin-top: 5px;
        }
    </style>
</head>

<body>
<div class="container-fluid position-relative d-flex p-0">

    <!-- Spinner -->
    <div id="spinner"
         class="show bg-dark position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
        <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
            <span class="sr-only">Loading...</span>
        </div>
    </div>

    <!-- Forgot Password -->
    <div class="container-fluid">
        <div class="row h-100 align-items-center justify-content-center" style="min-height: 100vh;">
            <div class="col-12 col-sm-8 col-md-6 col-lg-5 col-xl-4">
                <div class="bg-secondary rounded p-4 p-sm-5 my-4 mx-3">

                    <div class="d-flex align-items-center justify-content-between mb-3">
                        <a href="#">
                            <h3 class="text-primary"><i class="fa fa-lock me-2"></i>Money Trail</h3>
                        </a>
                        <h5 class="text-light">Reset Password</h5>
                    </div>

                    <form id="forgotForm" action="ResetPassword" method="post">

                        <!-- Email Field -->
                        <div class="form-floating mb-1">
                            <input type="email" class="form-control"
                                   id="email"
                                   name="email"
                                   placeholder="name@example.com"
                                   required
                                   oninput="clearMessage()">
                            <label for="email">Email Address</label>
                        </div>

                        <!-- Inline Message -->
                        <div id="message" class="message text-primary"></div>

                        <!-- OTP Field (Hidden Initially) -->
                        <div class="form-floating mb-3 d-none" id="otpDiv">
                            <input type="text" class="form-control"
                                   id="otp"
                                   name="otp"
                                   placeholder="Enter OTP">
                            <label for="otp">Enter OTP</label>
                        </div>

                        <!-- Button -->
                        <br>
                        <button type="button"
                                id="actionBtn"
                                class="btn btn-primary py-3 w-100 mb-3"
                                onclick="handleAction()">
                            Send OTP
                        </button>

                        <div class="text-center">
                            <small class="text-light">
                                Remember your password?
                                <a href="login" class="text-primary">Sign In</a>
                            </small>
                        </div>

                    </form>

                </div>
            </div>
        </div>
    </div>
</div>

<!-- JS -->
<script>
    let otpStage = false;

    function clearMessage() {
        document.getElementById("message").innerText = "";
    }

    function handleAction() {

        let email = document.getElementById("email").value.trim();
        let message = document.getElementById("message");

        if (!otpStage) {

            if (email === "") {
                message.innerText = "⚠️ Please enter your email address";
                message.style.color = "#EB1616";
                return;
            }

            // Step 1: Show OTP field
            document.getElementById("otpDiv").classList.remove("d-none");
            document.getElementById("actionBtn").innerText = "Verify OTP";
            message.innerText = "✔ OTP sent to your email";
            message.style.color = "#6C7293";
            otpStage = true;

            // Send OTP to backend
            fetch("sendOtp", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: "email=" + email
            });

        } else {
            // Step 2: Submit form to verify OTP
            document.getElementById("forgotForm").submit();
        }
    }
</script>

<!-- JS Libraries -->
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="js/main.js"></script>

</body>
</html>