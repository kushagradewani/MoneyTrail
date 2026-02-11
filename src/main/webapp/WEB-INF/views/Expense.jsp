<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Expense</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <jsp:include page="CSS.jsp"></jsp:include>

</head>

<body>

<div class="container-fluid wrapper">

    <!-- HEADER -->
    <jsp:include page="Header.jsp"/>

    <!-- BODY -->
    <div class="row">

        <!-- SIDEBAR -->
        <jsp:include page="Sidebar.jsp"/>

        <!-- RIGHT CONTENT -->
        <div class="col-md-10">
            <div class="glass p-4">

                <!-- PAGE CONTENT GOES HERE -->
                <h3 class="text-center mb-4">Add Expense 💰</h3>
				
				<div class="row justify-content-center">
				    <div class="col-md-7">
				        <form action="saveExpense" method="post" class="glass-form p-4">
				
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
				                    <option value="1">Food</option>
				                    <option value="2">Travel</option>
				                </select>
				            </div>
				
				            <!-- Sub Category -->
				            <div class="mb-3">
				                <label class="form-label">Sub Category</label>
				                <select class="form-select" name="subCategoryId">
				                    <option value="">Select Sub Category</option>
				                    <option value="1">Hotel</option>
				                    <option value="2">Fuel</option>
				                </select>
				            </div>
				
				            <!-- Vendor -->
				            <div class="mb-3">
				                <label class="form-label">Vendor</label>
				                <select class="form-select" name="vendorId">
				                    <option value="">Select Vendor</option>
				                    <option value="1">Dmart</option>
				                    <option value="2">Starbucks</option>
				                </select>
				            </div>
				
				            <!-- Account -->
				            <div class="mb-3">
				                <label class="form-label">Account</label>
				                <select class="form-select" name="accountId" required>
				                    <option value="">Select Account</option>
				                    <option value="1">Cash</option>
				                    <option value="2">Bank</option>
				                </select>
				            </div>
				
				            <!-- Status -->
				            <div class="mb-3">
				                <label class="form-label">Status</label>
				                <select class="form-select" name="statusId">
				                    <option value="">Select Status</option>
				                    <option value="1">Paid</option>
				                    <option value="2">Pending</option>
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
				
				            <!-- Button -->
				            <button type="submit" class="btn btn-custom w-100 mt-3">
				                Save Expense
				            </button>
				
				        </form>
				    </div>
				</div>

				                

            </div>
        </div>

    </div>

    <!-- FOOTER -->
    <jsp:include page="Footer.jsp"/>

</div>

</body>
</html>
