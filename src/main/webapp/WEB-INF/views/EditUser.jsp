<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Edit User</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>

<body>
<div class="container-fluid position-relative d-flex p-0">

    <jsp:include page="Sidebar.jsp"></jsp:include>
    <div class="content">

        <jsp:include page="Header.jsp"></jsp:include>

        <div class="container-fluid pt-4 px-4">
            <div class="bg-secondary rounded p-4">

                <h3 class="text-white mb-4">Edit User</h3>

                <form action="addUser" method="post">

                    <!-- Hidden User ID (important for update) -->
                    <input type="hidden" name="userId" value="${user.userId}">

                    <div class="mb-3">
                        <label class="form-label text-white">First Name</label>
                        <input type="text" class="form-control"
                               name="firstName"
                               value="${user.firstName}"
                               required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label text-white">Last Name</label>
                        <input type="text" class="form-control"
                               name="lastName"
                               value="${user.lastName}"
                               required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label text-white">Email</label>
                        <input type="email" class="form-control"
                               name="email"
                               value="${user.email}"
                               required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label text-white">Gender</label>
                        <select class="form-control" name="gender">
                            <option value="Male" ${user.gender == 'Male' ? 'selected' : ''}>Male</option>
                            <option value="Female" ${user.gender == 'Female' ? 'selected' : ''}>Female</option>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label text-white">Birth Year</label>
                        <input type="number" class="form-control"
                               name="birthYear"
                               value="${user.birthYear}">
                    </div>

                    <div class="mb-3">
                        <label class="form-label text-white">Contact Number</label>
                        <input type="text" class="form-control"
                               name="contactNum"
                               value="${user.contactNum}">
                    </div>

                    <div class="mb-3">
                        <label class="form-label text-white">Status</label>
                        <select class="form-control" name="active">
                            <option value="true" ${user.active ? 'selected' : ''}>Active</option>
                            <option value="false" ${!user.active ? 'selected' : ''}>Inactive</option>
                        </select>
                    </div>

                    <div class="d-flex justify-content-end">
                        <a href="userList" class="btn btn-dark me-2">Cancel</a>
                        <button type="submit" class="btn btn-success">Update</button>
                    </div>

                </form>

            </div>
        </div>

        <jsp:include page="Footer.jsp"></jsp:include>

    </div>
</div>
</body>

</html>