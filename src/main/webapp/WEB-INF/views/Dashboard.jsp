<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard | CashPilot</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
<meta name="viewport" content="width=device-width, initial-scale=1">

<style>
html,body{
    height:100%;
    margin:0;
}
body{
    font-family:'Poppins',sans-serif;
    background:linear-gradient(135deg,#667eea,#764ba2);
    color:#fff;
}

/* GLASS EFFECT */
.glass{
    background:rgba(255,255,255,0.15);
    backdrop-filter:blur(15px);
    border-radius:18px;
    box-shadow:0 8px 32px rgba(0,0,0,0.2);
}

/* HEADER */
.header{
    padding:15px 25px;
}
.header h5{
    margin:0;
    font-weight:600;
}

/* LAYOUT */
.wrapper{
    min-height:100vh;
    padding:15px;
}
.sidebar{
    height:100%;
    padding:20px 0;
}
.sidebar a{
    display:block;
    padding:12px 25px;
    color:#fff;
    text-decoration:none;
    font-size:14px;
}
.sidebar a:hover,
.sidebar a.active{
    background:rgba(255,255,255,0.25);
}

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


/* FOOTER */
.footer{
    text-align:center;
    font-size:13px;
    opacity:0.85;
    padding:10px;
}
</style>
</head>

<body>

<div class="wrapper container-fluid">

    <!-- HEADER -->
    <div class="glass header mb-3 d-flex justify-content-between align-items-center">
        <h5>MoneyTrail</h5>
        <div>
            Admin |
            <a href="logout" class="text-white text-decoration-none">Logout</a>
        </div>
    </div>

    <div class="row">

        <!-- SIDEBAR -->
        <div class="col-md-2 mb-3">
            <div class="glass sidebar">
                <a class="active" href="#">Dashboard</a>
                <a href="#">Users</a>
                <a href="#">Accounts</a>
                <a href="#">Categories</a>
                <a href="#">Sub Categories</a>
                <a href="#">Vendors</a>
                <a href="#">Expenses</a>
                <a href="#">Income</a>
                <a href="#">Reports</a>
                <a href="#">Settings</a>
            </div>
        </div>

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

    <!-- FOOTER -->
    <div class="glass footer mt-3">
        © 2026 CashPilot | Admin Panel
    </div>

</div>

</body>
</html>
