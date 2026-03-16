<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

		<!DOCTYPE html>
		<html lang="en">

		<head>
			<meta charset="utf-8">
			<title>User Profile</title>

			<meta content="width=device-width, initial-scale=1.0" name="viewport">

			<link href="css/userbootstrap.min.css" rel="stylesheet">
			<link href="css/userstyle.css" rel="stylesheet">

		</head>

		<body>

			<div class="container-fluid position-relative d-flex p-0">

				<!-- Sidebar -->
				<jsp:include page="UserSidebar.jsp"></jsp:include>

				<div class="content">

					<!-- Header -->
					<jsp:include page="UserHeader.jsp"></jsp:include>

					<div class="container-fluid pt-4 px-4">

						<div class="row g-4">

							<div class="col-sm-12 col-xl-6">

								<div class="bg-secondary rounded h-100 p-4">

									<div class="d-flex justify-content-between align-items-center mb-4">
										<h6 class="mb-0">User Profile</h6>
									</div>

									<form action="updateProfile" method="post">

										<!-- User ID -->
										<input type="hidden" name="userId" value="${sessionScope.user.userId}">

										<!-- First Name -->
										<div class="mb-3">
											<label class="form-label">First Name</label>
											<input type="text" class="form-control" name="firstName"
												value="${sessionScope.user.firstName}" required>
										</div>

										<!-- Last Name -->
										<div class="mb-3">
											<label class="form-label">Last Name</label>
											<input type="text" class="form-control" name="lastName"
												value="${sessionScope.user.lastName}" required>
										</div>

										<!-- Email -->
										<div class="mb-3">
											<label class="form-label">Email</label>
											<input type="email" class="form-control" name="email" value="${sessionScope.user.email}"
												required>
										</div>

										<!-- Password -->
										<div class="mb-3">
											<label class="form-label">Password</label>
											<input type="password" class="form-control" name="password"
												value="${sessionScope.user.password}" required>
										</div>

										<!-- Gender -->
										<div class="mb-3">
											<label class="form-label">Gender</label>
											<select class="form-control" name="gender">

												<option value="Male" ${sessionScope.user.gender=='Male' ?'selected':''}>Male</option>

												<option value="Female" ${sessionScope.user.gender=='Female' ?'selected':''}>Female
												</option>

												<option value="Other" ${sessionScope.user.gender=='Other' ?'selected':''}>Other
												</option>

											</select>
										</div>

										<!-- Birth Year -->
										<div class="mb-3">
											<label class="form-label">Birth Year</label>
											<input type="number" class="form-control" name="birthYear"
												value="${sessionScope.user.birthYear}">
										</div>

										<!-- Contact Number -->
										<div class="mb-3">
											<label class="form-label">Contact Number</label>
											<input type="text" class="form-control" name="contactNum"
												value="${sessionScope.user.contactNum}">
										</div>

										<!-- Profile Picture URL -->
										<div class="mb-3">
											<label class="form-label">Profile Picture URL</label>
											<input type="text" class="form-control" name="profilePicURL"
												value="${sessionScope.user.profilePicURL}">
										</div>

										<!-- Created At (Read Only) -->
										<div class="mb-3">
											<label class="form-label">Account Created</label>
											<input type="text" class="form-control" value="${sessionScope.user.createdAt}" readonly>
										</div>

										<!-- Role (Read Only) -->
										<div class="mb-3">
											<label class="form-label">Role</label>
											<input type="text" class="form-control" value="${sessionScope.user.role}" readonly>
										</div>

										<button type="submit" class="btn btn-primary">
											Update Profile
										</button>

									</form>

								</div>
							</div>

						</div>

					</div>

				</div>

				<!-- Footer -->
				<jsp:include page="UserFooter.jsp"></jsp:include>

			</div>

			</div>

		</body>

		</html>