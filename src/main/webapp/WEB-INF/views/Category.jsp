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
            <!-- Navbar Start -->
            <jsp:include page="Header.jsp"></jsp:include>  
            <!-- Navbar End -->
            
            <div class="col-sm-12 col-xl-6 pt-4 px-4">
			    <div class="bg-secondary rounded h-100 p-4">
			        <div class="d-flex justify-content-between align-items-center mb-4">
					    <h6 class="mb-0">Add Category</h6>
					    <a href="categoryList" class="btn btn-sm btn-outline-light">
					        View All Categories
					    </a>
					</div>

			
			        <form action="saveCategory" method="post">
			
			            <!-- Hidden Category ID -->
			            <input type="hidden" name="categoryId" value="">
			
			            <!-- Category Name -->
			            <div class="mb-3">
			                <label for="categoryName" class="form-label">Category Name</label>
			                <input 
			                    type="text" 
			                    class="form-control" 
			                    id="categoryName"
			                    name="categoryName"
			                    placeholder="Enter category name"
			                    required>
			            </div>
			            
			            <small class="text-muted fst-italic">
					        Example: Food, Transport, Utilities, Shopping, Salary
					    </small><br><br>
			
			            <!-- Submit Button -->
			            <button type="submit" class="btn btn-primary">
			                Save Category
			            </button>
			            <a href="categoryList" class="btn btn-secondary">
		                    Cancel
		                </a>
			
			        </form>
			    </div>
			</div>
            <!-- Footer Start -->
            <jsp:include page="Footer.jsp"></jsp:include>
            <!-- Footer End -->
        </div>
        <!-- Content End -->


        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
    </div>
</body>

</html>