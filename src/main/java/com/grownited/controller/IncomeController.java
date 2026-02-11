package com.grownited.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class IncomeController {
	
	@GetMapping(value =  {"income"})
	public String income() {
		return "Income";
	}

}
