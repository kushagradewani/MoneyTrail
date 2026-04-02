<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

 
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>Admin Dashboard</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Roboto:wght@500;700&display=swap" rel="stylesheet"> 
    
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="css/style.css" rel="stylesheet">
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


        <!-- SideBar Start -->
        <jsp:include page="Sidebar.jsp"></jsp:include>
        <!-- SideBar End -->


        <!-- Content Start -->
        <div class="content">
            <!-- Navbar Start -->
            <jsp:include page="Header.jsp"></jsp:include>  
            <!-- Navbar End -->
            
            <!-- Welcome Message Start -->
			<div class="container-fluid pt-4 px-4">
			    <div class="bg-secondary rounded p-4">
			        <div class="d-flex align-items-center justify-content-between">
			            <div>
			                <h4 class="mb-0">Welcome Back, ${sessionScope.user.firstName}</h4>
			                <small class="text-muted">Here's what's happening with your dashboard today.</small>
			            </div>
			        </div>
			    </div>
			</div>
			<!-- Welcome Message End -->

            <!-- Sale & Revenue Start -->
            <div class="container-fluid pt-4 px-4">
		                <div class="row g-4">
		                    <div class="col-sm-6 col-xl-3">
		                        <div class="bg-secondary rounded d-flex align-items-center justify-content-between p-4">
		                            <i class="fa fa-chart-line fa-3x text-primary"></i>
		                            <div class="ms-3">
		                                <p class="mb-2">This Month Income</p>
										<h5 class="mb-0">${thisMonthIncome}</h5>
		                            </div>
		                        </div>
		                    </div>
		                    <div class="col-sm-6 col-xl-3">
		                        <div class="bg-secondary rounded d-flex align-items-center justify-content-between p-4">
		                            <i class="fa fa-chart-bar fa-3x text-primary"></i>
		                            <div class="ms-3">
										<p class="mb-2">Quarter Income</p>
										<h5 class="mb-0">${qtrIncome}</h5>
		                            </div>
		                        </div>
		                    </div>
		                    <div class="col-sm-6 col-xl-3">
		                        <div class="bg-secondary rounded d-flex align-items-center justify-content-between p-4">
		                            <i class="fa fa-chart-area fa-3x text-primary"></i>
		                            <div class="ms-3">
										<p class="mb-2">This Month Expense</p>
										<h5 class="mb-0">${thisMonthExpense}</h5>
		                            </div>
		                        </div>
		                    </div>
		                    <div class="col-sm-6 col-xl-3">
		                        <div class="bg-secondary rounded d-flex align-items-center justify-content-between p-4">
		                            <i class="fa fa-chart-pie fa-3x text-primary"></i>
		                            <div class="ms-3">
										<p class="mb-2">Quarter Expense</p>
										<h5 class="mb-0">${qtrExpense}</h5>
		                            </div>
		                        </div>
		                    </div>
		                </div>
		            </div>
            <!-- Sale & Revenue End -->


            <!-- Sales Chart Start -->
                    <div class="container-fluid pt-4 px-4">
                        <div class="row g-4">
                            <div class="col-sm-12 col-xl-6">
                                <div class="bg-secondary text-center rounded p-4">
                                    <div class="d-flex align-items-center justify-content-between mb-4">
                                        <h6 class="mb-0">Total Expense & Income</h6>
                                        <a href="">Show All</a>
                                    </div>
                                    <%-- <canvas id="expenseChart" width="400" height="200"></canvas> --%>
                                    <%-- <canvas id="worldwide-sales"></canvas> --%>
                                    <canvas id="barChart"></canvas>
                                </div>
                            </div>
                            <div class="col-sm-12 col-xl-6">
                                <div class="bg-secondary text-center rounded p-4">
                                    <div class="d-flex align-items-center justify-content-between mb-4">
                                        <h6 class="mb-0">Total Expense By Category</h6>
                                        <a href="">Show All</a>
                                    </div>
                                    <%-- <canvas id="salse-revenue"></canvas> --%>
                                    <canvas id="lineChart"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- Sales Chart End -->


            <!-- Footer Start -->
            <jsp:include page="Footer.jsp"></jsp:include>
            <!-- Footer End -->
        </div>
        <!-- Content End -->


        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
    </div>
    
    <script>
       /* document.addEventListener('DOMContentLoaded', function() {
    	    // Read CSS variables
    	    const rootStyles = getComputedStyle(document.documentElement);
    	    const primary = rootStyles.getPropertyValue('--primary').trim();
    	    const secondary = rootStyles.getPropertyValue('--secondary').trim();
    	    const light = rootStyles.getPropertyValue('--light').trim();
    	    const dark = rootStyles.getPropertyValue('--dark').trim();

    	    const parsedData = JSON.parse('${chartDataJson}');
    	    const ctx = document.getElementById('expenseChart').getContext('2d');

    	    new Chart(ctx, {
    	        type: 'bar',
    	        data: {
    	            labels: Object.keys(parsedData),
    	            datasets: [{
    	                label: 'Expenses by Category',
    	                data: Object.values(parsedData),
    	                backgroundColor: [primary, secondary, light, dark] // mapped from your CSS palette
    	            }]
    	        },
    	        options: {
    	            responsive: true,
    	            plugins: {
    	                legend: {
    	                    display: true
    	                }
    	            }
    	        }
    	    });
    	}); */
    	
    	document.addEventListener('DOMContentLoaded', function () {

    	    const rootStyles = getComputedStyle(document.documentElement);
    	    const primary = rootStyles.getPropertyValue('--primary').trim();
    	    const light = rootStyles.getPropertyValue('--light').trim();

    	    // ===== Parse Data =====
    	    const expenseData = JSON.parse('${expenseJson}');
    	    const incomeData = JSON.parse('${incomeJson}');
    	    const categoryData = JSON.parse('${categoryJson}');

    	    const months = [
    	        'Jan','Feb','Mar','Apr','May','Jun',
    	        'Jul','Aug','Sep','Oct','Nov','Dec'
    	    ];

    	    // ==========================
    	    // BAR CHART (Income vs Expense)
    	    // ==========================
    	    const barCtx = document.getElementById('barChart').getContext('2d');

    	    new Chart(barCtx, {
    	        type: 'bar',
    	        data: {
    	            labels: months,
    	            datasets: [
    	                {
    	                    label: 'Expense',
    	                    data: Object.values(expenseData),
    	                    backgroundColor: primary
    	                },
    	                {
    	                    label: 'Income',
    	                    data: Object.values(incomeData),
    	                    backgroundColor: light
    	                }
    	            ]
    	        },
    	        options: {
    	            responsive: true,
    	            plugins: {
    	                legend: {
    	                    labels: { color: "#fff" }
    	                }
    	            },
    	            scales: {
    	                x: {
    	                    ticks: { color: "#6C7293" }
    	                },
    	                y: {
    	                    ticks: { color: "#6C7293" }
    	                }
    	            }
    	        }
    	    });

    	    // ==========================
    	    // LINE CHART (Category Expense)
    	    // ==========================
    	    const lineCtx = document.getElementById('lineChart').getContext('2d');

    	    new Chart(lineCtx, {
    	        type: 'line',
    	        data: {
    	            labels: Object.keys(categoryData),
    	            datasets: [{
    	                label: 'Expense by Category',
    	                data: Object.values(categoryData),
    	                borderColor: primary,
    	                backgroundColor: primary + "33",
    	                fill: true,
    	                tension: 0.4
    	            }]
    	        },
    	        options: {
    	            responsive: true,
    	            plugins: {
    	                legend: {
    	                    labels: { color: "#fff" }
    	                }
    	            },
    	            scales: {
    	                x: {
    	                    ticks: { color: "#6C7293" }
    	                },
    	                y: {
    	                    ticks: { color: "#6C7293" }
    	                }
    	            }
    	        }
    	    });

    	});
</script>
</body>

</html>