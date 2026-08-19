<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Category Report - MoneyTrail</title>
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
                    <h4 class="mb-1"><i class="fa fa-chart-pie me-2 text-primary"></i>Category-wise Expense Report</h4>
                    <small style="color:var(--text-secondary);">Dashboard &rsaquo; Reports &rsaquo; <span style="color:var(--primary)">Category Report</span></small>
                </div>
                <div class="d-flex gap-2">
                    <button onclick="window.print()" class="btn btn-sm" style="background:var(--bg-card2);border:1px solid var(--border);color:var(--text-secondary);"><i class="fa fa-print me-1"></i>Print</button>
                    <button onclick="sendReportMail('Category')" class="btn btn-primary btn-sm"><i class="fa fa-envelope me-1"></i>Email Report</button>
                </div>
            </div>

            <!-- Filter -->
            <div class="report-filter-card">
                <form method="get" action="/report/category" class="d-flex align-items-end gap-3 flex-wrap w-100">
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
                        <a href="/report/category" class="btn" style="background:var(--bg-card2);border:1px solid var(--border);color:var(--text-secondary);">Clear</a>
                    </div>
                </form>
            </div>

            <!-- Summary Tiles -->
            <div class="report-summary-grid">
                <div class="summary-tile tile-expense">
                    <div class="tile-label"><i class="fa fa-rupee-sign me-1"></i>Grand Total</div>
                    <div class="tile-value">&#8377;<fmt:formatNumber value="${grandTotal}" pattern="#,##0.00"/></div>
                </div>
                <div class="summary-tile tile-count">
                    <div class="tile-label"><i class="fa fa-tags me-1"></i>Categories</div>
                    <div class="tile-value">${catTotals.size()}</div>
                </div>
            </div>

            <div class="row g-4">
                <!-- Bar Breakdown -->
                <div class="col-lg-6">
                    <div class="card h-100">
                        <h5 class="mb-4" style="font-size:15px;"><i class="fa fa-chart-bar me-2 text-primary"></i>Category Breakdown</h5>
                        <c:choose>
                        <c:when test="${not empty catTotals}">
                            <c:forEach var="entry" items="${catTotals}">
                            <div class="cat-bar-row">
                                <div class="cat-bar-label">
                                    <span>${entry.key}</span>
                                    <span>&#8377; <fmt:formatNumber value="${entry.value}" pattern="#,##0.00"/></span>
                                </div>
                                <div class="cat-bar-track">
                                    <c:set var="pct" value="${grandTotal > 0 ? entry.value / grandTotal * 100 : 0}"/>
                                    <div class="cat-bar-fill" style="width:${pct}%"></div>
                                </div>
                                <div style="font-size:11px;color:var(--text-muted);margin-top:2px;text-align:right;">
                                    <fmt:formatNumber value="${pct}" pattern="#0.0"/>%
                                </div>
                            </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <p style="color:var(--text-muted);text-align:center;padding:30px;">No data available for this period.</p>
                        </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Doughnut Chart -->
                <div class="col-lg-6">
                    <div class="card h-100">
                        <h5 class="mb-4" style="font-size:15px;"><i class="fa fa-chart-pie me-2 text-primary"></i>Visual Split</h5>
                        <canvas id="catChart"></canvas>
                        <c:if test="${empty catTotals}">
                            <p style="color:var(--text-muted);text-align:center;padding:30px;">No chart data.</p>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Summary Table -->
            <div class="card mt-4">
                <h5 class="mb-3" style="font-size:15px;"><i class="fa fa-table me-2 text-primary"></i>Category Summary Table</h5>
                <div class="table-responsive">
                    <table id="catReportTable" class="table table-hover align-middle" style="width:100%">
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Category Name</th>
                                <th>Total Amount (&#8377;)</th>
                                <th>Share (%)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="rowNum" value="0"/>
                            <c:forEach var="entry" items="${catTotals}">
                            <c:set var="rowNum" value="${rowNum + 1}"/>
                            <c:set var="pctShare" value="${grandTotal > 0 ? entry.value / grandTotal * 100 : 0}"/>
                            <tr>
                                <td style="color:var(--text-muted);font-size:12px;">${rowNum}</td>
                                <td>
                                    <span style="display:inline-flex;align-items:center;gap:8px;">
                                        <span style="width:10px;height:10px;border-radius:50%;background:var(--primary);flex-shrink:0;"></span>
                                        <strong>${entry.key}</strong>
                                    </span>
                                </td>
                                <td style="color:#ef4444;font-weight:700;">&#8377; <fmt:formatNumber value="${entry.value}" pattern="#,##0.00"/></td>
                                <td>
                                    <span style="background:rgba(0,212,255,0.1);color:var(--primary);padding:3px 12px;border-radius:99px;font-size:12px;font-weight:600;">
                                        <fmt:formatNumber value="${pctShare}" pattern="#0.1"/>%
                                    </span>
                                </td>
                            </tr>
                            </c:forEach>
                            <c:if test="${empty catTotals}">
                            <tr><td colspan="4" style="text-align:center;padding:40px;color:var(--text-muted);">
                                <i class="fa fa-inbox fa-2x d-block mb-2"></i>No category data found.
                            </td></tr>
                            </c:if>
                        </tbody>
                        <tfoot>
                            <tr style="background:var(--bg-card2);">
                                <td colspan="2" style="font-weight:700;">GRAND TOTAL</td>
                                <td style="color:#ef4444;font-weight:700;font-size:15px;">&#8377; <fmt:formatNumber value="${grandTotal}" pattern="#,##0.00"/></td>
                                <td style="color:var(--primary);font-weight:700;">100.0%</td>
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
     min-width:290px;font-size:13.5px;backdrop-filter:blur(10px);">
</div>

<script>
// Build chart data from server
var catLabels = [];
var catValues = [];
var COLORS = ['#00d4ff','#7c3aed','#10b981','#f59e0b','#ef4444','#3b82f6','#ec4899','#14b8a6','#f97316','#a855f7','#06b6d4','#84cc16'];
<c:forEach var="entry" items="${catTotals}">
    catLabels.push('${entry.key}');
    catValues.push(${entry.value});
</c:forEach>

document.addEventListener('DOMContentLoaded', function() {
    var ctx = document.getElementById('catChart');
    if (ctx && catLabels.length > 0) {
        new Chart(ctx, {
            type: 'doughnut',
            data: {
                labels: catLabels,
                datasets: [{
                    data: catValues,
                    backgroundColor: COLORS.slice(0, catLabels.length),
                    borderWidth: 3,
                    borderColor: '#0d1117',
                    hoverOffset: 8
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    legend: {
                        position: 'right',
                        labels: { color: '#8b949e', font: { size: 12 }, padding: 14, boxWidth: 14 }
                    },
                    tooltip: {
                        callbacks: {
                            label: function(ctx) {
                                var total = ctx.dataset.data.reduce(function(a,b){ return a+b; }, 0);
                                var pct = ((ctx.parsed / total) * 100).toFixed(1);
                                return ' \u20B9' + ctx.parsed.toFixed(2) + ' (' + pct + '%)';
                            }
                        }
                    }
                },
                cutout: '62%'
            }
        });
    }

    // DataTable
    if (typeof $ !== 'undefined' && $.fn.DataTable) {
        $('#catReportTable').DataTable({
            pageLength: 15,
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
                : '<i class="fa fa-times-circle me-2" style="color:#ef4444"></i>Failed to send. Try again.';
            toast.style.borderColor = res === 'success' ? '#10b981' : '#ef4444';
            setTimeout(() => toast.style.display = 'none', 5000);
        });
}
</script>
</body>
</html>
