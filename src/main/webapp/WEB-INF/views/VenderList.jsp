<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Common List Page</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Google Font -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <meta name="viewport" content="width=device-width, initial-scale=1">
    <jsp:include page="CSS.jsp"></jsp:include>

    <style>

        h3 {
            text-align: center;
            margin-bottom: 20px;
            font-weight: 600;
        }

        .btn-add {
            background: linear-gradient(135deg, #28a745, #4cd964);
            border: none;
            color: #fff;
            border-radius: 20px;
            padding: 8px 20px;
            float: right;
            margin-bottom: 15px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        table th, table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        table th {
            background: #4a6cf7;
            color: #fff;
        }

        table tr:nth-child(even) {
            background: #f2f2f2;
        }

        table tr:hover {
            background: #e0e0e0;
        }

        .btn-custom {
            background: linear-gradient(135deg, #ff758c, #ff7eb3);
            border: none;
            color: #fff;
            padding: 5px 12px;
            border-radius: 12px;
            font-size: 14px;
            margin-right: 5px;
        }

        @media (max-width: 768px) {
            .sidebar {
                min-height: auto;
                margin-bottom: 20px;
            }
            .btn-add {
                float: none;
                width: 100%;
            }
        }
    </style>
</head>
<body>

<!-- HEADER -->
<div class="header">
    <jsp:include page="Header.jsp"></jsp:include>
</div>

<div class="container-fluid">
    <div class="row">

        <!-- SIDEBAR -->
            <jsp:include page="Sidebar.jsp"></jsp:include>
        

        <!-- MAIN CONTENT -->
        <div class="col-md-10 main-content">

            <h3>List Page</h3>

            <!-- Add Button -->
            <a href="vender" class="btn btn-add">+ Add</a>

            <!-- Table -->
            <div class="table-responsive mt-3">
                <table>
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Name</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<?> itemList = (List<?>) request.getAttribute("itemList");
                            if (itemList != null && !itemList.isEmpty()) {
                                int count = 1;
                                for (Object obj : itemList) {
                        %>
                        <tr>
                            <td><%= count++ %></td>
                            <td><%= obj.toString() %> <%-- Replace with actual field --%></td>
                            <td>
                                <a href="editItem?id=<%= obj.hashCode() %>" class="btn btn-custom btn-sm">Edit</a>
                                <a href="deleteItem?id=<%= obj.hashCode() %>" class="btn btn-custom btn-sm">Delete</a>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="3" class="text-center">No records found.</td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>

        </div>

    </div>
</div>

<!-- FOOTER -->
<div class="footer">
    <jsp:include page="Footer.jsp"></jsp:include>
</div>

</body>
</html>
