package com.grownited.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.entity.AccountEntity;
import com.grownited.repository.AccountRepository;

@Controller
public class AccountController {
	
	@Autowired
	AccountRepository accountRepository;
	
	@GetMapping(value =  {"account"})
	public String account() {
		return "Account";
	}
	
	@GetMapping(value = {"accountList"})
	public String accountList(Model model) {
		List<AccountEntity> accountList = accountRepository.findAll();
		model.addAttribute("accountList",accountList);
		return "AccountList";
	}
	@PostMapping("saveAccount")
	public String saveAccount(AccountEntity accountEntity) {
		accountEntity.setActive(true);
		accountRepository.save(accountEntity); 
		return "redirect:/accountList";
	}
	
	// ------------------ ACCOUNT ------------------

	// Edit Account
	/*
	 * @GetMapping("editAccount") public String editAccount(Integer accountId, Model
	 * model) { Optional<AccountEntity> opAccount =
	 * accountRepository.findById(accountId);
	 * 
	 * if(opAccount.isPresent()) { model.addAttribute("account", opAccount.get());
	 * return "EditAccount"; } else { return "redirect:/accountList"; } }
	 */

	// Delete Account
	@GetMapping("deleteAccount")
	public String deleteAccount(Integer accountId) {
	    accountRepository.deleteById(accountId);
	    return "redirect:/accountList";
	}
	
	// ---------------- GET EDIT ACCOUNT ----------------
	@GetMapping("/editAccount")
	public String editAccount(Integer inaccountId, Model model) {

	    Optional<AccountEntity> opAccount = accountRepository.findById(inaccountId);

	    if (opAccount.isEmpty()) {
	        return "redirect:/accountList";
	    }

	    AccountEntity account = opAccount.get();
	    model.addAttribute("account", account);

	    return "AccountEdit";
	}

	// ---------------- POST UPDATE ACCOUNT ----------------
	@PostMapping("/updateAccount")
	public String updateAccount(
	        Integer inaccountId,
	        String title,
	        Float amount,
	        Boolean exDefault,
	        Boolean active
	) {
	    Optional<AccountEntity> opAccount = accountRepository.findById(inaccountId);

	    if (opAccount.isPresent()) {
	    	AccountEntity account = opAccount.get();
	        account.setTitle(title);
	        account.setAmount(amount);
	        account.setExDefault(exDefault != null && exDefault);
	        account.setActive(active != null && active);

	        accountRepository.save(account);
	    }

	    return "redirect:/accountList";
	}

}
