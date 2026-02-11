<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Vendor</title>

    <!-- Bootstrap & Common CSS -->
    <jsp:include page="CSS.jsp"></jsp:include>
</head>

<body>

<div class="container-fluid wrapper">

    <!-- HEADER -->
    <jsp:include page="Header.jsp"></jsp:include>

    <!-- MAIN CONTENT -->
    <div class="row">

        <!-- SIDEBAR (LEFT) -->
        <jsp:include page="Sidebar.jsp"></jsp:include>

        <!-- RIGHT CONTENT -->
        <div class="col-md-10">
            <div class="glass p-4">

                <h3 class="mb-4 text-center">Add Vendor 🏪</h3>

				<div class="row justify-content-center">
				    <div class="col-md-6">
				
				        <form action="saveVendor" method="post">
				
				            <!-- Hidden Vendor ID -->
				            <input type="hidden" name="vendorId" value="">
				
				            <!-- Vendor Name (text input for manual entry) -->
				            <div class="mb-3">
				                <label>Vendor Name</label>
				                <input type="text" name="vendorName" class="form-control" placeholder="Enter vendor name" required>
				            </div>
				
				            <!-- Button -->
				            <div class="d-grid mt-4">
				                <button type="submit" class="btn btn-custom">
				                    Save Vendor
				                </button>
				            </div>
				
				        </form>
				
				    </div>
				</div>


            </div>
        </div>
    </div>

    <!-- FOOTER -->
    <jsp:include page="Footer.jsp"></jsp:include>

</div>

</body>
</html>
	