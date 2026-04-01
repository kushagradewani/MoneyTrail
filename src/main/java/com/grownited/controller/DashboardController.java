package com.grownited.controller;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.grownited.entity.userEntity;
import com.grownited.repository.ExpenseRepository;
import com.grownited.repository.IncomeRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class DashboardController {
	
	@Autowired
	IncomeRepository incomeRepository;
	
	@Autowired
	ExpenseRepository expenseRepository;
	
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
	    int currentQuarter = (LocalDate.now().getMonthValue() - 1) / 3 + 1;
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
		
		return "AdminDashboard";
	}

}
