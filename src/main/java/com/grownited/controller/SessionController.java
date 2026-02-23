package com.grownited.controller;

import java.time.LocalDate;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.entity.userEntity;
import com.grownited.repository.UserRepository;
import com.grownited.service.MailService;

import jakarta.servlet.http.HttpSession;

@Controller
public class SessionController {
	
	@Autowired
	UserRepository userRepository;
	
	@Autowired
	MailService mailService;
	
	@GetMapping("/signup")
	public String openSignUpPage() {
		return "SignUp"; //jsp name
	}
	
	@GetMapping("/login")
	public String openLoginPage() {
		return "Login";
	}
	
	@PostMapping("/authenticate")
	public String authenticate(String email,String password,Model model,HttpSession session) {
		Optional<userEntity> op = userRepository.findByEmail(email);
		
		if(op.isPresent()) {
			userEntity dbUser = op.get();
			session.setAttribute("user", dbUser);
			if(dbUser.getPassword().equals(password)) {
				if(dbUser.getRole().equals("ADMIN")) {
					return "redirect:/adminDashboard";
				}
				else if(dbUser.getRole().equals("USER")) {
					return "redirect:/user-dashboard";
				}
				else {
					return "Login";
				}
			}
		}
		
		model.addAttribute("error", "Invalid Credentials");
		return"Login";
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
		
		//Welcome mail Sender
		mailService.sendWelcomeMail(userEntity);

		return "Login";
	}
	
	@GetMapping("/logout")
	public String logoyut(HttpSession session) {
		session.invalidate();
		return "Login";
	}
}
