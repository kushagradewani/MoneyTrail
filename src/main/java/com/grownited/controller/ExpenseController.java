package com.grownited.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.entity.AccountEntity;
import com.grownited.entity.CategoryEntity;
import com.grownited.entity.ExpenseEntity;
import com.grownited.entity.StatusEntity;
import com.grownited.entity.SubCategoryEntity;
import com.grownited.entity.VenderEntity;
import com.grownited.repository.AccountRepository;
import com.grownited.repository.CategoryRepository;
import com.grownited.repository.ExpenseRepository;
import com.grownited.repository.StatusRepository;
import com.grownited.repository.SubCategoryRepository;
import com.grownited.repository.VenderRepository;

@Controller
public class ExpenseController {
	
	@Autowired
	ExpenseRepository expenseRepository;
	@Autowired
	CategoryRepository categoryRepository;
	@Autowired
	SubCategoryRepository subCategoryRepository;
	@Autowired
	VenderRepository venderRepository;
	@Autowired
	AccountRepository accountRepository;
	@Autowired
	StatusRepository statusRepository;
	
	
	@GetMapping(value = {"expense"})
	public String expense(Model model) {

	    List<CategoryEntity> allCategory = categoryRepository.findAll();
	    model.addAttribute("allCategory", allCategory);

	    List<SubCategoryEntity> allSubCategory = subCategoryRepository.findAll();
	    model.addAttribute("allSubCategory", allSubCategory);

	    List<VenderEntity> allVender = venderRepository.findAll();
	    model.addAttribute("allVender", allVender);

	    List<AccountEntity> allAccount = accountRepository.findAll();
	    model.addAttribute("allAccount", allAccount);
	    
	    List<StatusEntity> allStatus = statusRepository.findAll();
	    model.addAttribute("allStatus", allStatus);

	    return "Expense";
	}

	@PostMapping("saveExpense")
	public String saveExpense(ExpenseEntity expenseEntity) {

	    expenseEntity.setActive(true);

	    expenseEntity.setCategoryId(expenseEntity.getCategoryId());
	    expenseEntity.setSubCategoryId(expenseEntity.getSubCategoryId());
	    expenseEntity.setVenderId(expenseEntity.getVenderId());
	    expenseEntity.setInaccountId(expenseEntity.getInaccountId());
	    expenseEntity.setStatusId(expenseEntity.getStatusId());

	    expenseRepository.save(expenseEntity);

	    return "redirect:/expenseList";
	}
	@GetMapping(value = {"expenseList"})
	public String expenseList(Model model) {

	    List<CategoryEntity> categoryList = categoryRepository.findAll();
	    model.addAttribute("categoryList", categoryList);

	    List<SubCategoryEntity> subCategoryList = subCategoryRepository.findAll();
	    model.addAttribute("subCategoryList", subCategoryList);

	    List<VenderEntity> venderList = venderRepository.findAll();
	    model.addAttribute("venderList", venderList);

	    List<AccountEntity> accountList = accountRepository.findAll();
	    model.addAttribute("accountList", accountList);

	    List<ExpenseEntity> expenseList = expenseRepository.findAll();
	    model.addAttribute("expenseList", expenseList);
	    
	    List<StatusEntity> statusList = statusRepository.findAll();
	    model.addAttribute("statusList", statusList);

	    return "ExpenseList";
	}



}
