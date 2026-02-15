<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Category</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Roboto:wght@500;700&display=swap" rel="stylesheet"> 
    
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
        <div id="spinner" class="show bg-dark position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
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
		
		    <!-- Navbar -->
		    <jsp:include page="Header.jsp"></jsp:include>
		
		    <div class="container-fluid pt-4 px-4">
		        <div class="bg-secondary rounded p-4">
		
		            <!-- Title -->
		            <h3 class="text-white mb-4">User Details</h3>
		
		            <div class="row">
		            	<!-- Profile Picture -->
					    <c:choose>
	                        <c:when test="${not empty user.profilePicURL}">
	                            <img src="${user.profilePicURL}" class="profile-pic">
	                        </c:when>
	                        <c:otherwise>
	                            <img src="https://via.placeholder.com/120"
	                                 class="profile-pic">
	                        </c:otherwise>
	                    </c:choose>
		
		                <!-- LEFT SIDE (Role Badge Only) -->
		                <div class="col-md-3">
		                    <span class="badge bg-info text-dark px-3 py-2">
		                        ${user.role}
		                    </span>
		                </div>
		
		                <!-- RIGHT SIDE (User Information) -->
		                <div class="col-md-9">
		
		                    <div class="row mb-3">
		                        <div class="col-md-4 text-muted">User ID</div>
		                        <div class="col-md-8">${user.userId}</div>
		                    </div>
		
		                    <div class="row mb-3">
		                        <div class="col-md-4 text-muted">Full Name</div>
		                        <div class="col-md-8">
		                            ${user.firstName} ${user.lastName}
		                        </div>
		                    </div>
		
		                    <div class="row mb-3">
		                        <div class="col-md-4 text-muted">Email</div>
		                        <div class="col-md-8">${user.email}</div>
		                    </div>
		
		                    <div class="row mb-3">
		                        <div class="col-md-4 text-muted">Gender</div>
		                        <div class="col-md-8">${user.gender}</div>
		                    </div>
		
		                    <div class="row mb-3">
		                        <div class="col-md-4 text-muted">Birth Year</div>
		                        <div class="col-md-8">${user.birthYear}</div>
		                    </div>
		
		                    <div class="row mb-3">
		                        <div class="col-md-4 text-muted">Contact Number</div>
		                        <div class="col-md-8">${user.contactNum}</div>
		                    </div>
		
		                    <div class="row mb-3">
		                        <div class="col-md-4 text-muted">Created At</div>
		                        <div class="col-md-8">${user.createdAt}</div>
		                    </div>
		
		                    <div class="row mb-3">
		                        <div class="col-md-4 text-muted">Status</div>
		                        <div class="col-md-8">
		                            <c:choose>
		                                <c:when test="${user.active}">
		                                    <span class="badge bg-success">Active</span>
		                                </c:when>
		                                <c:otherwise>
		                                    <span class="badge bg-danger">Inactive</span>
		                                </c:otherwise>
		                            </c:choose>
		                        </div>
		                    </div>
		
		                </div>
		            </div>
		
		            <!-- Buttons -->
		            <div class="d-flex justify-content-end mt-4">
		                <a href="userList" class="btn btn-dark me-2">
		                    Back
		                </a>
		                <a href="editUser?userId=${user.userId}" 
		                   class="btn btn-warning">
		                    Edit
		                </a>
		            </div>
		
		        </div>
		    </div>
		
		    <!-- Footer -->
		    <jsp:include page="Footer.jsp"></jsp:include>
		
		</div>
		<!-- Content End -->

		<!-- Content End -->

        <!-- Content End -->


        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
    </div>
</body>

</html>