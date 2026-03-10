package com.grownited.controller;

import java.util.List;
import java.util.Optional;

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
public class SubCategoryController {
	
	@Autowired
	SubCategoryRepository subCategoryRepository;
	
	@Autowired
	CategoryRepository categoryRepository;
	
	@GetMapping(value =  {"subcategory"})
	public String subCatecory() {
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
	
	// ------------------ SUB CATEGORY ------------------

	// Edit SubCategory
	/*
	 * @GetMapping("editSubCategory") public String editSubCategory(Integer
	 * subCategoryId, Model model) { Optional<SubCategoryEntity> opSubCategory =
	 * subCategoryRepository.findById(subCategoryId);
	 * 
	 * if(opSubCategory.isPresent()) { model.addAttribute("subCategory",
	 * opSubCategory.get()); return "EditSubCategory"; } else { return
	 * "redirect:/subCategoryList"; } }
	 */

	// Delete SubCategory
	@GetMapping("deleteSubCategory")
	public String deleteSubCategory(Integer subCategoryId) {
	    subCategoryRepository.deleteById(subCategoryId);
	    return "redirect:/subCategoryList";//do not open jsp , open another url -> listHackathon
	}
	
	// ---------------- GET EDIT SUBCATEGORY ----------------
	@GetMapping("/editSubCategory")
	public String editSubCategory(Integer subCategoryId, Model model) {

	    Optional<SubCategoryEntity> opSub = subCategoryRepository.findById(subCategoryId);

	    if (opSub.isEmpty()) {
	        return "redirect:/subCategoryList";
	    }

	    SubCategoryEntity subCategory = opSub.get();
	    model.addAttribute("subCategory", subCategory);
	    model.addAttribute("categoryList", categoryRepository.findAll()); // For dropdown

	    return "SubCategoryEdit";
	}

	// ---------------- POST UPDATE SUBCATEGORY ----------------
	@PostMapping("/updateSubCategory")
	public String updateSubCategory(
	        Integer subCategoryId,
	        String subCategoryName,
	        Integer categoryId,
	        Boolean active
	) {
	    Optional<SubCategoryEntity> opSub = subCategoryRepository.findById(subCategoryId);

	    if (opSub.isPresent()) {
	    	SubCategoryEntity subCategory = opSub.get();
	        subCategory.setSubCategoryName(subCategoryName);
	        subCategory.setCategoryId(categoryId);
	        subCategory.setActive(active != null && active);

	        subCategoryRepository.save(subCategory);
	    }

	    return "redirect:/subCategoryList";
	}

}
