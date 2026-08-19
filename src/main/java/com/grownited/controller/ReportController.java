package com.grownited.controller;

import java.io.ByteArrayOutputStream;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.grownited.entity.CategoryEntity;
import com.grownited.entity.ExpenseEntity;
import com.grownited.entity.IncomeEntity;
import com.grownited.entity.userEntity;
import com.grownited.repository.CategoryRepository;
import com.grownited.repository.ExpenseRepository;
import com.grownited.repository.IncomeRepository;

import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

@Transactional
@Controller
@RequestMapping("/report")
public class ReportController {

    @Autowired
    private ExpenseRepository expenseRepository;

    @Autowired
    private IncomeRepository incomeRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private JavaMailSender mailSender;

    // ─────────────────────────────────────────────────────────────────────────
    // 1. EXPENSE REPORT
    // ─────────────────────────────────────────────────────────────────────────
    @GetMapping("/expense")
    public String expenseReport(
            @RequestParam(required = false) String fromDate,
            @RequestParam(required = false) String toDate,
            Model model, HttpSession session) {

        userEntity user = (userEntity) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        List<ExpenseEntity> expenses = expenseRepository.findByUserId(user.getUserId());

        // Filter by date range if provided
        if (fromDate != null && !fromDate.isEmpty() && toDate != null && !toDate.isEmpty()) {
            LocalDate from = LocalDate.parse(fromDate);
            LocalDate to = LocalDate.parse(toDate);
            expenses = expenses.stream()
                .filter(e -> e.getDate() != null &&
                             !e.getDate().isBefore(from) &&
                             !e.getDate().isAfter(to))
                .toList();
        }

        double total = expenses.stream().mapToDouble(e -> e.getAmount() != null ? e.getAmount() : 0).sum();

        model.addAttribute("expenseList", expenses);
        model.addAttribute("totalExpense", total);
        model.addAttribute("fromDate", fromDate);
        model.addAttribute("toDate", toDate);
        model.addAttribute("activePage", "report");
        return "USER/reports/ExpenseReport";
    }

    // ─────────────────────────────────────────────────────────────────────────
    // 2. CATEGORY-WISE EXPENSE REPORT
    // ─────────────────────────────────────────────────────────────────────────
    @GetMapping("/category")
    public String categoryReport(
            @RequestParam(required = false) String fromDate,
            @RequestParam(required = false) String toDate,
            Model model, HttpSession session) {

        userEntity user = (userEntity) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        List<ExpenseEntity> expenses = expenseRepository.findByUserId(user.getUserId());

        if (fromDate != null && !fromDate.isEmpty() && toDate != null && !toDate.isEmpty()) {
            LocalDate from = LocalDate.parse(fromDate);
            LocalDate to = LocalDate.parse(toDate);
            expenses = expenses.stream()
                .filter(e -> e.getDate() != null &&
                             !e.getDate().isBefore(from) &&
                             !e.getDate().isAfter(to))
                .toList();
        }

        // Group by category
        List<CategoryEntity> categories = categoryRepository.findAll();
        Map<Integer, String> catMap = new HashMap<>();
        for (CategoryEntity c : categories) catMap.put(c.getCategoryId(), c.getCategoryName());

        Map<String, Double> catTotals = new HashMap<>();
        for (ExpenseEntity e : expenses) {
            String catName = catMap.getOrDefault(e.getCategoryId(), "Uncategorized");
            catTotals.merge(catName, e.getAmount() != null ? e.getAmount() : 0, Double::sum);
        }

        double grandTotal = catTotals.values().stream().mapToDouble(Double::doubleValue).sum();

        model.addAttribute("catTotals", catTotals);
        model.addAttribute("grandTotal", grandTotal);
        model.addAttribute("fromDate", fromDate);
        model.addAttribute("toDate", toDate);
        model.addAttribute("activePage", "report");
        return "USER/reports/CategoryReport";
    }

    // ─────────────────────────────────────────────────────────────────────────
    // 3. INCOME REPORT
    // ─────────────────────────────────────────────────────────────────────────
    @GetMapping("/income")
    public String incomeReport(
            @RequestParam(required = false) String fromDate,
            @RequestParam(required = false) String toDate,
            Model model, HttpSession session) {

        userEntity user = (userEntity) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        List<IncomeEntity> incomes = incomeRepository.findByUserId(user.getUserId());

        if (fromDate != null && !fromDate.isEmpty() && toDate != null && !toDate.isEmpty()) {
            LocalDate from = LocalDate.parse(fromDate);
            LocalDate to = LocalDate.parse(toDate);
            incomes = incomes.stream()
                .filter(i -> i.getDate() != null &&
                             !i.getDate().isBefore(from) &&
                             !i.getDate().isAfter(to))
                .toList();
        }

        double total = incomes.stream().mapToDouble(i -> i.getAmount() != null ? i.getAmount() : 0).sum();

        model.addAttribute("incomeList", incomes);
        model.addAttribute("totalIncome", total);
        model.addAttribute("fromDate", fromDate);
        model.addAttribute("toDate", toDate);
        model.addAttribute("activePage", "report");
        return "USER/reports/IncomeReport";
    }

    // ─────────────────────────────────────────────────────────────────────────
    // 4. PROFIT / LOSS REPORT
    // ─────────────────────────────────────────────────────────────────────────
    @GetMapping("/profitloss")
    public String profitLossReport(
            @RequestParam(required = false) String fromDate,
            @RequestParam(required = false) String toDate,
            Model model, HttpSession session) {

        userEntity user = (userEntity) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        List<IncomeEntity> incomes = incomeRepository.findByUserId(user.getUserId());
        List<ExpenseEntity> expenses = expenseRepository.findByUserId(user.getUserId());

        if (fromDate != null && !fromDate.isEmpty() && toDate != null && !toDate.isEmpty()) {
            LocalDate from = LocalDate.parse(fromDate);
            LocalDate to = LocalDate.parse(toDate);
            incomes = incomes.stream()
                .filter(i -> i.getDate() != null && !i.getDate().isBefore(from) && !i.getDate().isAfter(to))
                .toList();
            expenses = expenses.stream()
                .filter(e -> e.getDate() != null && !e.getDate().isBefore(from) && !e.getDate().isAfter(to))
                .toList();
        }

        double totalIncome  = incomes.stream().mapToDouble(i -> i.getAmount() != null ? i.getAmount() : 0).sum();
        double totalExpense = expenses.stream().mapToDouble(e -> e.getAmount() != null ? e.getAmount() : 0).sum();
        double netProfitLoss = totalIncome - totalExpense;

        // Build monthly breakdown (last 12 months)
        List<Map<String, Object>> monthlyData = new ArrayList<>();
        LocalDate now = LocalDate.now();
        for (int i = 11; i >= 0; i--) {
            LocalDate month = now.minusMonths(i);
            int m = month.getMonthValue();
            int y = month.getYear();
            final int fm = m; final int fy = y;

            double inc = incomes.stream()
                .filter(x -> x.getDate() != null && x.getDate().getMonthValue() == fm && x.getDate().getYear() == fy)
                .mapToDouble(x -> x.getAmount() != null ? x.getAmount() : 0).sum();
            double exp = expenses.stream()
                .filter(x -> x.getDate() != null && x.getDate().getMonthValue() == fm && x.getDate().getYear() == fy)
                .mapToDouble(x -> x.getAmount() != null ? x.getAmount() : 0).sum();

            Map<String, Object> row = new HashMap<>();
            row.put("month", month.format(DateTimeFormatter.ofPattern("MMM yyyy")));
            row.put("income", inc);
            row.put("expense", exp);
            row.put("net", inc - exp);
            monthlyData.add(row);
        }

        model.addAttribute("totalIncome", totalIncome);
        model.addAttribute("totalExpense", totalExpense);
        model.addAttribute("netProfitLoss", netProfitLoss);
        model.addAttribute("monthlyData", monthlyData);
        model.addAttribute("fromDate", fromDate);
        model.addAttribute("toDate", toDate);
        model.addAttribute("activePage", "report");
        return "USER/reports/ProfitLossReport";
    }

    // ─────────────────────────────────────────────────────────────────────────
    // 5. SEND REPORT VIA EMAIL
    // ─────────────────────────────────────────────────────────────────────────
    @GetMapping("/sendMail")
    @ResponseBody
    public String sendReportMail(
            @RequestParam String type,
            @RequestParam(required = false) String fromDate,
            @RequestParam(required = false) String toDate,
            HttpSession session) {

        userEntity user = (userEntity) session.getAttribute("user");
        if (user == null) return "error:notLoggedIn";

        try {
            String subject = "MoneyTrail - " + type + " Report";
            StringBuilder html = new StringBuilder();
            html.append("<div style='font-family:Arial,sans-serif;background:#0d1117;color:#e6edf3;padding:30px;border-radius:10px;max-width:600px;margin:auto;'>");
            html.append("<h2 style='color:#00d4ff;border-bottom:2px solid #00d4ff;padding-bottom:10px;'>&#x1F4CA; ").append(type).append(" Report</h2>");
            html.append("<p>Hi <b>").append(user.getFirstName()).append("</b>,</p>");
            html.append("<p>Your <b>").append(type).append(" Report</b> has been generated on MoneyTrail.</p>");

            if (fromDate != null && !fromDate.isEmpty()) {
                html.append("<p>&#x1F4C5; Period: <b>").append(fromDate).append("</b> to <b>").append(toDate).append("</b></p>");
            } else {
                html.append("<p>&#x1F4C5; Period: <b>All Time</b></p>");
            }

            if ("Expense".equalsIgnoreCase(type)) {
                List<ExpenseEntity> expenses = expenseRepository.findByUserId(user.getUserId());
                if (fromDate != null && !fromDate.isEmpty()) {
                    LocalDate from = LocalDate.parse(fromDate);
                    LocalDate to = LocalDate.parse(toDate);
                    expenses = expenses.stream().filter(e -> e.getDate() != null && !e.getDate().isBefore(from) && !e.getDate().isAfter(to)).toList();
                }
                double total = expenses.stream().mapToDouble(e -> e.getAmount() != null ? e.getAmount() : 0).sum();
                html.append("<p>Total Expenses: <b style='color:#ff6b6b;'>&#8377; ").append(String.format("%.2f", total)).append("</b></p>");
                html.append("<table style='width:100%;border-collapse:collapse;margin-top:15px;'>");
                html.append("<tr style='background:#1c2128;'><th style='padding:8px;border:1px solid #333;'>Title</th><th style='padding:8px;border:1px solid #333;'>Amount</th><th style='padding:8px;border:1px solid #333;'>Date</th></tr>");
                for (ExpenseEntity e : expenses) {
                    html.append("<tr><td style='padding:8px;border:1px solid #333;'>").append(e.getTitle()).append("</td>")
                        .append("<td style='padding:8px;border:1px solid #333;color:#ff6b6b;'>&#8377; ").append(e.getAmount()).append("</td>")
                        .append("<td style='padding:8px;border:1px solid #333;'>").append(e.getDate()).append("</td></tr>");
                }
                html.append("</table>");

            } else if ("Income".equalsIgnoreCase(type)) {
                List<IncomeEntity> incomes = incomeRepository.findByUserId(user.getUserId());
                if (fromDate != null && !fromDate.isEmpty()) {
                    LocalDate from = LocalDate.parse(fromDate);
                    LocalDate to = LocalDate.parse(toDate);
                    incomes = incomes.stream().filter(i -> i.getDate() != null && !i.getDate().isBefore(from) && !i.getDate().isAfter(to)).toList();
                }
                double total = incomes.stream().mapToDouble(i -> i.getAmount() != null ? i.getAmount() : 0).sum();
                html.append("<p>Total Income: <b style='color:#51cf66;'>&#8377; ").append(String.format("%.2f", total)).append("</b></p>");

            } else if ("Profit/Loss".equalsIgnoreCase(type)) {
                List<IncomeEntity> incomes = incomeRepository.findByUserId(user.getUserId());
                List<ExpenseEntity> expenses = expenseRepository.findByUserId(user.getUserId());
                double inc = incomes.stream().mapToDouble(i -> i.getAmount() != null ? i.getAmount() : 0).sum();
                double exp = expenses.stream().mapToDouble(e -> e.getAmount() != null ? e.getAmount() : 0).sum();
                double net = inc - exp;
                String netColor = net >= 0 ? "#51cf66" : "#ff6b6b";
                html.append("<p>Total Income: <b style='color:#51cf66;'>&#8377; ").append(String.format("%.2f", inc)).append("</b></p>");
                html.append("<p>Total Expense: <b style='color:#ff6b6b;'>&#8377; ").append(String.format("%.2f", exp)).append("</b></p>");
                html.append("<p>Net P/L: <b style='color:").append(netColor).append(";font-size:18px;'>&#8377; ").append(String.format("%.2f", net)).append("</b></p>");
            }

            html.append("<hr style='border-color:#333;margin-top:20px;'>");
            html.append("<p style='color:#888;font-size:12px;'>This is an automated report from MoneyTrail &mdash; your smart financial tracker.</p>");
            html.append("</div>");

            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setTo(user.getEmail());
            helper.setFrom("moneytrailowner@gmail.com");
            helper.setSubject(subject);
            helper.setText(html.toString(), true);
            mailSender.send(message);

            return "success";
        } catch (Exception ex) {
            ex.printStackTrace();
            return "error:" + ex.getMessage();
        }
    }
}
