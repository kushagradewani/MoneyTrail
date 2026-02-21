package com.grownited.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.entity.AccountEntity;
import com.grownited.entity.IncomeEntity;
import com.grownited.entity.StatusEntity;
import com.grownited.repository.AccountRepository;
import com.grownited.repository.IncomeRepository;
import com.grownited.repository.StatusRepository;

@Controller
public class IncomeController {
	
	@Autowired
	IncomeRepository incomeRepository;
	@Autowired
	AccountRepository accountRepository;
	@Autowired
	StatusRepository statusRepository;
	
	@GetMapping(value =  {"income"})
	public String income(Model model) {
		
		List<AccountEntity> allAccount = accountRepository.findAll();
	    model.addAttribute("allAccount", allAccount);
	    
	    List<StatusEntity> allStatus = statusRepository.findAll();
	    model.addAttribute("allStatus", allStatus);
	    
		return "Income";
	}
	
	@PostMapping("saveIncome")
	public String saveExpense(IncomeEntity incomeEntity) {

		incomeEntity.setActive(true);
		
	    incomeEntity.setInaccountId(incomeEntity.getInaccountId());
	    incomeEntity.setStatusId(incomeEntity.getStatusId());

	    incomeRepository.save(incomeEntity);

	    return "redirect:/incomeList";
	}
	
	@GetMapping(value = {"incomeList"})
	public String expenseList(Model model) {
		
		List<IncomeEntity> incomeList = incomeRepository.findAll();
		model.addAttribute("incomeList", incomeList);

	    List<AccountEntity> accountList = accountRepository.findAll();
	    model.addAttribute("accountList", accountList);
	    
	    List<StatusEntity> statusList = statusRepository.findAll();
	    model.addAttribute("statusList", statusList);

	    return "IncomeList";
	}

}
