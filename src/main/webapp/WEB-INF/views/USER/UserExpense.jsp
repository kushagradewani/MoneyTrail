<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Expense</title>
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
            <!-- Navbar Start -->
            <jsp:include page="UserHeader.jsp"></jsp:include>  
            <!-- Navbar End -->
            
            <div class="col-sm-12 col-xl-6 pt-4 px-4">
			    <div class="bg-secondary rounded h-100 p-4">
			        <div class="d-flex justify-content-between align-items-center mb-4">
					    <h6 class="mb-0">Add Expense</h6>
					    <a href="/user/expenseList" class="btn btn-sm btn-outline-light">
					        View All Expense
					    </a>
					</div>

			
			        <form action="/user/saveExpense" method="post" class="glass-form p-4">

					    <!-- Title -->
					    <div class="mb-3">
					        <label class="form-label">Title</label>
					        <input type="text" class="form-control" name="title" placeholder="Expense title" required>
					    </div>
					
					    <!-- Category -->
					    <div class="mb-3">
					        <label class="form-label">Category</label>
					        <select class="form-select" name="categoryId" required>
					            <option value="">Select Category</option>
					            <c:forEach var="cat" items="${allCategory}">
					                <option value="${cat.categoryId}">
					                    ${cat.categoryName}
					                </option>
					            </c:forEach>
					        </select>
					    </div>
					
					    <!-- Sub Category -->
					    <div class="mb-3">
					        <label class="form-label">Sub Category</label>
					        <select class="form-select" name="subCategoryId">
					            <option value="">Select Sub Category</option>
					            <c:forEach var="sub" items="${allSubCategory}">
					                <option value="${sub.subCategoryId}">
					                    ${sub.subCategoryName}
					                </option>
					            </c:forEach>
					        </select>
					    </div>
					
					    <!-- Vendor -->
					    <div class="mb-3">
					        <label class="form-label">Vendor</label>
					        <select class="form-select" name="venderId">
					            <option value="">Select Vendor</option>
					            <c:forEach var="ven" items="${allVender}">
					                <option value="${ven.venderId}">
					                    ${ven.venderName}
					                </option>
					            </c:forEach>
					        </select>
					    </div>
					
					    <!-- Account -->
					    <div class="mb-3">
					        <label class="form-label">Account</label>
					        <select class="form-select" name="inaccountId" required>
					            <option value="">Select Account</option>
					            <c:forEach var="acc" items="${allAccount}">
					                <option value="${acc.inaccountId}">
					                    ${acc.title}
					                </option>
					            </c:forEach>
					        </select>
					    </div>
					
					    <!-- Status -->
					    <div class="mb-3">
					        <label class="form-label">Status</label>
					        <select class="form-select" name="statusId">
					            <option value="">Select Status</option>
					            <c:forEach var="st" items="${allStatus}">
					                <option value="${st.statusId}">
					                    ${st.status}
					                </option>
					            </c:forEach>
					        </select>
					    </div>
					
					    <!-- Amount -->
					    <div class="mb-3">
					        <label class="form-label">Amount</label>
					        <input type="number" class="form-control" name="amount" placeholder="₹ Amount" required>
					    </div>
					
					    <!-- Date -->
					    <div class="mb-3">
					        <label class="form-label">Date</label>
					        <input type="date" class="form-control" name="date">
					    </div>
					
					    <!-- Description -->
					    <div class="mb-3">
					        <label class="form-label">Description</label>
					        <textarea class="form-control" name="description" rows="3" placeholder="Optional notes"></textarea>
					    </div>
					
					    <!-- User ID (Hidden) -->
					    <input type="hidden" name="userId" value="${sessionScope.userId}">
					
					    <!-- Buttons -->
					    <button type="submit" class="btn btn-primary">Save Expense</button>
					    <a href="/user/expenseList" class="btn btn-secondary">Cancel</a>
					
					</form>

			    </div>
			</div>
            <!-- Footer Start -->
            <jsp:include page="UserFooter.jsp"></jsp:include>
            <!-- Footer End -->
        </div>
        <!-- Content End -->


        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
    </div>
</body>

</html>