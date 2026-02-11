<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Income</title>

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
                <h3 class="text-center mb-4">Add Income 💵</h3>

				<div class="row justify-content-center">
				    <div class="col-md-6">
				        <form action="saveIncome" method="post">
				
				            <!-- Hidden Income ID (for auto-generated PK) -->
				            <input type="hidden" name="incomeId" value="">
				
				            <!-- Title -->
				            <div class="mb-3">
				                <label>Title</label>
				                <input type="text" class="form-control" name="title" placeholder="Income Title" required>
				            </div>
				
				            <!-- Date -->
				            <div class="mb-3">
				                <label>Date</label>
				                <input type="date" class="form-control" name="date" required>
				            </div>
				
				            <!-- User (Hidden / Session) -->
				            <input type="hidden" name="userId" value="${sessionScope.userId}">
				
				            <!-- Account -->
				            <div class="mb-3">
				                <label>Account</label>
				                <select class="form-select" name="accountId" required>
				                    <option value="">Select Account</option>
				                    <option value="1">Cash</option>
				                    <option value="2">Bank</option>
				                    <option value="3">Credit Card</option>
				                </select>
				            </div>
				
				            <!-- Description -->
				            <div class="mb-3">
				                <label>Description</label>
				                <textarea class="form-control" name="description" rows="3" placeholder="Enter description"></textarea>
				            </div>
				
				            <!-- Status -->
				            <div class="mb-3">
				                <label>Status</label>
				                <select class="form-select" name="statusId" required>
				                    <option value="">Select Status</option>
				                    <option value="1">Paid</option>
				                    <option value="2">UnPaid</option>
				                    <option value="3">Partial Paid</option>
				                </select>
				            </div>
				
				            <!-- Amount -->
				            <div class="mb-3">
				                <label>Amount</label>
				                <input type="number" class="form-control" name="amount" step="0.01" placeholder="Enter amount" required>
				            </div>
				
				            <!-- Save Button -->
				            <button class="btn btn-custom w-100">Save Income</button>
				
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
