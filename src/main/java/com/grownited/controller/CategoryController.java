package com.grownited.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.entity.CategoryEntity;
import com.grownited.entity.SubCategoryEntity;
import com.grownited.repository.CategoryRepository;
import com.grownited.repository.SubCategoryRepository;

@Controller
public class CategoryController {
	
	@Autowired
	CategoryRepository categoryRepository;
	@Autowired
	SubCategoryRepository subCategoryRepository;

	@GetMapping(value =  {"category"})
	public String category() {
		return "Category";
	}
	
	@GetMapping(value = {"subCategory"})
	public String subCategory() {
		return "SubCategory";
	}
	
	@PostMapping("saveCategory")
	public String saveCategory(CategoryEntity categoryEntity) {
		categoryEntity.setActive(true);
		categoryRepository.save(categoryEntity); 
		return "Vender";
	}
	
	@PostMapping("saveSubCategory")
	public String saveCategory(SubCategoryEntity subCategoryEntity) {
		subCategoryEntity.setActive(true);
		subCategoryRepository.save(subCategoryEntity); 
		return "Vender";
	}
	
	@GetMapping("categoryList")
	public String categoryList(Model model) {
		List<CategoryEntity> categoryList = categoryRepository.findAll();
		model.addAttribute("categoryList",categoryList);
		
		return "CategoryList";
	}
	
}
