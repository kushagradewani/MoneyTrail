package com.grownited.controller;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

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
	
	// ------------------ EXPENSE ------------------

	// Edit Expense
	@GetMapping("editExpensqe")
	public String editExpense1(Integer expenseId, Model model) {
	    Optional<ExpenseEntity> opExpense = expenseRepository.findById(expenseId);

	    if(opExpense.isPresent()) {
	        model.addAttribute("expense", opExpense.get());
	        return "EditExpense";
	    } else {
	        return "redirect:/expenseList";
	    }
	}

	// Delete Expense
	@GetMapping("deleteExpense")
	public String deleteExpense(Integer expenseId) {
	    expenseRepository.deleteById(expenseId);
	    return "redirect:/expenseList";
	}

	@GetMapping("/viewExpense")
	public String viewExpense(Integer expenseId, Model model) {

		Optional<ExpenseEntity> opExpense = expenseRepository.findById(expenseId);

		if (opExpense.isEmpty()) {
			return "redirect:/expenseList";
		}

		ExpenseEntity expense = opExpense.get();

		CategoryEntity category = categoryRepository.findById(expense.getCategoryId()).orElse(null);
		SubCategoryEntity subCategory = subCategoryRepository.findById(expense.getSubCategoryId()).orElse(null);
		VenderEntity vender = venderRepository.findById(expense.getVenderId()).orElse(null);
		AccountEntity account = accountRepository.findById(expense.getInaccountId()).orElse(null);
		StatusEntity status = statusRepository.findById(expense.getStatusId()).orElse(null);

		model.addAttribute("expense", expense);
		model.addAttribute("category", category);
		model.addAttribute("subCategory", subCategory);
		model.addAttribute("vender", vender);
		model.addAttribute("account", account);
		model.addAttribute("status", status);

		return "ExpenseView";
	}
	
	
	
	// ---------------- GET EDIT EXPENSE ----------------
    @GetMapping("/editExpense")
    public String editExpense(Integer expenseId, Model model) {
        Optional<ExpenseEntity> opExpense = expenseRepository.findById(expenseId);

        if (opExpense.isEmpty()) {
            return "redirect:/expenseList";
        }

        ExpenseEntity expense = opExpense.get();

        // Pass expense and all lists for dropdowns
        model.addAttribute("expense", expense);
        model.addAttribute("categoryList", categoryRepository.findAll());
        model.addAttribute("subCategoryList", subCategoryRepository.findAll());
        model.addAttribute("venderList", venderRepository.findAll());
        model.addAttribute("accountList", accountRepository.findAll());
        model.addAttribute("statusList", statusRepository.findAll());

        return "ExpenseEdit"; // JSP page for editing expense
    }

    // ---------------- POST UPDATE EXPENSE ----------------
    @PostMapping("/updateExpense")
    public String updateExpense(
            Integer expenseId,
             String title,
             Integer categoryId,
            Integer subCategoryId,
            Integer venderId,
            Integer inaccountId,
             Integer statusId,
             Float amount,
             String date,
            String description,
            Boolean active
    ) {

        Optional<ExpenseEntity> opExpense = expenseRepository.findById(expenseId);

        if (opExpense.isPresent()) {
            ExpenseEntity expense = opExpense.get();

            // Update fields
            expense.setTitle(title);
            expense.setCategoryId(categoryId);
            expense.setSubCategoryId(subCategoryId);
            expense.setVenderId(venderId);
            expense.setInaccountId(inaccountId);
            expense.setStatusId(statusId);
            expense.setAmount(amount);
            expense.setDate(LocalDate.parse(date));
            expense.setDescription(description);
            expense.setActive(active != null && active);

            // Save updated expense
            expenseRepository.save(expense);
        }

        // Redirect to expense list after update
        return "redirect:/expenseList";
    }



}
