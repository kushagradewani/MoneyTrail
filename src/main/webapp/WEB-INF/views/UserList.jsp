<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<title>Category List</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">

<!-- Favicon -->
<link href="img/favicon.ico" rel="icon">

<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Roboto:wght@500;700&display=swap"
	rel="stylesheet">

<!-- Icon Font Stylesheet -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet">

<!-- Libraries Stylesheet -->
<link href="lib/owlcarousel/assets/owl.carousel.min.css"
	rel="stylesheet">
<link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css"
	rel="stylesheet" />

<!-- Customized Bootstrap Stylesheet -->
<link href="css/bootstrap.min.css" rel="stylesheet">

<!-- Template Stylesheet -->
<link href="css/style.css" rel="stylesheet">
<style>
.UPCOMING {
	background: #17a2b8;
}

.ONGOING {
	background: #28a745;
}

.COMPLETED {
	background: #6c757d;
}

.FREE {
	background: #28a745;
}

.PAID {
	background: #dc3545;
}
</style>
</head>

<body>
	<div class="container-fluid position-relative d-flex p-0">
		<!-- Spinner Start -->
		<div id="spinner"
			class="show bg-dark position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
			<div class="spinner-border text-primary"
				style="width: 3rem; height: 3rem;" role="status">
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

			<div class="col-12 pt-4 px-4">
				<div class="bg-secondary rounded h-100 p-4">

					<div class="d-flex justify-content-between align-items-center mb-4">
						<h6 class="mb-0">All Category</h6>
						<a href="user" class="btn btn-sm btn-info">New</a>
					</div>

					<div class="table-responsive">
						<table id="first" class="table table-bordered table-striped text-white">
							<thead>
								<tr>
									<th scope="col">#</th>
									<th scope="col">First Name</th>
									<th scope="col">Last Name</th>
									<th scope="col">Email</th>
									<th scope="col">Status</th>
									<th scope="col">Action</th>
									<th scope="col">View</th>
								</tr>
							</thead>
							<tbody>

								<c:if test="${empty userList}">
									<tr>
										<td colspan="4" class="text-center text-muted">No
											User Not found</td>
									</tr>
								</c:if>

								<c:forEach var="ul" items="${userList}" varStatus="i">
									<tr>
										<th scope="row">${i.index + 1}</th>
										<td>${ul.firstName}</td>
										<td>${ul.lastName}</td>
										<td>${ul.email}</td>

										<td><c:choose>
												<c:when test="${ul.active}">
													<span class="badge bg-success">Active</span>
												</c:when>
												<c:otherwise>
													<span class="badge bg-danger">Inactive</span>
												</c:otherwise>
											</c:choose>
										</td>

										<td>
										    <a href="editUser?userId=${ul.userId}" class="btn btn-sm btn-warning">Edit</a>
										
										    <a href="deleteUser?userId=${ul.userId}"
										       class="btn btn-sm btn-danger"
										       onclick="return confirm('Are you sure you want to delete this user?')">
										       Delete
										    </a>
										</td>
										<td>										
										    <a class="btn btn-secondary" href="viewUser?userId=${ul.userId}">View</a>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<!-- Footer Start -->
			<jsp:include page="Footer.jsp"></jsp:include>
			<!-- Footer End -->
		</div>
	</div>
	<!-- Content End -->


	<!-- Back to Top -->
	<a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i
		class="bi bi-arrow-up"></i></a>
</body>

<script>
new DataTable('#first', {
    layout: {
        topStart: {
            buttons: ['copy', 'csv', 'excel', 'pdf', 'print']
        }
    }
});
	</script>

</html>