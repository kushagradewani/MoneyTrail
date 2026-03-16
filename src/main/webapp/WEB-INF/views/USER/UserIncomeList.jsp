<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<title>Income List</title>
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
						<h6 class="mb-0">All Income</h6>
						<a href="/user/income" class="btn btn-sm btn-info">New</a>
					</div>

					<div class="table-responsive">
						<table class="table table-bordered table-striped text-white">
					    <thead>
					        <tr>
					            <th>#</th>
					            <th>Title</th>
					            <!-- <th>User</th>
					            <th>Account</th>
					            <th>Description</th> -->
					            <th>Status</th>
					            <th>Amount</th>
					            <th>Date</th>
					            <th>Action</th>
					        </tr>
					    </thead>
					    <tbody>
					
					        <c:if test="${empty incomeList}">
					            <tr>
					                <td colspan="9" class="text-center text-muted">
					                    No income records found
					                </td>
					            </tr>
					        </c:if>
					
					        <c:forEach var="inc" items="${incomeList}" varStatus="i">
					            <tr>
					                <th scope="row">${i.index + 1}</th>
					
					                <td>${inc.title}</td>
					
					                <%-- <!-- User -->
					                <td>
					                    <c:forEach var="u" items="${userList}">
					                        <c:if test="${u.userId == inc.userId}">
					                            ${u.fullName}
					                        </c:if>
					                    </c:forEach>
					                </td>
					
					                <!-- Account -->
					                <td>
					                    <c:forEach var="acc" items="${accountList}">
					                        <c:if test="${acc.inaccountId == inc.inaccountId}">
					                            ${acc.title}
					                        </c:if>
					                    </c:forEach>
					                </td>
					
					                <!-- Description -->
					                <td>${inc.description}</td> --%>
					
					                <!-- Status -->
					                <td>
					                    <c:forEach var="st" items="${statusList}">
					                        <c:if test="${st.statusId == inc.statusId}">
					                            ${st.status}
					                        </c:if>
					                    </c:forEach>
					                </td>
					
					                <!-- Amount -->
					                <td>₹ ${inc.amount}</td>
					
					                <!-- Date -->
					                <td>${inc.date}</td>
					
					                <!-- Action -->
					                <td>
					                    <a href="/user/editIncome?incomeId=${inc.incomeId}" class="btn btn-sm btn-warning">Edit</a>
					
					                    <a href="/user/deleteIncome?incomeId=${inc.incomeId}" 
					                       class="btn btn-sm btn-danger"
					                       onclick="return confirm('Are you sure you want to delete this income?')">
					                       Delete
					                    </a>
					                </td>
					                <td>										
										<a class="btn btn-secondary" href="/user/viewIncome?incomeId=${inc.incomeId}">View</a>
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
