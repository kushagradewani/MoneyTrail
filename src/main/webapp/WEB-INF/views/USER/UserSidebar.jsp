<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- Sidebar Start -->
<div class="sidebar pe-4 pb-3">
	<nav class="navbar bg-secondary navbar-dark">

		<a href="/" class="navbar-brand mx-4 mb-3">
			<h3 class="text-primary">
				<i class="fa fa-user-edit me-2"></i>MoneyTrail
			</h3>
		</a>

		<!-- User Profile -->
		<div class="d-flex align-items-center ms-4 mb-4">

			<div class="position-relative">

				<c:choose>
					<c:when test="${not empty sessionScope.user.profilePicURL}">
						<img class="rounded-circle me-lg-2"
							src="${sessionScope.user.profilePicURL}"
							alt="Profile"
							style="width:40px;height:40px;">
					</c:when>

					<c:otherwise>
						<img class="rounded-circle me-lg-2"
							src="${pageContext.request.contextPath}/img/user.jpg"
							alt="Profile"
							style="width:40px;height:40px;">
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

		<!-- Menu -->
		<div class="navbar-nav w-100">

			<!-- Dashboard -->
			<a href="/Home" 
			class="nav-item nav-link ${activePage=='dashboard'?'active':''}">
				<i class="fa fa-tachometer-alt me-2"></i>Dashboard
			</a>


			<!-- User -->
			<%-- <div class="nav-item dropdown">

				<a href="#"
					class="nav-link dropdown-toggle 
					${activePage=='user'||activePage=='userList'?'active':''}"
					data-bs-toggle="dropdown">

					<i class="fa fa-users me-2"></i>User
				</a>

				<div class="dropdown-menu bg-transparent border-0">

					<a href="user"
						class="dropdown-item ${activePage=='user'?'active':''}">
						Add New User
					</a>

					<a href="userList"
						class="dropdown-item ${activePage=='userList'?'active':''}">
						View List User
					</a>

				</div>

			</div> --%>


			<!-- Category -->
			<div class="nav-item dropdown">

				<a href="#"
					class="nav-link dropdown-toggle 
					${activePage=='category'||activePage=='categoryList'?'active':''}"
					data-bs-toggle="dropdown">

					<i class="fa fa-list me-2"></i>Category
				</a>

				<div class="dropdown-menu bg-transparent border-0">

					<%-- <a href="category"
						class="dropdown-item ${activePage=='category'?'active':''}">
						Add New Category
					</a> --%>

					<a href="/usercategoryList"
						class="dropdown-item ${activePage=='categoryList'?'active':''}">
						View List Category
					</a>

				</div>

			</div>


			<!-- SubCategory -->
			<div class="nav-item dropdown">

				<a href="#"
					class="nav-link dropdown-toggle 
					${activePage=='subCategory'||activePage=='subCategoryList'?'active':''}"
					data-bs-toggle="dropdown">

					<i class="fa fa-layer-group me-2"></i>Sub Category
				</a>

				<div class="dropdown-menu bg-transparent border-0">

					<%-- <a href="subCategory"
						class="dropdown-item ${activePage=='subCategory'?'active':''}">
						Add New Sub Category
					</a> --%>

					<a href="/user/subCategoryList"
						class="dropdown-item ${activePage=='subCategoryList'?'active':''}">
						View List Sub Category
					</a>

				</div>

			</div>


			<!-- Vender -->
			<div class="nav-item dropdown">

				<a href="#"
					class="nav-link dropdown-toggle 
					${activePage=='vender'||activePage=='venderList'?'active':''}"
					data-bs-toggle="dropdown">

					<i class="fa fa-store me-2"></i>Vender
				</a>

				<div class="dropdown-menu bg-transparent border-0">

					<%-- <a href="vender"
						class="dropdown-item ${activePage=='vender'?'active':''}">
						Add New Vender
					</a> --%>

					<a href="/user/venderList"
						class="dropdown-item ${activePage=='venderList'?'active':''}">
						View List Vender
					</a>

				</div>

			</div>


			<!-- Account -->
			<div class="nav-item dropdown">

				<a href="#"
					class="nav-link dropdown-toggle 
					${activePage=='account'||activePage=='accountList'?'active':''}"
					data-bs-toggle="dropdown">

					<i class="fa fa-wallet me-2"></i>Account
				</a>

				<div class="dropdown-menu bg-transparent border-0">

					<a href="/user/account"
						class="dropdown-item ${activePage=='account'?'active':''}">
						Add New Account
					</a>

					<a href="/user/accountList"
						class="dropdown-item ${activePage=='accountList'?'active':''}">
						View List Account
					</a>

				</div>

			</div>


			<!-- Expense -->
			<div class="nav-item dropdown">

				<a href="#"
					class="nav-link dropdown-toggle 
					${activePage=='expense'||activePage=='expenseList'?'active':''}"
					data-bs-toggle="dropdown">

					<!-- <i class="fa fa-credit-card me-2 text-danger"></i> -->
					<i class="fa fa-file-invoice-dollar me-2"></i>Expense
				</a>

				<div class="dropdown-menu bg-transparent border-0">

					<a href="/user/expense"
						class="dropdown-item ${activePage=='expense'?'active':''}">
						Add New Expense
					</a>

					<a href="/user/expenseList"
						class="dropdown-item ${activePage=='expenseList'?'active':''}">
						View List Expense
					</a>

				</div>

			</div>


			<!-- Income -->
			<div class="nav-item dropdown">

				<a href="#"
					class="nav-link dropdown-toggle 
					${activePage=='income'||activePage=='incomeList'?'active':''}"
					data-bs-toggle="dropdown">

					<!-- <i class="fa fa-coins me-2 text-success"></i> -->
					<i class="fa fa-hand-holding-usd me-2"></i>Income
				</a>

				<div class="dropdown-menu bg-transparent border-0">

					<a href="/user/income"
						class="dropdown-item ${activePage=='income'?'active':''}">
						Add New Income
					</a>

					<a href="i/user/ncomeList"
						class="dropdown-item ${activePage=='incomeList'?'active':''}">
						View List Income
					</a>

				</div>

			</div>

		</div>

	</nav>
</div>
<!-- Sidebar End -->