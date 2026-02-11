<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Add Sub Category</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="CSS.jsp"></jsp:include>

</head>
<body>

<div class="container-fluid wrapper">

    <!-- HEADER -->
    <jsp:include page="Header.jsp"/>

    <!-- BODY -->
    <div class="row">

        <!-- SIDEBAR -->
        <jsp:include page="Sidebar.jsp"/>

        <!-- RIGHT CONTENT -->
        <div class="col-md-10">
            <div class="glass p-4">

                <!-- PAGE CONTENT GOES HERE -->
                <h3 class="text-center mb-4">Add Sub Category 🧩</h3>

				<div class="row justify-content-center">
				    <div class="col-md-5">
				        <form action="saveSubCategory" method="post">
				
				            <!-- Hidden Sub Category ID (for PK) -->
				            <input type="hidden" name="subCategoryId" value="">
				
				            <!-- Category Dropdown -->
				            <div class="mb-3">
				                <label>Category</label>
				                <select class="form-select" name="categoryId" required>
				                    <option value="">Select Category</option>
				                    <option value="1">Food</option>
				                    <option value="2">Travel</option>
				                    <option value="3">Shopping</option>
				                </select>
				            </div>
				
				            <!-- Sub Category Name -->
				            <div class="mb-3">
				                <label>Sub Category Name</label>
				                <input type="text" class="form-control" name="subCategoryName" placeholder="Enter sub category name" required>
				            </div>
				
				            <!-- Save Button -->
				            <button class="btn btn-custom w-100">Save Sub Category</button>
				
				        </form>
				    </div>
				</div>

				                

            </div>
        </div>

    </div>

    <!-- FOOTER -->
    <jsp:include page="Footer.jsp"/>

</div>

</body>
</html>
