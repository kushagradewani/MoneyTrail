package com.grownited.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class SubCategoryController {
	
	@GetMapping(value =  {"subcategory"})
	public String subCatecory() {
		return "SubCategory";
	}

}
