package com.grownited.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AccountController {
	
	@GetMapping(value =  {"account"})
	public String account() {
		return "Account";
	}

}
