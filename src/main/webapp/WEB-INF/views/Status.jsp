<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Status</title>

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
                <h3 class="text-center mb-4">Add Status 📌</h3>

				<div class="row justify-content-center">
				    <div class="col-md-4">
				        <form action="saveStatus" method="post">
				
				            <!-- Hidden Status ID -->
				            <input type="hidden" name="statusId" value="">
				
				            <!-- Status Name -->
				            <div class="mb-3">
				                <label>Status</label>
				                <select class="form-select" name="status" required>
				                    <option value="">Select Status</option>
				                    <option value="Paid">Paid</option>
				                    <option value="UnPaid">UnPaid</option>
				                    <option value="Partial Paid">Partial Paid</option>
				                </select>
				            </div>
				
				            <!-- Save Button -->
				            <button class="btn btn-custom w-100">Save Status</button>
				
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
