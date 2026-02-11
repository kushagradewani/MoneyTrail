package com.grownited.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class StatusController {
	
	@GetMapping(value =  {"status"})
	public String status() {
		return "Status";
	}

}
