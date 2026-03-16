<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en"> 

<head>
    <meta charset="utf-8">
    <title>Edit Expense</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <!-- Favicon -->
    <link href="img/favicon.ico" rel="icon">

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Roboto:wght@500;700&display=swap" rel="stylesheet"> 

    <!-- Icon Fonts -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries -->
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

    <!-- Bootstrap -->
    <link href="css/userbootstrap.min.css" rel="stylesheet">

    <!-- Template Styles -->
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

    <!-- Sidebar -->
    <jsp:include page="UserSidebar.jsp"></jsp:include>

    <!-- Content Start -->
    <div class="content">

        <!-- Navbar -->
        <jsp:include page="UserHeader.jsp"></jsp:include>

        <!-- Edit Expense Form -->
        <div class="container-fluid pt-4 px-4">
            <div class="bg-secondary rounded p-4">
                <h3 class="text-white mb-4">Edit Expense</h3>

                <form action="/user/updateExpense" method="post">
                    <input type="hidden" name="expenseId" value="${expense.expenseId}" />

                    <div class="mb-3">
                        <label class="form-label text-white">Title</label>
                        <input type="text" name="title" class="form-control" value="${expense.title}" required />
                    </div>

                    <div class="mb-3">
                        <label class="form-label text-white">Category</label>
                        <select name="categoryId" class="form-select" required>
                            <c:forEach var="cat" items="${categoryList}">
                                <option value="${cat.categoryId}" 
                                    <c:if test="${cat.categoryId == expense.categoryId}">selected</c:if>>
                                    ${cat.categoryName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label text-white">SubCategory</label>
                        <select name="subCategoryId" class="form-select">
                            <c:forEach var="sub" items="${subCategoryList}">
                                <option value="${sub.subCategoryId}" 
                                    <c:if test="${sub.subCategoryId == expense.subCategoryId}">selected</c:if>>
                                    ${sub.subCategoryName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label text-white">Vender</label>
                        <select name="venderId" class="form-select">
                            <c:forEach var="ven" items="${venderList}">
                                <option value="${ven.venderId}" 
                                    <c:if test="${ven.venderId == expense.venderId}">selected</c:if>>
                                    ${ven.venderName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label text-white">Account</label>
                        <select name="inaccountId" class="form-select">
                            <c:forEach var="acc" items="${accountList}">
                                <option value="${acc.inaccountId}" 
                                    <c:if test="${acc.inaccountId == expense.inaccountId}">selected</c:if>>
                                    ${acc.title}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label text-white">Status</label>
                        <select name="statusId" class="form-select">
                            <c:forEach var="st" items="${statusList}">
                                <option value="${st.statusId}" 
                                    <c:if test="${st.statusId == expense.statusId}">selected</c:if>>
                                    ${st.status}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label text-white">Amount</label>
                        <input type="number" name="amount" class="form-control" value="${expense.amount}" step="0.01" required />
                    </div>

                    <div class="mb-3">
                        <label class="form-label text-white">Date</label>
                        <input type="date" name="date" class="form-control" value="${expense.date}" required />
                    </div>

                    <div class="mb-3">
                        <label class="form-label text-white">Description</label>
                        <textarea name="description" class="form-control" rows="3">${expense.description}</textarea>
                    </div>

                    <div class="mb-3 form-check">
                        <input type="checkbox" name="active" class="form-check-input" 
                               <c:if test="${expense.active}">checked</c:if> />
                        <label class="form-check-label text-white">Active</label>
                    </div>

                    <div class="d-flex justify-content-end">
                        <a href="/user/expenseList" class="btn btn-dark me-2">Back</a>
                        <button type="submit" class="btn btn-success">Update Expense</button>
                    </div>
                </form>
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