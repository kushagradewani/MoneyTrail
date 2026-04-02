package com.grownited.controller;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.grownited.entity.CategoryEntity;
import com.grownited.entity.ExpenseEntity;
import com.grownited.entity.IncomeEntity;
import com.grownited.entity.userEntity;
import com.grownited.repository.CategoryRepository;
import com.grownited.repository.ExpenseRepository;
import com.grownited.repository.IncomeRepository;

import jakarta.servlet.http.HttpSession;
import tools.jackson.databind.ObjectMapper;

@Controller
public class DashboardController {
	
	@Autowired
	IncomeRepository incomeRepository;
	
	@Autowired
	ExpenseRepository expenseRepository;
	
	@Autowired
	CategoryRepository categoryRepository;
	
	@GetMapping(value =  {"adminDashboard","/"})
	public String adminDashboard(Model model, HttpSession session) {

	    // Get the logged-in user from session
	    userEntity loggedUser = (userEntity) session.getAttribute("user");
	    if (loggedUser == null) {
	        return "redirect:/login";
	    }
	    Integer userId = loggedUser.getUserId();

	    // ================== Calculate amounts ==================
	    // This month
	    Double thisMonthIncome = incomeRepository.totalIncomeByUserAndMonth(userId, LocalDate.now().getMonthValue(), LocalDate.now().getYear());
	    thisMonthIncome = thisMonthIncome == null ? 0 : thisMonthIncome;

	    Double thisMonthExpense = expenseRepository.totalExpenseByUserAndMonth(userId, LocalDate.now().getMonthValue(), LocalDate.now().getYear());
	    thisMonthExpense = thisMonthExpense == null ? 0 : thisMonthExpense;

	    // This quarter
	    int currentQuarter = (LocalDate.now().getMonthValue() - 1) / 4 + 1;
	    Double qtrIncome = incomeRepository.totalIncomeByUserAndQuarter(userId, currentQuarter, LocalDate.now().getYear());
	    qtrIncome = qtrIncome == null ? 0 : qtrIncome;

	    Double qtrExpense = expenseRepository.totalExpenseByUserAndQuarter(userId, currentQuarter, LocalDate.now().getYear());
	    qtrExpense = qtrExpense == null ? 0 : qtrExpense;

	    // ================== Add to model ==================
	    model.addAttribute("thisMonthIncome", String.format("%.1f", thisMonthIncome / 1000) + "k");
	    model.addAttribute("thisMonthExpense", String.format("%.1f", thisMonthExpense / 1000) + "k");
	    model.addAttribute("qtrIncome", String.format("%.1f", qtrIncome / 1000) + "k");
	    model.addAttribute("qtrExpense", String.format("%.1f", qtrExpense / 1000) + "k");

	    model.addAttribute("pageTitle", "Home");
	    model.addAttribute("activePage", "dashboard");
	    
	    
	    userEntity loggedInUser = (userEntity) session.getAttribute("user");

	    if (loggedInUser == null) {
	        return "redirect:/login";
	    }

	    // ✅ Fetch only logged-in user data
	    List<ExpenseEntity> expenses = expenseRepository.findByUserId(loggedInUser.getUserId());
	    List<IncomeEntity> incomes = incomeRepository.findByUserId(loggedInUser.getUserId());

	    // ==========================
	    // 1. Monthly Expense
	    // ==========================
	    Map<Integer, Double> monthlyExpense = expenses.stream()
	        .collect(Collectors.groupingBy(
	            e -> e.getDate().getMonthValue(),
	            Collectors.summingDouble(ExpenseEntity::getAmount)
	        ));

	    // ==========================
	    // 2. Monthly Income
	    // ==========================
	    Map<Integer, Double> monthlyIncome = incomes.stream()
	        .collect(Collectors.groupingBy(
	            i -> i.getDate().getMonthValue(),
	            Collectors.summingDouble(IncomeEntity::getAmount)
	        ));

	    // Fill missing months
	    Map<Integer, Double> finalExpense = new TreeMap<>();
	    Map<Integer, Double> finalIncome = new TreeMap<>();

	    for (int i = 1; i <= 12; i++) {
	        finalExpense.put(i, monthlyExpense.getOrDefault(i, 0.0));
	        finalIncome.put(i, monthlyIncome.getOrDefault(i, 0.0));
	    }

	    // ==========================
	    // 3. Category-wise Expense
	    // ==========================
	    Map<Integer, String> categoryMap = categoryRepository.findAll()
	        .stream()
	        .collect(Collectors.toMap(
	            CategoryEntity::getCategoryId,
	            CategoryEntity::getCategoryName
	        ));

	    Map<String, Double> categoryData = expenses.stream()
	        .collect(Collectors.groupingBy(
	            e -> categoryMap.get(e.getCategoryId()),
	            Collectors.summingDouble(ExpenseEntity::getAmount)
	        ));

	    ObjectMapper mapper = new ObjectMapper();

	    model.addAttribute("expenseJson", mapper.writeValueAsString(finalExpense));
	    model.addAttribute("incomeJson", mapper.writeValueAsString(finalIncome));
	    model.addAttribute("categoryJson", mapper.writeValueAsString(categoryData));
		
		return "AdminDashboard";
	}

}
