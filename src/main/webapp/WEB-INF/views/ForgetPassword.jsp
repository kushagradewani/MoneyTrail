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
                            <a href="" class="">
                                <h3 class="text-primary"><i class="fa fa-lock me-2"></i>DarkPan</h3>
                            </a>
                            <h5>Reset Password</h5>
                    </div>

                    <form id="forgotForm" action="forgotPassword" method="post">

                        <!-- Email Field -->
                        <div class="form-floating mb-3">
                            <input type="email" class="form-control"
                                   id="email"
                                   name="email"
                                   placeholder="name@example.com"
                                   required>
                            <label for="email">Email Address</label>
                        </div>

                        <!-- OTP Field (Hidden Initially) -->
                        <div class="form-floating mb-3 d-none" id="otpDiv">
                            <input type="text" class="form-control"
                                   id="otp"
                                   name="otp"
                                   placeholder="Enter OTP">
                            <label for="otp">Enter OTP</label>
                        </div>

                        <!-- Button -->
                        <button type="button"
                                id="actionBtn"
                                class="btn btn-primary py-3 w-100 mb-3"
                                onclick="handleAction()">
                            Send OTP
                        </button>

                        <div class="text-center">
                            <small>
                                Remember your password?
                                <a href="login">Sign In</a>
                            </small>
                        </div>

                    </form>

                </div>
            </div>
        </div>
    </div>
</div>

<!-- JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    let otpStage = false;

    function handleAction() {

        if (!otpStage) {
            // Step 1: Send OTP
            document.getElementById("otpDiv").classList.remove("d-none");
            document.getElementById("actionBtn").innerText = "Reset Password";
            otpStage = true;

            // Optional: Call backend to generate/send OTP
            fetch("sendOtp", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: "email=" + document.getElementById("email").value
            });
        } else {
            // Step 2: Submit form to verify OTP & send reset link
            document.getElementById("forgotForm").submit();
        }
    }
</script>

<!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/chart/chart.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="lib/tempusdominus/js/moment.min.js"></script>
    <script src="lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

    <!-- Template Javascript -->
    <script src="js/main.js"></script>

</body>
</html>