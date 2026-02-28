package com.grownited.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.grownited.repository.ExpenseRepository;
import com.grownited.repository.IncomeRepository;

@Controller
public class DashboardController {
	
	@Autowired
	IncomeRepository incomeRepository;
	
	@Autowired
	ExpenseRepository expenseRepository;
	
	@GetMapping(value =  {"adminDashboard","/"})
	public String adminDashboard(Model model) {
		
		Double totalIncome = incomeRepository.totalIncome();
	    totalIncome = totalIncome == null ? 0 : totalIncome;

	    Double totalExpense = expenseRepository.totalExpense();
	    totalExpense = totalExpense == null ? 0 : totalExpense;

	    Double todayExpense = expenseRepository.todayExpense();
	    todayExpense = todayExpense == null ? 0 : todayExpense;

	    Double netProfit = totalIncome - totalExpense;

	    model.addAttribute("totalIncome",
	        String.format("%.1f", totalIncome / 1000) + "k");

	    model.addAttribute("totalExpense",
	        String.format("%.1f", totalExpense / 1000) + "k");

	    model.addAttribute("netProfit",
	        String.format("%.1f", netProfit / 1000) + "k");

	    model.addAttribute("todayExpense",
	        String.format("%.1f", todayExpense / 1000) + "k");


		
		return "AdminDashboard";
	}

}
