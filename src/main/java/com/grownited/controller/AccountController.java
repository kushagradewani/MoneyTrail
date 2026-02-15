package com.grownited.controller;

import java.util.List;

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

}
