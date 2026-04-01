<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<title>Expense List</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">

<link href="img/favicon.ico" rel="icon">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Roboto:wght@500;700&display=swap"
	rel="stylesheet">

<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet">

<link href="lib/owlcarousel/assets/owl.carousel.min.css"
	rel="stylesheet">
<link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css"
	rel="stylesheet" />

<link href="css/userbootstrap.min.css" rel="stylesheet">
<link href="css/userstyle.css" rel="stylesheet">

</head>

<body>
	<div class="container-fluid position-relative d-flex p-0">

		<jsp:include page="UserSidebar.jsp"></jsp:include>

		<div class="content">

			<jsp:include page="UserHeader.jsp"></jsp:include>

			<div class="col-12 pt-4 px-4">
				<div class="bg-secondary rounded h-100 p-4">

					<div class="d-flex justify-content-between align-items-center mb-4">
						<h6 class="mb-0">All Expenses</h6>
						<a href="userExpense" class="btn btn-sm btn-info">New</a>
					</div>

					<div class="table-responsive">
						<table class="table table-bordered table-striped text-white">
							<thead>
								<tr>
									<th>#</th>
									<th>Title</th>
									<!-- <th>Category</th>
									<th>Sub Category</th>
									<th>Vender</th>
									<th>Account</th>--> 
									<th>Status</th>
									<th>Amount</th>
									<th>Date</th>
									<th>Action</th>
								</tr>
							</thead>
							<tbody>

								<c:if test="${empty expenseList}">
									<tr>
										<td colspan="10" class="text-center text-muted">
											No expenses found
										</td>
									</tr>
								</c:if>

								<c:forEach var="exp" items="${expenseList}" varStatus="i">
									<tr>
										<th scope="row">${i.index + 1}</th>
										<td>${exp.title}</td>
<%-- 										<td>
										    <c:forEach var="cat" items="${categoryList}">
										        <c:if test="${cat.categoryId == exp.categoryId}">
										            ${cat.categoryName}
										        </c:if>
										    </c:forEach>
										</td>
										<td>
										    <c:forEach var="sub" items="${subCategoryList}">
										        <c:if test="${sub.subCategoryId == exp.subCategoryId}">
										            ${sub.subCategoryName}
										        </c:if>
										    </c:forEach>
										</td>
										<td>
										    <c:forEach var="ven" items="${venderList}">
										        <c:if test="${ven.venderId == exp.venderId}">
										            ${ven.venderName}
										        </c:if>
										    </c:forEach>
										</td>
										<td>
										    <c:forEach var="acc" items="${accountList}">
										        <c:if test="${acc.inaccountId == exp.inaccountId}">
										            ${acc.title}
										        </c:if>
										    </c:forEach>
										</td> --%>
										<td>
										    <c:forEach var="st" items="${statusList}">
										        <c:if test="${st.statusId == exp.statusId}">
										            ${st.status}
										        </c:if>
										    </c:forEach>
										</td>
										<td>₹ ${exp.amount}</td>
										<td>${exp.date}</td>

										<td>
											<a href="userEditExpense?expenseId=${exp.expenseId}" class="btn btn-warning">Edit</a>

											<a href="userDeleteExpense?expenseId=${exp.expenseId}"
												class="btn btn-sm btn-danger"
												onclick="return confirm('Are you sure you want to delete this expense?')">
												Delete
											</a>
										</td>
										<td>										
										    <a class="btn btn-secondary" href="viewUserExpense?expenseId=${exp.expenseId}">View</a>
										</td>
									</tr>
								</c:forEach>

							</tbody>
						</table>
					</div>

				</div>
			</div>

			<jsp:include page="UserFooter.jsp"></jsp:include>

		</div>
	</div>

	<a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top">
		<i class="bi bi-arrow-up"></i>
	</a>

</body>
</html>
