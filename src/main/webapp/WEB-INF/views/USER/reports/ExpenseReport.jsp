<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Expense Report - MoneyTrail</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet">
    <link href="css/userbootstrap.min.css" rel="stylesheet">
    <link href="css/userstyle.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.datatables.net/2.3.7/css/dataTables.dataTables.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/3.2.6/css/buttons.dataTables.css">
</head>
<body>
<div class="container-fluid position-relative d-flex p-0">

    <jsp:include page="../UserSidebar.jsp"></jsp:include>

    <div class="content">
        <jsp:include page="../UserHeader.jsp"></jsp:include>

        <div class="container-fluid pt-4 px-4">

            <!-- Page Header -->
            <div class="d-flex align-items-center justify-content-between mb-4">
                <div>
                    <h4 class="mb-1"><i class="fa fa-file-invoice-dollar me-2 text-primary"></i>Expense Report</h4>
                    <small style="color:var(--text-secondary);">Dashboard &rsaquo; Reports &rsaquo; <span style="color:var(--primary)">Expense Report</span></small>
                </div>
                <div class="d-flex gap-2">
                    <button onclick="window.print()" class="btn btn-sm" style="background:var(--bg-card2);border:1px solid var(--border);color:var(--text-secondary);"><i class="fa fa-print me-1"></i>Print</button>
                    <button onclick="sendReportMail('Expense')" class="btn btn-primary btn-sm"><i class="fa fa-envelope me-1"></i>Email Report</button>
                </div>
            </div>

            <!-- Filter Card -->
            <div class="report-filter-card">
                <form method="get" action="/report/expense" class="d-flex align-items-end gap-3 flex-wrap w-100">
                    <div>
                        <label class="form-label">From Date</label>
                        <input type="date" name="fromDate" class="form-control" style="width:175px;" value="${fromDate}">
                    </div>
                    <div>
                        <label class="form-label">To Date</label>
                        <input type="date" name="toDate" class="form-control" style="width:175px;" value="${toDate}">
                    </div>
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary"><i class="fa fa-filter me-1"></i>Apply Filter</button>
                        <a href="/report/expense" class="btn" style="background:var(--bg-card2);border:1px solid var(--border);color:var(--text-secondary);">Clear</a>
                    </div>
                </form>
            </div>

            <!-- Summary Tiles -->
            <div class="report-summary-grid">
                <div class="summary-tile tile-expense">
                    <div class="tile-label"><i class="fa fa-rupee-sign me-1"></i>Total Spent</div>
                    <div class="tile-value">&#8377;<fmt:formatNumber value="${totalExpense}" pattern="#,##0.00"/></div>
                </div>
                <div class="summary-tile tile-count">
                    <div class="tile-label"><i class="fa fa-receipt me-1"></i>Transactions</div>
                    <div class="tile-value">${expenseList.size()}</div>
                </div>
                <c:if test="${not empty fromDate}">
                <div class="summary-tile" style="border-color:rgba(0,212,255,0.2);">
                    <div class="tile-label"><i class="fa fa-calendar-alt me-1"></i>Period</div>
                    <div class="tile-value" style="font-size:14px;color:var(--text-secondary);">${fromDate} &rarr; ${toDate}</div>
                </div>
                </c:if>
            </div>

            <!-- DataTable Card -->
            <div class="card">
                <div class="d-flex align-items-center justify-content-between mb-3">
                    <h5 class="mb-0" style="font-size:15px;"><i class="fa fa-table me-2 text-primary"></i>Expense Transactions</h5>
                    <span style="background:rgba(239,68,68,0.1);color:#ef4444;padding:4px 14px;border-radius:99px;font-size:12px;font-weight:600;">
                        Total: &#8377;<fmt:formatNumber value="${totalExpense}" pattern="#,##0.00"/>
                    </span>
                </div>
                <div class="table-responsive">
                    <table id="expenseReportTable" class="table table-hover align-middle" style="width:100%">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Title</th>
                                <th>Amount (&#8377;)</th>
                                <th>Date</th>
                                <th>Description</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="exp" items="${expenseList}" varStatus="s">
                            <tr>
                                <td style="color:var(--text-muted);font-size:12px;">${s.count}</td>
                                <td><strong>${exp.title}</strong></td>
                                <td><span style="color:#ef4444;font-weight:700;">&#8377; <fmt:formatNumber value="${exp.amount}" pattern="#,##0.00"/></span></td>
                                <td><span style="background:rgba(0,212,255,0.08);color:var(--primary);padding:3px 10px;border-radius:99px;font-size:12px;">${exp.date}</span></td>
                                <td style="color:var(--text-secondary);font-size:13px;">${exp.description}</td>
                            </tr>
                            </c:forEach>
                            <c:if test="${empty expenseList}">
                            <tr><td colspan="5" style="text-align:center;padding:40px;color:var(--text-muted);">
                                <i class="fa fa-inbox fa-2x d-block mb-2"></i>No expense records found.
                            </td></tr>
                            </c:if>
                        </tbody>
                        <tfoot>
                            <tr style="background:var(--bg-card2);">
                                <td colspan="2" style="font-weight:700;color:var(--text-primary);">GRAND TOTAL</td>
                                <td style="color:#ef4444;font-weight:700;font-size:15px;">&#8377; <fmt:formatNumber value="${totalExpense}" pattern="#,##0.00"/></td>
                                <td colspan="2"></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>

        </div><!-- /container -->

        <jsp:include page="../UserFooter.jsp"></jsp:include>
    </div>
</div>

<!-- Toast -->
<div id="mailToast" style="position:fixed;bottom:28px;right:28px;z-index:9999;display:none;
     background:var(--bg-card);border:1px solid var(--primary);border-radius:14px;
     padding:14px 22px;color:var(--text-primary);box-shadow:0 12px 40px rgba(0,0,0,0.6);
     min-width:290px;font-size:13.5px;backdrop-filter:blur(10px);">
</div>

<script>
function sendReportMail(type) {
    var toast = document.getElementById('mailToast');
    var from = document.querySelector('[name=fromDate]') ? document.querySelector('[name=fromDate]').value : '';
    var to   = document.querySelector('[name=toDate]')   ? document.querySelector('[name=toDate]').value   : '';
    toast.innerHTML = '<i class="fa fa-spinner fa-spin me-2" style="color:var(--primary)"></i>Sending report to your email...';
    toast.style.display = 'block'; toast.style.borderColor = 'var(--primary)';
    fetch('/report/sendMail?type=' + encodeURIComponent(type) + '&fromDate=' + from + '&toDate=' + to)
        .then(r => r.text())
        .then(res => {
            if (res === 'success') {
                toast.innerHTML = '<i class="fa fa-check-circle me-2" style="color:#10b981"></i>Report sent successfully to your email!';
                toast.style.borderColor = '#10b981';
            } else {
                toast.innerHTML = '<i class="fa fa-times-circle me-2" style="color:#ef4444"></i>Failed to send email. Try again.';
                toast.style.borderColor = '#ef4444';
            }
            setTimeout(() => toast.style.display = 'none', 5000);
        });
}

document.addEventListener('DOMContentLoaded', function() {
    if (typeof $ !== 'undefined' && $.fn.DataTable) {
        $('#expenseReportTable').DataTable({
            pageLength: 15,
            order: [[3, 'desc']],
            dom: 'Bfrtip',
            buttons: [
                { extend: 'csv',   text: '<i class="fa fa-file-csv me-1"></i>CSV',   className: '' },
                { extend: 'excel', text: '<i class="fa fa-file-excel me-1"></i>Excel', className: '' },
                { extend: 'pdf',   text: '<i class="fa fa-file-pdf me-1"></i>PDF',   className: '' },
                { extend: 'print', text: '<i class="fa fa-print me-1"></i>Print',  className: '' }
            ]
        });
    }
});
</script>
</body>
</html>
