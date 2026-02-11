package com.grownited.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ExpenseController {
	
	@GetMapping(value =  {"expense"})
	public String expense() {
		return "Expense";
	}

}
