<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Edit Account</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <link href="img/favicon.ico" rel="icon">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Roboto:wght@500;700&display=swap" rel="stylesheet"> 
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />
    <link href="css/userbootstrap.min.css" rel="stylesheet">
    <link href="css/userstyle.css" rel="stylesheet">
</head>
<body>
<div class="container-fluid position-relative d-flex p-0">

    <jsp:include page="UserSidebar.jsp"></jsp:include>

    <div class="content">
        <jsp:include page="UserHeader.jsp"></jsp:include>

        <div class="container-fluid pt-4 px-4">
            <div class="bg-secondary rounded p-4">
                <h3 class="text-white mb-4">Edit Account</h3>

                <form action="userUpdateAccount" method="post">
                    <input type="hidden" name="inaccountId" value="${account.inaccountId}" />

                    <div class="mb-3">
                        <label class="form-label text-white">Title</label>
                        <input type="text" name="title" class="form-control" value="${account.title}" required />
                    </div>

                    <div class="mb-3">
                        <label class="form-label text-white">Amount</label>
                        <input type="number" name="amount" class="form-control" value="${account.amount}" step="0.01" required />
                    </div>

                    <div class="mb-3 form-check">
                        <input type="checkbox" name="exDefault" class="form-check-input" 
                               <c:if test="${account.exDefault}">checked</c:if> />
                        <label class="form-check-label text-white">Default</label>
                    </div>

                    <div class="mb-3 form-check">
                        <input type="checkbox" name="active" class="form-check-input" 
                               <c:if test="${account.active}">checked</c:if> />
                        <label class="form-check-label text-white">Active</label>
                    </div>

                    <div class="d-flex justify-content-end">
                        <a href="/userAccountList" class="btn btn-dark me-2">Back</a>
                        <button type="submit" class="btn btn-success">Update Account</button>
                    </div>
                </form>
            </div>
        </div>

        <jsp:include page="UserFooter.jsp"></jsp:include>
    </div>

    <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
</div>
</body>
</html>