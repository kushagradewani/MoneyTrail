<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- Sidebar Start -->
        <div class="sidebar pe-4 pb-3">
            <nav class="navbar bg-secondary navbar-dark">
                <a href="index.html" class="navbar-brand mx-4 mb-3">
                    <h3 class="text-primary"><i class="fa fa-user-edit me-2"></i>MoneyTrail</h3>
                </a>
                <div class="d-flex align-items-center ms-4 mb-4">
                    <div class="position-relative">
                        <c:choose>
						    <c:when test="${not empty sessionScope.user.profilePicURL}">
						        <img class="rounded-circle me-lg-2"
						             src="${sessionScope.user.profilePicURL}"
						             alt="Profile"
						             style="width: 40px; height: 40px;">
						    </c:when>
						    <c:otherwise>
						        <img class="rounded-circle me-lg-2"
						             src="${pageContext.request.contextPath}/img/user.jpg"
						             alt="Profile"
						             style="width: 40px; height: 40px;">
						    </c:otherwise>
						</c:choose>

                    </div>
                    <div class="ms-3">
                        <c:choose>
						    <c:when test="${not empty sessionScope.user}">
						        <h6 class="mb-0">
						            ${sessionScope.user.firstName} 
						            ${sessionScope.user.lastName}
						        </h6>
						        <span>${sessionScope.user.role}</span>
						    </c:when>
						
						    <c:otherwise>
						        <h6 class="mb-0">Guest User</h6>
						        <span>Visitor</span>
						    </c:otherwise>
						</c:choose>

                    </div>
                </div>
                <div class="navbar-nav w-100">
                    <a href="/" class="nav-item nav-link active"><i class="fa fa-tachometer-alt me-2"></i>Dashboard</a>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-laptop me-2"></i>User</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="user" class="dropdown-item">Add New User</a>
                            <a href="userList" class="dropdown-item">View List User</a>
                        </div>
                    </div>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-laptop me-2"></i>Category</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="category" class="dropdown-item">Add New Category</a>
                            <a href="categoryList" class="dropdown-item">View List Category</a>
                        </div>
                    </div>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-laptop me-2"></i>Sub Category</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="subCategory" class="dropdown-item">Add New Sub Category</a>
                            <a href="subCategoryList" class="dropdown-item">View List Sub Category</a>
                        </div>
                    </div>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-laptop me-2"></i>Vender</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="vender" class="dropdown-item">Add New Vender</a>
                            <a href="venderList" class="dropdown-item">View List Vender</a>
                        </div>
                    </div>
                    

                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-laptop me-2"></i>Account</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="account" class="dropdown-item">Add New Account</a>
                            <a href="accountList" class="dropdown-item">View List Account</a>
                        </div>
                    </div>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-laptop me-2"></i>Expense</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="expense" class="dropdown-item">Add New Expense</a>
                            <a href="expenseList" class="dropdown-item">View List Expense</a>
                        </div>
                    </div>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-laptop me-2"></i>Income</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="income" class="dropdown-item">Add New Income</a>
                            <a href="incomeList" class="dropdown-item">View List Income</a>
                        </div>
                    </div>
                    
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="far fa-file-alt me-2"></i>Pages</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="login" class="dropdown-item">Sign In</a>
                            <a href="signup" class="dropdown-item">Sign Up</a>
                            <a href="404.html" class="dropdown-item">404 Error</a>
                            <a href="blank.html" class="dropdown-item">Blank Page</a>
                        </div>
                    </div>
                </div>
            </nav>
        </div>
        <!-- Sidebar End -->