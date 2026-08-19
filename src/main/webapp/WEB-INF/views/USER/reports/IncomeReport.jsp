<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Income Report - MoneyTrail</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
    <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet">
    <link href="css/userbootstrap.min.css" rel="stylesheet">
    <link href="css/userstyle.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.datatables.net/2.3.7/css/dataTables.dataTables.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/3.2.6/css/buttons.dataTables.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
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
                    <h4 class="mb-1"><i class="fa fa-hand-holding-usd me-2 text-primary"></i>Income Report</h4>
                    <small style="color:var(--text-secondary);">Dashboard &rsaquo; Reports &rsaquo; <span style="color:var(--primary)">Income Report</span></small>
                </div>
                <div class="d-flex gap-2">
                    <button onclick="window.print()" class="btn btn-sm" style="background:var(--bg-card2);border:1px solid var(--border);color:var(--text-secondary);"><i class="fa fa-print me-1"></i>Print</button>
                    <button onclick="sendReportMail('Income')" class="btn btn-primary btn-sm"><i class="fa fa-envelope me-1"></i>Email Report</button>
                </div>
            </div>

            <!-- Filter -->
            <div class="report-filter-card">
                <form method="get" action="/report/income" class="d-flex align-items-end gap-3 flex-wrap w-100">
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
                        <a href="/report/income" class="btn" style="background:var(--bg-card2);border:1px solid var(--border);color:var(--text-secondary);">Clear</a>
                    </div>
                </form>
            </div>

            <!-- Summary Tiles -->
            <div class="report-summary-grid">
                <div class="summary-tile tile-income">
                    <div class="tile-label"><i class="fa fa-rupee-sign me-1"></i>Total Income</div>
                    <div class="tile-value">&#8377;<fmt:formatNumber value="${totalIncome}" pattern="#,##0.00"/></div>
                </div>
                <div class="summary-tile tile-count">
                    <div class="tile-label"><i class="fa fa-receipt me-1"></i>Transactions</div>
                    <div class="tile-value">${incomeList.size()}</div>
                </div>
                <c:if test="${not empty fromDate}">
                <div class="summary-tile" style="border-color:rgba(16,185,129,0.2);">
                    <div class="tile-label"><i class="fa fa-calendar-alt me-1"></i>Period</div>
                    <div class="tile-value" style="font-size:14px;color:var(--text-secondary);">${fromDate} &rarr; ${toDate}</div>
                </div>
                </c:if>
            </div>

            <!-- Monthly Bar Chart -->
            <div class="card mb-4">
                <h5 class="mb-4" style="font-size:15px;"><i class="fa fa-chart-bar me-2 text-primary"></i>Income by Month</h5>
                <canvas id="incomeMonthChart" height="90"></canvas>
            </div>

            <!-- DataTable -->
            <div class="card">
                <div class="d-flex align-items-center justify-content-between mb-3">
                    <h5 class="mb-0" style="font-size:15px;"><i class="fa fa-table me-2 text-primary"></i>Income Transactions</h5>
                    <span style="background:rgba(16,185,129,0.1);color:#10b981;padding:4px 14px;border-radius:99px;font-size:12px;font-weight:600;">
                        Total: &#8377;<fmt:formatNumber value="${totalIncome}" pattern="#,##0.00"/>
                    </span>
                </div>
                <div class="table-responsive">
                    <table id="incomeReportTable" class="table table-hover align-middle" style="width:100%">
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
                            <c:forEach var="inc" items="${incomeList}" varStatus="s">
                            <tr>
                                <td style="color:var(--text-muted);font-size:12px;">${s.count}</td>
                                <td><strong>${inc.title}</strong></td>
                                <td><span style="color:#10b981;font-weight:700;">&#8377; <fmt:formatNumber value="${inc.amount}" pattern="#,##0.00"/></span></td>
                                <td><span style="background:rgba(16,185,129,0.1);color:#10b981;padding:3px 10px;border-radius:99px;font-size:12px;">${inc.date}</span></td>
                                <td style="color:var(--text-secondary);font-size:13px;">${inc.description}</td>
                            </tr>
                            </c:forEach>
                            <c:if test="${empty incomeList}">
                            <tr><td colspan="5" style="text-align:center;padding:40px;color:var(--text-muted);">
                                <i class="fa fa-inbox fa-2x d-block mb-2"></i>No income records found.
                            </td></tr>
                            </c:if>
                        </tbody>
                        <tfoot>
                            <tr style="background:var(--bg-card2);">
                                <td colspan="2" style="font-weight:700;">GRAND TOTAL</td>
                                <td style="color:#10b981;font-weight:700;font-size:15px;">&#8377; <fmt:formatNumber value="${totalIncome}" pattern="#,##0.00"/></td>
                                <td colspan="2"></td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </div>

        </div>

        <jsp:include page="../UserFooter.jsp"></jsp:include>
    </div>
</div>

<div id="mailToast" style="position:fixed;bottom:28px;right:28px;z-index:9999;display:none;
     background:var(--bg-card);border:1px solid var(--primary);border-radius:14px;
     padding:14px 22px;color:var(--text-primary);box-shadow:0 12px 40px rgba(0,0,0,0.6);
     min-width:290px;font-size:13.5px;">
</div>

<script>
// Build monthly income chart from transaction data
var monthMap = {};
<c:forEach var="inc" items="${incomeList}">
    <c:if test="${not empty inc.date}">
    (function() {
        var d = new Date('${inc.date}');
        var key = d.toLocaleString('default',{month:'short',year:'numeric'});
        monthMap[key] = (monthMap[key] || 0) + ${inc.amount};
    })();
    </c:if>
</c:forEach>

document.addEventListener('DOMContentLoaded', function() {
    var ctx = document.getElementById('incomeMonthChart');
    if (ctx && Object.keys(monthMap).length > 0) {
        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: Object.keys(monthMap),
                datasets: [{
                    label: 'Monthly Income',
                    data: Object.values(monthMap),
                    backgroundColor: 'rgba(16,185,129,0.6)',
                    borderColor: '#10b981',
                    borderWidth: 1,
                    borderRadius: 6
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: { labels: { color: '#8b949e' } },
                    tooltip: { callbacks: { label: function(c){ return ' \u20B9' + c.parsed.y.toFixed(2); } } }
                },
                scales: {
                    x: { grid: { color: 'rgba(48,54,61,0.5)' }, ticks: { color: '#8b949e' } },
                    y: { grid: { color: 'rgba(48,54,61,0.5)' }, ticks: { color: '#8b949e', callback: function(v){ return '\u20B9'+v.toLocaleString(); } } }
                }
            }
        });
    }

    if (typeof $ !== 'undefined' && $.fn.DataTable) {
        $('#incomeReportTable').DataTable({
            pageLength: 15,
            order: [[3, 'desc']],
            dom: 'Bfrtip',
            buttons: [
                { extend: 'csv',   text: '<i class="fa fa-file-csv me-1"></i>CSV' },
                { extend: 'excel', text: '<i class="fa fa-file-excel me-1"></i>Excel' },
                { extend: 'pdf',   text: '<i class="fa fa-file-pdf me-1"></i>PDF' },
                { extend: 'print', text: '<i class="fa fa-print me-1"></i>Print' }
            ]
        });
    }
});

function sendReportMail(type) {
    var toast = document.getElementById('mailToast');
    var from = document.querySelector('[name=fromDate]') ? document.querySelector('[name=fromDate]').value : '';
    var to   = document.querySelector('[name=toDate]')   ? document.querySelector('[name=toDate]').value   : '';
    toast.innerHTML = '<i class="fa fa-spinner fa-spin me-2" style="color:var(--primary)"></i>Sending report...';
    toast.style.display = 'block'; toast.style.borderColor = 'var(--primary)';
    fetch('/report/sendMail?type=' + encodeURIComponent(type) + '&fromDate=' + from + '&toDate=' + to)
        .then(r => r.text()).then(res => {
            toast.innerHTML = res === 'success'
                ? '<i class="fa fa-check-circle me-2" style="color:#10b981"></i>Report sent to your email!'
                : '<i class="fa fa-times-circle me-2" style="color:#ef4444"></i>Failed to send.';
            toast.style.borderColor = res === 'success' ? '#10b981' : '#ef4444';
            setTimeout(() => toast.style.display = 'none', 5000);
        });
}
</script>
</body>
</html>
