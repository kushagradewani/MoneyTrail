package com.grownited.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class VenderController {
	
	@GetMapping(value =  {"/vender"})
	public String vender() {
		return "Vender";
	}

	@GetMapping(value = {"/venderList"})
	public String venderList() {
		return "VenderList";
	}
}
