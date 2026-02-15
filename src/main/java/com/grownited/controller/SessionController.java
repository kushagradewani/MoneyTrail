package com.grownited.controller;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.entity.userEntity;
import com.grownited.repository.UserRepository;

@Controller
public class SessionController {
	
	@Autowired
	UserRepository userRepository;
	
	@GetMapping("/signup")
	public String openSignUpPage() {
		return "SignUp"; //jsp name
	}
	
	@GetMapping("/login")
	public String openLoginPage() {
		return "Login";
	}
	
	@GetMapping("/forgetpassword")
	public String openForgetPassword() {
		return "ForgetPassword";
	}
	
	@PostMapping("/register")
	public String register(userEntity userEntity) {		
		userEntity.setRole("Customer");
		userEntity.setActive(true);
		userEntity.setCreatedAt(LocalDate.now());
		
		userRepository.save(userEntity);

		return "Login";
	}
}
