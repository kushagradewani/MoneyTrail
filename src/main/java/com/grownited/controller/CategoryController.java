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
	
	@PostMapping("saveCategory")
	public String saveCategory(CategoryEntity categoryEntity) {
		categoryEntity.setActive(true);
		categoryRepository.save(categoryEntity); 
		return "redirect:/categoryList";
	}
	@GetMapping(value = {"categoryList"})
	public String categoryList(Model model) {
		List<CategoryEntity> categoryList = categoryRepository.findAll();
		model.addAttribute("categoryList",categoryList);
		return "CategoryList";
	}
	@GetMapping("deleteCategory")
	public String deleteCategory(Integer categoryId) {
		categoryRepository.deleteById(categoryId);
		
		return "redirect:/categoryList";//do not open jsp , open another url -> listHackathon
	}
	
	@GetMapping(value = {"subCategory"})
	public String subCategory(Model model) {
		List<CategoryEntity> allCategory = categoryRepository.findAll();
		model.addAttribute("allCategory",allCategory);
		return "SubCategory";
	}	
	
	@PostMapping("saveSubCategory")
	public String saveCategory(SubCategoryEntity subCategoryEntity,CategoryEntity categoryEntity) {
		subCategoryEntity.setActive(true);
		subCategoryEntity.setCategoryId(subCategoryEntity.getCategoryId());
		subCategoryRepository.save(subCategoryEntity); 
		return "redirect:/subCategoryList";
	}
	@GetMapping(value = {"subCategoryList"})
	public String subCategoryList(Model model) {
		List<CategoryEntity> categoryList = categoryRepository.findAll();
		model.addAttribute("categoryList",categoryList);
		List<SubCategoryEntity> subCategoryList = subCategoryRepository.findAll();
		model.addAttribute("subCategoryList",subCategoryList);
		return "SubCategoryList";
	}
	@GetMapping("deleteSubCategory")
	public String deleteSubCategory(Integer subCategoryId) {
		subCategoryRepository.deleteById(subCategoryId);
		
		return "redirect:/subCategoryList";//do not open jsp , open another url -> listHackathon
	}
	
	
	
}
