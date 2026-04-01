<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%> 
	
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Expense Details</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

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
    <link href="css/userbootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="css/userstyle.css" rel="stylesheet">
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
    <jsp:include page="UserSidebar.jsp"></jsp:include>
    <!-- SideBar End -->

    <!-- Content Start -->
    <div class="content">
        
        <!-- Navbar -->
        <jsp:include page="UserHeader.jsp"></jsp:include>
        
        <div class="container-fluid pt-4 px-4">
            <div class="bg-secondary rounded p-4">

                <!-- Title -->
                <h3 class="text-white mb-4">Expense Details</h3>

                <div class="row">
                    <!-- LEFT SIDE: Basic Info -->
                    <div class="col-md-6">
                        <div class="row mb-3">
                            <div class="col-md-4 text-muted">Expense ID</div>
                            <div class="col-md-8">${expense.expenseId}</div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-4 text-muted">Title</div>
                            <div class="col-md-8">${expense.title}</div>
                        </div>

                        <div class="row mb-3">
						    <div class="col-md-4 text-muted">Category</div>
						    <div class="col-md-8">
						        ${category.categoryId} - ${category.categoryName}
						    </div>
						</div>

                        <div class="row mb-3">
						    <div class="col-md-4 text-muted">SubCategory</div>
						    <div class="col-md-8">
						        ${subCategory.subCategoryId} - ${subCategory.subCategoryName}
						    </div>
						</div>

                        <div class="row mb-3">
						    <div class="col-md-4 text-muted">Vendor</div>
						    <div class="col-md-8">
						        ${vender.venderId} - ${vender.venderName}
						    </div>
						</div>

                        <div class="row mb-3">
						    <div class="col-md-4 text-muted">Account</div>
						    <div class="col-md-8">
						        ${account.inaccountId} - ${account.title}
						    </div>
						</div>
                    </div>

                    <!-- RIGHT SIDE: More Info -->
                    <div class="col-md-6">
                        <div class="row mb-3">
						    <div class="col-md-4 text-muted">Status</div>
						    <div class="col-md-8">
						        ${status.statusId} - ${status.status}
						    </div>
						</div>

                        <div class="row mb-3">
                            <div class="col-md-4 text-muted">Amount</div>
                            <div class="col-md-8">${expense.amount}</div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-4 text-muted">Date</div>
                            <div class="col-md-8">${expense.date}</div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-4 text-muted">Description</div>
                            <div class="col-md-8">${expense.description}</div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-4 text-muted">User ID</div>
                            <div class="col-md-8">${expense.userId}</div>
                        </div>

                        <div class="row mb-3">
                            <div class="col-md-4 text-muted">Active</div>
                            <div class="col-md-8">
                                <c:choose>
                                    <c:when test="${expense.active}">
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
                    <a href="/userExpenseList" class="btn btn-dark me-2">Back</a>
                    <a href="/userEditExpense?expenseId=${expense.expenseId}" class="btn btn-warning">Edit</a>
                </div>

            </div>
        </div>

        <!-- Footer -->
        <jsp:include page="UserFooter.jsp"></jsp:include>

    </div>
    <!-- Content End -->

    <!-- Back to Top -->
    <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
</div>
</body>
</html>