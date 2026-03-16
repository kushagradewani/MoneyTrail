(function ($) {
    "use strict";

    // Spinner
    var spinner = function () {
        setTimeout(function () {
            if ($('#spinner').length > 0) {
                $('#spinner').removeClass('show');
            }
        }, 1);
    };
    spinner();


    // Back to top button
    $(window).scroll(function () {
        if ($(this).scrollTop() > 300) {
            $('.back-to-top').fadeIn('slow');
        } else {
            $('.back-to-top').fadeOut('slow');
        }
    });
    $('.back-to-top').click(function () {
        $('html, body').animate({ scrollTop: 0 }, 1500, 'easeInOutExpo');
        return false;
    });


    // Sidebar Toggler
    $('.sidebar-toggler').click(function () {
        $('.sidebar, .content').toggleClass("open");
        return false;
    });


    // Progress Bar
    $('.pg-bar').waypoint(function () {
        $('.progress .progress-bar').each(function () {
            $(this).css("width", $(this).attr("aria-valuenow") + '%');
        });
    }, { offset: '80%' });


    // Calender
    $('#calender').datetimepicker({
        inline: true,
        format: 'L'
    });


    // Testimonials carousel
    $(".testimonial-carousel").owlCarousel({
        autoplay: true,
        smartSpeed: 1000,
        items: 1,
        dots: true,
        loop: true,
        nav: false
    });


    // ==========================
    // Read CSS Variables
    // ==========================
    const primaryColor = getComputedStyle(document.documentElement)
        .getPropertyValue('--primary').trim();
    const lightColor = getComputedStyle(document.documentElement)
        .getPropertyValue('--light').trim();
    const secondaryColor = getComputedStyle(document.documentElement)
        .getPropertyValue('--secondary').trim();
    const darkColor = getComputedStyle(document.documentElement)
        .getPropertyValue('--dark').trim();

    // ==========================
    // Helper: hex to rgba
    // ==========================
    function hexToRgba(hex, alpha = 1) {
        hex = hex.replace('#', '');
        const r = parseInt(hex.substring(0, 2), 16);
        const g = parseInt(hex.substring(2, 4), 16);
        const b = parseInt(hex.substring(4, 6), 16);
        return `rgba(${r},${g},${b},${alpha})`;
    }

    // ==========================
    // Chart Global Defaults
    // ==========================
    Chart.defaults.color = lightColor;
    Chart.defaults.borderColor = darkColor;

    // ==========================
    // Worldwide Sales Chart
    // ==========================
    var ctx1 = $("#worldwide-sales").get(0).getContext("2d");
    var myChart1 = new Chart(ctx1, {
        type: "bar",
        data: {
            labels: ["2016", "2017", "2018", "2019", "2020", "2021", "2022"],
            datasets: [
                {
                    label: "USA",
                    data: [15, 30, 55, 65, 60, 80, 95],
                    backgroundColor: hexToRgba(primaryColor, 0.7)
                },
                {
                    label: "UK",
                    data: [8, 35, 40, 60, 70, 55, 75],
                    backgroundColor: hexToRgba(primaryColor, 0.5)
                },
                {
                    label: "AU",
                    data: [12, 25, 45, 55, 65, 70, 60],
                    backgroundColor: hexToRgba(primaryColor, 0.3)
                }
            ]
        },
        options: {
            responsive: true,
            scales: {
                x: { ticks: { color: lightColor }, grid: { color: secondaryColor } },
                y: { ticks: { color: lightColor }, grid: { color: secondaryColor } }
            }
        }
    });

    // ==========================
    // Sales & Revenue Chart
    // ==========================
    var ctx2 = $("#salse-revenue").get(0).getContext("2d");
    var myChart2 = new Chart(ctx2, {
        type: "line",
        data: {
            labels: ["2016", "2017", "2018", "2019", "2020", "2021", "2022"],
            datasets: [
                {
                    label: "Sales",
                    data: [15, 30, 55, 45, 70, 65, 85],
                    borderColor: primaryColor,
                    backgroundColor: hexToRgba(primaryColor, 0.2),
                    fill: true,
                    tension: 0.4
                },
                {
                    label: "Revenue",
                    data: [99, 135, 170, 130, 190, 180, 270],
                    borderColor: lightColor,
                    backgroundColor: hexToRgba(lightColor, 0.2),
                    fill: true,
                    tension: 0.4
                }
            ]
        },
        options: {
            responsive: true,
            scales: {
                x: { ticks: { color: lightColor }, grid: { color: secondaryColor } },
                y: { ticks: { color: lightColor }, grid: { color: secondaryColor } }
            }
        }
    });

    // ==========================
    // Single Line Chart
    // ==========================
    var ctx3 = $("#line-chart").get(0).getContext("2d");
    var myChart3 = new Chart(ctx3, {
        type: "line",
        data: {
            labels: [50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150],
            datasets: [{
                label: "Sales",
                fill: false,
                borderColor: primaryColor,
                backgroundColor: hexToRgba(primaryColor, 0.2),
                data: [7, 8, 8, 9, 9, 9, 10, 11, 14, 14, 15]
            }]
        },
        options: {
            responsive: true,
            scales: {
                x: { ticks: { color: lightColor }, grid: { color: secondaryColor } },
                y: { ticks: { color: lightColor }, grid: { color: secondaryColor } }
            }
        }
    });

    // ==========================
    // Single Bar Chart
    // ==========================
    var ctx4 = $("#bar-chart").get(0).getContext("2d");
    var myChart4 = new Chart(ctx4, {
        type: "bar",
        data: {
            labels: ["Italy", "France", "Spain", "USA", "Argentina"],
            datasets: [{
                data: [55, 49, 44, 24, 15],
                backgroundColor: [
                    hexToRgba(primaryColor, 0.7),
                    hexToRgba(primaryColor, 0.6),
                    hexToRgba(primaryColor, 0.5),
                    hexToRgba(primaryColor, 0.4),
                    hexToRgba(primaryColor, 0.3)
                ]
            }]
        },
        options: { responsive: true }
    });

    // ==========================
    // Pie Chart
    // ==========================
    var ctx5 = $("#pie-chart").get(0).getContext("2d");
    var myChart5 = new Chart(ctx5, {
        type: "pie",
        data: {
            labels: ["Italy", "France", "Spain", "USA", "Argentina"],
            datasets: [{
                data: [55, 49, 44, 24, 15],
                backgroundColor: [
                    hexToRgba(primaryColor, 0.7),
                    hexToRgba(primaryColor, 0.6),
                    hexToRgba(primaryColor, 0.5),
                    hexToRgba(primaryColor, 0.4),
                    hexToRgba(primaryColor, 0.3)
                ]
            }]
        },
        options: { responsive: true }
    });

    // ==========================
    // Doughnut Chart
    // ==========================
    var ctx6 = $("#doughnut-chart").get(0).getContext("2d");
    var myChart6 = new Chart(ctx6, {
        type: "doughnut",
        data: {
            labels: ["Italy", "France", "Spain", "USA", "Argentina"],
            datasets: [{
                data: [55, 49, 44, 24, 15],
                backgroundColor: [
                    hexToRgba(primaryColor, 0.7),
                    hexToRgba(primaryColor, 0.6),
                    hexToRgba(primaryColor, 0.5),
                    hexToRgba(primaryColor, 0.4),
                    hexToRgba(primaryColor, 0.3)
                ]
            }]
        },
        options: { responsive: true }
    });


})(jQuery);

