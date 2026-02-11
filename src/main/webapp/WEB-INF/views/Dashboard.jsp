<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Dashboard</title>

	<jsp:include page="CSS.jsp"></jsp:include>
	<style>
		/* CONTENT */
		.content{
		    padding:20px;
		}
		
		/* STATS */
		.stat-card{
		    padding:20px;
		    border-radius:16px;
		}
		.stat-title{
		    font-size:13px;
		    opacity:0.85;
		}
		.stat-value{
		    font-size:26px;
		    font-weight:600;
		}
		
		/* ---------- Glass Table for Recent Users ---------- */
		.recent-users {
		    background: rgba(255,255,255,0.12);
		    backdrop-filter: blur(14px);
		    border-radius: 16px;
		    padding: 20px;
		}
		
		.recent-users table {
		    width: 100%;
		    border-collapse: separate;
		    border-spacing: 0 10px; /* adds space between rows */
		    color: #fff;
		}
		
		.recent-users thead th {
		    background: rgba(255,255,255,0.25);
		    padding: 12px 15px;
		    font-size: 13px;
		    font-weight: 500;
		    border: none;
		    text-transform: uppercase;
		}
		
		.recent-users tbody tr {
		    background: rgba(255,255,255,0.18);
		    transition: 0.3s ease;
		    border-radius: 12px;
		}
		
		.recent-users tbody tr:hover {
		    background: rgba(255,255,255,0.28);
		    transform: scale(1.01);
		}
		
		.recent-users td {
		    padding: 12px 15px;
		    border: none;
		    font-size: 14px;
		}
		
		.status {
		    padding: 4px 12px;
		    border-radius: 20px;
		    font-size: 12px;
		    font-weight: 500;
		    display: inline-block;
		}
		
		.status.active {
		    background: rgba(72,239,128,0.25);
		    color: #9cffc4;
		}
		
		.status.inactive {
		    background: rgba(255,99,99,0.25);
		    color: #ffb3b3;
		}
	</style>

</head>

<body>

<div class="wrapper container-fluid">

    <!-- header -->
	<jsp:include page="Header.jsp"></jsp:include>

    <div class="row">

    <!-- Sidebar -->
	<jsp:include page="Sidebar.jsp"></jsp:include>  

        <!-- MAIN CONTENT -->
        <div class="col-md-10">

            <!-- STATS -->
            <div class="row g-3 mb-4">
                <div class="col-md-3">
                    <div class="glass stat-card">
                        <div class="stat-title">Total Users</div>
                        <div class="stat-value">128</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="glass stat-card">
                        <div class="stat-title">Total Income</div>
                        <div class="stat-value">₹3,45,000</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="glass stat-card">
                        <div class="stat-title">Total Expense</div>
                        <div class="stat-value">₹2,78,400</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="glass stat-card">
                        <div class="stat-title">Categories</div>
                        <div class="stat-value">18</div>
                    </div>
                </div>
            </div>

            <!-- RECENT USERS -->
            <div class="recent-users mb-4">
		    <h6 class="mb-3">Recent Users</h6>
		    <table>
		        <thead>
		            <tr>
		                <th>Name</th>
		                <th>Email</th>
		                <th>Role</th>
		                <th>Status</th>
		            </tr>
		        </thead>
		        <tbody>
		            <tr>
		                <td>Rahul Patel</td>
		                <td>rahul@gmail.com</td>
		                <td>User</td>
		                <td><span class="status active">Active</span></td>
		            </tr>
		            <tr>
		                <td>Anjali Shah</td>
		                <td>anjali@gmail.com</td>
		                <td>User</td>
		                <td><span class="status active">Active</span></td>
		            </tr>
		            <tr>
		                <td>Admin</td>
		                <td>admin@cashpilot.com</td>
		                <td>Admin</td>
		                <td><span class="status active">Active</span></td>
		            </tr>
		        </tbody>
		    </table>
		</div>


        </div>
    </div>

    <!-- Footer -->
	<jsp:include page="Footer.jsp"></jsp:include>

</div>

</body>
</html>
