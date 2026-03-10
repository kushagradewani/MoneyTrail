package com.grownited.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.entity.CategoryEntity;
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
	
	// ------------------ CATEGORY ------------------

	/*
	 * // Edit Category
	 * 
	 * @GetMapping("editCategory") public String editCategory(Integer categoryId,
	 * Model model) { Optional<CategoryEntity> opCategory =
	 * categoryRepository.findById(categoryId);
	 * 
	 * if(opCategory.isPresent()) { model.addAttribute("category",
	 * opCategory.get()); return "EditCategory"; } else { return
	 * "redirect:/categoryList"; } }
	 */

	// Delete Category
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
	
	// ---------------- GET EDIT CATEGORY ----------------
	@GetMapping("/editCategory")
	public String editCategory(Integer categoryId, Model model) {

	    Optional<CategoryEntity> opCategory = categoryRepository.findById(categoryId);

	    if (opCategory.isEmpty()) {
	        return "redirect:/categoryList";
	    }

	    CategoryEntity category = opCategory.get();
	    model.addAttribute("category", category);

	    return "CategoryEdit";
	}

	// ---------------- POST UPDATE CATEGORY ----------------
	@PostMapping("/updateCategory")
	public String updateCategory(
	        Integer categoryId,
	        String categoryName,
	        Boolean active
	) {
	    Optional<CategoryEntity> opCategory = categoryRepository.findById(categoryId);

	    if (opCategory.isPresent()) {
	        CategoryEntity category = opCategory.get();
	        category.setCategoryName(categoryName);
	        category.setActive(active != null && active);

	        categoryRepository.save(category);
	    }

	    return "redirect:/categoryList";
	}
	
	
}
