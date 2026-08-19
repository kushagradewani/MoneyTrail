<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Profit &amp; Loss Report - MoneyTrail</title>
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
                    <h4 class="mb-1"><i class="fa fa-balance-scale me-2 text-primary"></i>Profit &amp; Loss Report</h4>
                    <small style="color:var(--text-secondary);">Dashboard &rsaquo; Reports &rsaquo; <span style="color:var(--primary)">Profit / Loss</span></small>
                </div>
                <div class="d-flex gap-2">
                    <button onclick="window.print()" class="btn btn-sm" style="background:var(--bg-card2);border:1px solid var(--border);color:var(--text-secondary);"><i class="fa fa-print me-1"></i>Print</button>
                    <button onclick="sendReportMail('Profit/Loss')" class="btn btn-primary btn-sm"><i class="fa fa-envelope me-1"></i>Email Report</button>
                </div>
            </div>

            <!-- Filter -->
            <div class="report-filter-card">
                <form method="get" action="/report/profitloss" class="d-flex align-items-end gap-3 flex-wrap w-100">
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
                        <a href="/report/profitloss" class="btn" style="background:var(--bg-card2);border:1px solid var(--border);color:var(--text-secondary);">Clear</a>
                    </div>
                </form>
            </div>

            <!-- Summary Tiles -->
            <div class="report-summary-grid">
                <div class="summary-tile tile-income">
                    <div class="tile-label"><i class="fa fa-arrow-up me-1"></i>Total Income</div>
                    <div class="tile-value">&#8377;<fmt:formatNumber value="${totalIncome}" pattern="#,##0.00"/></div>
                </div>
                <div class="summary-tile tile-expense">
                    <div class="tile-label"><i class="fa fa-arrow-down me-1"></i>Total Expense</div>
                    <div class="tile-value">&#8377;<fmt:formatNumber value="${totalExpense}" pattern="#,##0.00"/></div>
                </div>
                <!-- Net P/L tile: green if profit, red if loss -->
                <c:choose>
                <c:when test="${netProfitLoss >= 0}">
                <div class="summary-tile" style="border-color:rgba(16,185,129,0.4);background:rgba(16,185,129,0.04);">
                    <div class="tile-label" style="color:#10b981;"><i class="fa fa-smile me-1"></i>Net Profit</div>
                    <div class="tile-value" style="color:#10b981;">
                        +&#8377;<fmt:formatNumber value="${netProfitLoss}" pattern="#,##0.00"/>
                    </div>
                    <div style="font-size:11px;color:#10b981;margin-top:4px;font-weight:500;">You are in profit &#x1F389;</div>
                </div>
                </c:when>
                <c:otherwise>
                <div class="summary-tile" style="border-color:rgba(239,68,68,0.4);background:rgba(239,68,68,0.04);">
                    <div class="tile-label" style="color:#ef4444;"><i class="fa fa-frown me-1"></i>Net Loss</div>
                    <div class="tile-value" style="color:#ef4444;">
                        -&#8377;<fmt:formatNumber value="${-netProfitLoss}" pattern="#,##0.00"/>
                    </div>
                    <div style="font-size:11px;color:#ef4444;margin-top:4px;font-weight:500;">Expenses exceed income &#x26A0;</div>
                </div>
                </c:otherwise>
                </c:choose>
            </div>

            <!-- Monthly Chart -->
            <div class="card mb-4">
                <h5 class="mb-4" style="font-size:15px;"><i class="fa fa-chart-area me-2 text-primary"></i>Monthly Income vs Expense (Last 12 Months)</h5>
                <canvas id="plChart" height="100"></canvas>
            </div>

            <!-- Monthly Breakdown Table -->
            <div class="card">
                <h5 class="mb-3" style="font-size:15px;"><i class="fa fa-table me-2 text-primary"></i>Monthly Breakdown</h5>
                <div class="table-responsive">
                    <table id="plTable" class="table table-hover align-middle" style="width:100%">
                        <thead>
                            <tr>
                                <th>Month</th>
                                <th>Income (&#8377;)</th>
                                <th>Expense (&#8377;)</th>
                                <th>Net Profit / Loss (&#8377;)</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="row" items="${monthlyData}">
                            <tr>
                                <td>
                                    <span style="background:var(--bg-card2);color:var(--text-primary);padding:4px 13px;border-radius:99px;font-size:12.5px;font-weight:500;">
                                        ${row.month}
                                    </span>
                                </td>
                                <td style="color:#10b981;font-weight:600;">
                                    &#8377; <fmt:formatNumber value="${row.income}" pattern="#,##0.00"/>
                                </td>
                                <td style="color:#ef4444;font-weight:600;">
                                    &#8377; <fmt:formatNumber value="${row.expense}" pattern="#,##0.00"/>
                                </td>
                                <td style="font-weight:700;font-size:14px;">
                                    <c:choose>
                                        <c:when test="${row.net > 0}">
                                            <span style="color:#10b981;">+&#8377;<fmt:formatNumber value="${row.net}" pattern="#,##0.00"/></span>
                                        </c:when>
                                        <c:when test="${row.net < 0}">
                                            <span style="color:#ef4444;">-&#8377;<fmt:formatNumber value="${-row.net}" pattern="#,##0.00"/></span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color:var(--text-secondary);">&#8377;0.00</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${row.net > 0}">
                                            <span style="background:rgba(16,185,129,0.15);color:#10b981;padding:3px 14px;border-radius:99px;font-size:12px;font-weight:600;">
                                                <i class="fa fa-arrow-up me-1"></i>Profit
                                            </span>
                                        </c:when>
                                        <c:when test="${row.net < 0}">
                                            <span style="background:rgba(239,68,68,0.15);color:#ef4444;padding:3px 14px;border-radius:99px;font-size:12px;font-weight:600;">
                                                <i class="fa fa-arrow-down me-1"></i>Loss
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="background:rgba(139,148,158,0.15);color:#8b949e;padding:3px 14px;border-radius:99px;font-size:12px;font-weight:600;">
                                                Break Even
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                            </c:forEach>
                        </tbody>
                        <tfoot>
                            <tr style="background:var(--bg-card2);">
                                <td style="font-weight:700;color:var(--text-primary);">TOTAL</td>
                                <td style="color:#10b981;font-weight:700;font-size:14px;">&#8377; <fmt:formatNumber value="${totalIncome}" pattern="#,##0.00"/></td>
                                <td style="color:#ef4444;font-weight:700;font-size:14px;">&#8377; <fmt:formatNumber value="${totalExpense}" pattern="#,##0.00"/></td>
                                <td style="font-weight:700;font-size:15px;">
                                    <c:choose>
                                        <c:when test="${netProfitLoss >= 0}">
                                            <span style="color:#10b981;">+&#8377;<fmt:formatNumber value="${netProfitLoss}" pattern="#,##0.00"/></span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color:#ef4444;">-&#8377;<fmt:formatNumber value="${-netProfitLoss}" pattern="#,##0.00"/></span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td></td>
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
// Pass monthly data from Spring MVC to JS
var plLabels = [];
var plIncome  = [];
var plExpense = [];
var plNet     = [];
<c:forEach var="row" items="${monthlyData}">
plLabels.push('${row.month}');
plIncome.push(${row.income});
plExpense.push(${row.expense});
plNet.push(${row.net});
</c:forEach>

document.addEventListener('DOMContentLoaded', function() {
    var ctx = document.getElementById('plChart');
    if (ctx) {
        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: plLabels,
                datasets: [
                    {
                        label: 'Income',
                        data: plIncome,
                        backgroundColor: 'rgba(16,185,129,0.65)',
                        borderColor: '#10b981',
                        borderWidth: 1,
                        borderRadius: 5,
                        order: 2
                    },
                    {
                        label: 'Expense',
                        data: plExpense,
                        backgroundColor: 'rgba(239,68,68,0.65)',
                        borderColor: '#ef4444',
                        borderWidth: 1,
                        borderRadius: 5,
                        order: 3
                    },
                    {
                        label: 'Net P/L',
                        data: plNet,
                        type: 'line',
                        borderColor: '#00d4ff',
                        backgroundColor: 'rgba(0,212,255,0.08)',
                        pointBackgroundColor: '#00d4ff',
                        pointRadius: 5,
                        pointHoverRadius: 7,
                        tension: 0.4,
                        fill: true,
                        order: 1,
                        yAxisID: 'y'
                    }
                ]
            },
            options: {
                responsive: true,
                interaction: { mode: 'index', intersect: false },
                plugins: {
                    legend: { labels: { color: '#8b949e', font: { size: 12 }, padding: 16 } },
                    tooltip: {
                        callbacks: {
                            label: function(c) {
                                return ' ' + c.dataset.label + ': \u20B9' + c.parsed.y.toFixed(2);
                            }
                        }
                    }
                },
                scales: {
                    x: {
                        grid: { color: 'rgba(48,54,61,0.5)' },
                        ticks: { color: '#8b949e', font: { size: 11 } }
                    },
                    y: {
                        grid: { color: 'rgba(48,54,61,0.5)' },
                        ticks: {
                            color: '#8b949e', font: { size: 11 },
                            callback: function(v) { return '\u20B9' + v.toLocaleString('en-IN'); }
                        }
                    }
                }
            }
        });
    }

    if (typeof $ !== 'undefined' && $.fn.DataTable) {
        $('#plTable').DataTable({
            pageLength: 12,
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
    toast.innerHTML = '<i class="fa fa-spinner fa-spin me-2" style="color:var(--primary)"></i>Sending report to your email...';
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
