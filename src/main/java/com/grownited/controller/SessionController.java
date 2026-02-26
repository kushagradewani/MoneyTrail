package com.grownited.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.grownited.entity.userEntity;
import com.grownited.repository.UserRepository;
import com.grownited.service.MailService;
import com.grownited.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class SessionController {
	
	@Autowired
	UserRepository userRepository;
	
	@Autowired
	MailService mailService;
	
	@Autowired
	UserService userService;
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
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
	
	@PostMapping("/sendOtp")
	public String sendOtp(@RequestParam String email) {
	    userService.generateAndSendOtp(email);
	    return "ForgetPassword";
	}
	
	@PostMapping("/ResetPassword")
	public String verifyOtp(@RequestParam String email,
	                        @RequestParam String otp,
	                        Model model) {

	    if (userService.verifyOtp(email, otp)) {
	        model.addAttribute("email", email);
	        return "ResetPassword";
	    }

	    return "ForgetPassword";
	}
	
	@PostMapping("/changePassword")
	public String changePassword(@RequestParam String email,
	                             @RequestParam String newPassword) {

	    Optional<userEntity> optional = userRepository.findByEmail(email);

	    if (optional.isPresent()) {
	        userEntity user = optional.get();
	        user.setPassword(newPassword);
	        userRepository.save(user);

	        mailService.sendPasswordSuccessMail(user); // send after change
	    }

	    return "Login";
	}
	
	@PostMapping("/resetPassword")
	public String resetPassword(@RequestParam String email,
	                            @RequestParam String newPassword,
	                            @RequestParam String confirmPassword) {

	    if (newPassword.equals(confirmPassword)) {
	        userService.resetPassword(email, newPassword);
	        return "login";
	    }

	    return "ResetPassword";
	}
	
	@PostMapping("/register")
	public String register(userEntity userEntity) throws IOException {		
		userEntity.setRole("USER");
		userEntity.setActive(true);
		userEntity.setCreatedAt(LocalDate.now());
		
		//Encode Password
		String encodedPasswordString = passwordEncoder.encode(userEntity.getPassword());
		userEntity.setPassword(encodedPasswordString);
		
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
