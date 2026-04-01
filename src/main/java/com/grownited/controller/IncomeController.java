package com.grownited.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.entity.AccountEntity;
import com.grownited.entity.IncomeEntity;
import com.grownited.entity.StatusEntity;
import com.grownited.entity.userEntity;
import com.grownited.repository.AccountRepository;
import com.grownited.repository.IncomeRepository;
import com.grownited.repository.StatusRepository;

import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

@Transactional
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
	public String saveExpense(IncomeEntity incomeEntity,HttpSession session) {

		userEntity loggedUser = (userEntity) session.getAttribute("user");
        if (loggedUser == null) return "redirect:/login";

        incomeEntity.setUserId(loggedUser.getUserId()); // link income to user
		
		incomeEntity.setActive(true);
		
	    incomeEntity.setInaccountId(incomeEntity.getInaccountId());
	    incomeEntity.setStatusId(incomeEntity.getStatusId());
	    
	    // Fetch account
	    Optional<AccountEntity> opAccount = accountRepository.findById(incomeEntity.getInaccountId());

	    if (opAccount.isPresent()) {
	        AccountEntity account = opAccount.get();

	        // Debug (optional)
	        System.out.println("Income added to: " + account.getTitle());

	        // Add amount
	        account.setAmount(account.getAmount() + incomeEntity.getAmount());

	        accountRepository.save(account);
	    }

	    incomeRepository.save(incomeEntity);

	    return "redirect:/incomeList";
	}
	
	@GetMapping(value = {"incomeList"})
	public String expenseList(Model model, HttpSession session) {
        userEntity loggedUser = (userEntity) session.getAttribute("user");
        if (loggedUser == null) return "redirect:/login";

        List<IncomeEntity> incomeList = incomeRepository.findByUserId(loggedUser.getUserId());

        model.addAttribute("incomeList", safeList(incomeList));
        model.addAttribute("accountList", safeList(accountRepository.findAll()));
        model.addAttribute("statusList", safeList(statusRepository.findAll()));
        model.addAttribute("user", loggedUser);

	    return "IncomeList";
	}
	
	// ------------------ INCOME ------------------

	// Edit Income
	/*
	 * @GetMapping("editIncome") public String editIncome1(Integer incomeId, Model
	 * model) { Optional<IncomeEntity> opIncome =
	 * incomeRepository.findById(incomeId);
	 * 
	 * if(opIncome.isPresent()) { model.addAttribute("income", opIncome.get());
	 * return "EditIncome"; } else { return "redirect:/incomeList"; } }
	 */


	// Delete Income
	@GetMapping("deleteIncome")
	public String deleteIncome(Integer incomeId) {
	    incomeRepository.deleteById(incomeId);
	    return "redirect:/incomeList";
	}


	// ---------------- VIEW INCOME ----------------
	@GetMapping("/viewIncome")
	public String viewIncome(Integer incomeId, Model model) {

	    Optional<IncomeEntity> opIncome = incomeRepository.findById(incomeId);

	    if (opIncome.isEmpty()) {
	        return "redirect:/incomeList";
	    }

	    IncomeEntity income = opIncome.get();

	    AccountEntity account = accountRepository.findById(income.getInaccountId()).orElse(null);
	    StatusEntity status = statusRepository.findById(income.getStatusId()).orElse(null);

	    model.addAttribute("income", income);
	    model.addAttribute("account", account);
	    model.addAttribute("status", status);

	    return "IncomeView";
	}



	// ---------------- GET EDIT INCOME ----------------
	@GetMapping("/editIncome")
	public String editIncome(Integer incomeId, Model model) {

	    Optional<IncomeEntity> opIncome = incomeRepository.findById(incomeId);

	    if (opIncome.isEmpty()) {
	        return "redirect:/incomeList";
	    }

	    IncomeEntity income = opIncome.get();

	    // Send income + dropdown lists
	    model.addAttribute("income", income);
	    model.addAttribute("accountList", accountRepository.findAll());
	    model.addAttribute("statusList", statusRepository.findAll());

	    return "IncomeEdit";
	}



	// ---------------- POST UPDATE INCOME ----------------
	@PostMapping("/updateIncome")
	public String updateIncome(
	        Integer incomeId,
	        String title,
	        Integer inaccountId,
	        Integer statusId,
	        Float amount,
	        String date,
	        String description,
	        Boolean active
	) {

	    Optional<IncomeEntity> opIncome = incomeRepository.findById(incomeId);

	    if (opIncome.isPresent()) {

	        IncomeEntity income = opIncome.get();

	        // Update fields
	        income.setTitle(title);
	        income.setInaccountId(inaccountId);
	        income.setStatusId(statusId);
	        income.setAmount(amount);
	        income.setDate(LocalDate.parse(date));
	        income.setDescription(description);
	        income.setActive(active != null && active);

	        // Save
	        incomeRepository.save(income);
	    }

	    return "redirect:/incomeList";
	}
	
	private <T> List<T> safeList(List<T> list) {
        return list != null ? list : new ArrayList<>();
    }

}
