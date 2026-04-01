<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="utf-8">
            <title>User Home</title>
            <meta content="width=device-width, initial-scale=1.0" name="viewport">
            <meta content="" name="keywords">
            <meta content="" name="description">

            <!-- Favicon -->
            <link href="img/favicon.ico" rel="icon">

            <!-- Google Web Fonts -->
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link
                href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Roboto:wght@500;700&display=swap"
                rel="stylesheet">

            <!-- Icon Font Stylesheet -->
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

            <!-- Libraries Stylesheet -->
            <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
            <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

            <!-- Customized Bootstrap Stylesheet -->
            <link href="css/bootstrap.min.css" rel="stylesheet">

            <!-- Template Stylesheet -->
            <link href="css/style.css" rel="stylesheet">
        </head>

        <body>
            <div class="container-fluid position-relative d-flex p-0">
                <!-- Spinner Start -->
                <div id="spinner"
                    class="show bg-dark position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
                    <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                        <span class="sr-only">Loading...</span>
                    </div>
                </div>
                <!-- Spinner End -->


                <!-- SideBar Start -->
                <jsp:include page="Sidebar.jsp"></jsp:include>
                <!-- SideBar End -->


                <!-- Content Start -->
                <div class="content">
                    <!-- Navbar Start -->
                    <jsp:include page="Header.jsp"></jsp:include>
                    <!-- Navbar End -->

                    <!-- Profile Start -->
					<div class="container-fluid pt-4 px-4">
					    <div class="row g-4">
					
					        <!-- Profile Card -->
					        <div class="col-sm-12 col-xl-4">
					            <div class="bg-secondary rounded p-4 text-center">
					
					                <img src="${sessionScope.user.profilePicURL}" 
					                     class="rounded-circle mb-3"
					                     style="width:120px;height:120px;border:3px solid #05e8fc;object-fit:cover;">
					
					                <h4>${sessionScope.user.firstName} ${sessionScope.user.lastName}</h4>
					                <p class="text-muted">${sessionScope.user.email}</p>
					
					                <span class="badge bg-info text-dark">${sessionScope.user.role}</span>
					
					                <hr>
					
					                <p><strong>Contact:</strong> ${sessionScope.user.contactNum}</p>
					                <p><strong>Gender:</strong> ${sessionScope.user.gender}</p>
					                <p><strong>Birth Year:</strong> ${sessionScope.user.birthYear}</p>
					
					                <p><strong>Status:</strong>
					                    <c:choose>
					                        <c:when test="${sessionScope.user.active}">
					                            <span class="text-success">Active</span>
					                        </c:when>
					                        <c:otherwise>
					                            <span class="text-danger">Inactive</span>
					                        </c:otherwise>
					                    </c:choose>
					                </p>
					
					                <p><small>Joined: ${sessionScope.user.createdAt}</small></p>
					            </div>
					        </div>
					
					        <!-- Edit Profile -->
					        <div class="col-sm-12 col-xl-8">
					            <div class="bg-secondary rounded p-4">
					
					                <h4 class="mb-4 text-primary">Edit Profile</h4>
					
					                <form action="updateAdmin" method="post" enctype="multipart/form-data">
					
					                    <input type="hidden" name="userId" value="${sessionScope.user.userId}"/>
					
					                    <div class="row">
					                        <div class="col-md-6 mb-3">
					                            <label>First Name</label>
					                            <input type="text" name="firstName" class="form-control bg-dark text-white border-0"
					                                value="${sessionScope.user.firstName}">
					                        </div>
					
					                        <div class="col-md-6 mb-3">
					                            <label>Last Name</label>
					                            <input type="text" name="lastName" class="form-control bg-dark text-white border-0"
					                                value="${sessionScope.user.lastName}">
					                        </div>
					                    </div>
					
					                    <div class="mb-3">
					                        <label>Email</label>
					                        <input type="email" name="email" class="form-control bg-dark text-white border-0"
					                            value="${sessionScope.user.email}">
					                    </div>
					
					                    <%-- <div class="mb-3">
					                        <label>Password</label>
					                        <input type="password" name="password" class="form-control bg-dark text-white border-0"
					                            value="${sessionScope.user.password}">
					                    </div> --%>
					
					                    <div class="row">
					                        <div class="col-md-6 mb-3">
					                            <label>Gender</label>
					                            <select name="gender" class="form-control bg-dark text-white border-0">
					                                <option ${sessionScope.user.gender == 'Male' ? 'selected' : ''}>Male</option>
					                                <option ${sessionScope.user.gender == 'Female' ? 'selected' : ''}>Female</option>
					                            </select>
					                        </div>
					
					                        <div class="col-md-6 mb-3">
					                            <label>Birth Year</label>
					                            <input type="number" name="birthYear"
					                                class="form-control bg-dark text-white border-0"
					                                value="${sessionScope.user.birthYear}">
					                        </div>
					                    </div>
					
					                    <div class="mb-3">
					                        <label>Contact Number</label>
					                        <input type="text" name="contactNum"
					                            class="form-control bg-dark text-white border-0"
					                            value="${sessionScope.user.contactNum}">
					                    </div>
					
					                    <div class="mb-3">
										    <label>Profile Picture</label>
										
										    <!-- Current Image Preview -->
										    <div class="mb-2 text-center">
										        <img id="previewImg"
										             src="${sessionScope.user.profilePicURL}"
										             class="rounded-circle"
										             style="width:100px;height:100px;object-fit:cover;border:2px solid #05e8fc;">
										    </div>
										
										    <!-- File Upload -->
										    <label class="form-label">Profile Picture</label>
				                            <input type="file" name="profilePic" class="form-control">
										</div>
					
					                    <%-- <div class="row">
					                        <div class="col-md-6 mb-3">
					                            <label>Role</label>
					                            <select name="role" class="form-control bg-dark text-white border-0">
					                                <option ${sessionScope.user.role == 'Admin' ? 'selected' : ''}>Admin</option>
					                                <option ${sessionScope.user.role == 'Customer' ? 'selected' : ''}>Customer</option>
					                            </select>
					                        </div>
					
					                        <div class="col-md-6 mb-3">
					                            <label>Status</label>
					                            <select name="active" class="form-control bg-dark text-white border-0">
					                                <option value="true" ${sessionScope.user.active ? 'selected' : ''}>Active</option>
					                                <option value="false" ${!sessionScope.user.active ? 'selected' : ''}>Inactive</option>
					                            </select>
					                        </div>
					                    </div> --%>
					
					                    <button type="submit" class="btn btn-primary w-100">Update Profile</button>
					
					                </form>
					            </div>
					        </div>
					
					    </div>
					</div>
					<!-- Profile End -->


                    <!-- Footer Start -->
                    <jsp:include page="Footer.jsp"></jsp:include>

                    <!-- Template Javascript -->
                    <script src="js/usermain.js"></script>
                    <!-- Footer End -->
                </div>
                <!-- Content End -->


                <!-- Back to Top -->
                <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
            </div>
        </body>

        </html>