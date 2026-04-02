<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>User Home</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <!-- Favicon -->
    <link href="${pageContext.request.contextPath}/img/favicon.ico" rel="icon">

    <!-- Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Roboto:wght@500;700&display=swap" rel="stylesheet"> 
    
    <!-- Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- CSS -->
    <link href="css/userbootstrap.min.css" rel="stylesheet">
    <link href="css/userstyle.css" rel="stylesheet">
    
    <!-- DataTables Core CSS -->
<link rel="stylesheet" href="https://cdn.datatables.net/2.3.7/css/dataTables.dataTables.css">

<!-- DataTables Buttons CSS -->
<link rel="stylesheet" href="https://cdn.datatables.net/buttons/3.2.6/css/buttons.dataTables.css">
</head>

<body>

<!-- ================= NAVBAR START ================= -->
<nav class="navbar navbar-expand bg-secondary navbar-dark sticky-top px-4 py-0">

    <!-- Logo -->
    <a href="#" class="navbar-brand d-flex d-lg-none me-4">
        <h2 class="text-primary mb-0"><i class="fa fa-user-edit"></i></h2>
    </a>

	
    <!-- Sidebar Toggle -->
    <a href="#" class="sidebar-toggler flex-shrink-0">
        <i class="fa fa-bars"></i>
    </a>

    <!-- Search -->
    <form class="d-none d-md-flex ms-4">
        <input class="form-control bg-dark border-0" type="search" placeholder="Search">
    </form>

    <!-- Right Menu -->
    <div class="navbar-nav align-items-center ms-auto">

        <!-- Messages -->
        <!-- <div class="nav-item dropdown">
            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                <i class="fa fa-envelope me-lg-2"></i>
                <span class="d-none d-lg-inline-flex">Message</span>
            </a>
        </div> -->

        <!-- Notifications -->
        <!-- <div class="nav-item dropdown">
            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                <i class="fa fa-bell me-lg-2"></i>
                <span class="d-none d-lg-inline-flex">Notification</span>
            </a>
        </div> -->

        <c:choose>

            <%-- ================= USER LOGGED IN ================= --%>
            <c:when test="${not empty sessionScope.user}">
                <div class="nav-item dropdown">
                    <a href="#" class="nav-link dropdown-toggle d-flex align-items-center" data-bs-toggle="dropdown">

                        <%-- Profile Image --%>
                        <c:choose>
                            <c:when test="${not empty sessionScope.user.profilePicURL}">
                                <img class="rounded-circle me-2"
                                     src="${sessionScope.user.profilePicURL}"
                                     style="width: 40px; height: 40px;">
                            </c:when>
                            <c:otherwise>
                                <img class="rounded-circle me-2"
                                     src="${pageContext.request.contextPath}/img/user.jpg"
                                     style="width: 40px; height: 40px;">
                            </c:otherwise>
                        </c:choose>

                        <%-- User Name --%>
                        <span>${sessionScope.user.firstName}</span>
                    </a>

                    <%-- Dropdown --%>
                    <div class="dropdown-menu dropdown-menu-end bg-secondary border-0 rounded-0 rounded-bottom m-0">
                        <a href="${pageContext.request.contextPath}/profile" class="dropdown-item">My Profile</a>
                        <a href="#" class="dropdown-item">Settings</a>
                        <a href="${pageContext.request.contextPath}/logout" class="dropdown-item">Log Out</a>
                    </div>
                </div>
            </c:when>

            <%-- ================= USER NOT LOGGED IN ================= --%>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login" class="btn btn-primary ms-3">
                    Login
                </a>
            </c:otherwise>

        </c:choose>
        
        

    </div>
</nav>
<!-- ================= NAVBAR END ================= -->

<script>
document.querySelector(".sidebar-toggler").addEventListener("click", function (e) {
    e.preventDefault();

    document.querySelector(".sidebar").classList.toggle("open");
    document.querySelector(".content").classList.toggle("open");
});
</script>

</body>
</html>