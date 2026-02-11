<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Account</title>

    <!-- Bootstrap -->
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
                <h3 class="text-center mb-4">Add Account 💳</h3>

				<div class="row justify-content-center">
				    <div class="col-md-5">
				        <form action="saveAccount" method="post">
				
				            <!-- Hidden Account ID -->
				            <input type="hidden" name="accountId" value="">
				
				            <!-- Hidden User ID -->
				            <input type="hidden" name="userId" value="${sessionScope.userId}">
				
				            <!-- Account Title -->
				            <div class="mb-3">
				                <label>Account Title</label>
				                <select class="form-select" name="title" required>
				                    <option value="">Select Account</option>
				                    <option value="Cash">Cash</option>
				                    <option value="Debit Card">Debit Card</option>
				                    <option value="Credit Card">Credit Card</option>
				                </select>
				            </div>
				
				            <!-- Is Default Account -->
				            <div class="mb-3">
				                <label>Default Account</label>
				                <select class="form-select" name="exDefault" required>
				                    <option value="">Select Option</option>
				                    <option value="Yes">Yes</option>
				                    <option value="No">No</option>
				                </select>
				            </div>
				
				            <!-- Amount -->
				            <div class="mb-3">
				                <label>Amount</label>
				                <input type="number" class="form-control" name="amount" placeholder="Enter amount" step="0.01" required>
				            </div>
				
				            <!-- Save Button -->
				            <button class="btn btn-custom w-100">Save Account</button>
				
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
