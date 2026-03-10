package com.grownited.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.cloudinary.Cloudinary;
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
	
	@Autowired
	Cloudinary cloudinary;
	
	@GetMapping("/signup")
	public String openSignUpPage() {
		return "SignUp"; //jsp name
	}
	
	@GetMapping("/Home")
	public String openHome(Model model) {
	    model.addAttribute("pageTitle", "Home");
	    model.addAttribute("activePage", "dashboard");
	    return "User/pages/Home";
	}
	
	@GetMapping("/login")
	public String openLoginPage() {
		return "Login";
	}
	
	@PostMapping("/authenticate")
	public String authenticate(String email,
	                           String password,
	                           Model model,
	                           HttpSession session) {

	    Optional<userEntity> op = userRepository.findByEmail(email);

	    if (op.isPresent()) {

	        userEntity dbUser = op.get();

	        // 🔐 Check encrypted password correctly
	        if (passwordEncoder.matches(password, dbUser.getPassword())) {

	            session.setAttribute("user", dbUser);

	            if (dbUser.getRole().equals("ADMIN")) {
	                return "redirect:/adminDashboard";
	            }
	            else if (dbUser.getRole().equals("USER")) {
	                return "redirect:/user-dashboard";
	            }
	        }
	    }

	    model.addAttribute("error", "Invalid Credentials");
	    return "Login";
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
	
	// ================= CHANGE PASSWORD =================
    @PostMapping("/changePassword")
    public String changePassword(@RequestParam String email,
                                 @RequestParam String newPassword) {

        Optional<userEntity> optional = userRepository.findByEmail(email);

        if (optional.isPresent()) {
            userEntity user = optional.get();

            // Encrypt password
            String encodedPassword = passwordEncoder.encode(newPassword);
            user.setPassword(encodedPassword);

            userRepository.save(user);

            mailService.sendPasswordSuccessMail(user);
        }

        return "Login";
    }


    // ================= VERIFY OTP =================
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


    // ================= RESET PASSWORD =================
    @PostMapping("/resetPassword")
    public String resetPassword(@RequestParam String email,
                                @RequestParam String newPassword,
                                @RequestParam String confirmPassword,
                                Model model) {

        if (!newPassword.equals(confirmPassword)) {
            model.addAttribute("error", "Passwords do not match");
            model.addAttribute("email", email);
            return "ResetPassword";
        }

        Optional<userEntity> optional = userRepository.findByEmail(email);

        if (optional.isPresent()) {
            userEntity user = optional.get();

            // Encrypt password before saving
            String encodedPassword = passwordEncoder.encode(newPassword);
            user.setPassword(encodedPassword);

            userRepository.save(user);
        }

        return "login";
    }
	
	@PostMapping("/register")
	public String register(userEntity userEntity,MultipartFile profilePic) throws IOException {		
		userEntity.setRole("USER");
		userEntity.setActive(true);
		userEntity.setCreatedAt(LocalDate.now());
		
		//Encode Password
		String encodedPasswordString = passwordEncoder.encode(userEntity.getPassword());
		userEntity.setPassword(encodedPasswordString);
		
		try {
			Map  map = 	cloudinary.uploader().upload(profilePic.getBytes(), null);
			String profilePicURL = map.get("secure_url").toString();
			System.out.println(profilePicURL);
			userEntity.setProfilePicURL(profilePicURL);
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		userRepository.save(userEntity);
		
		//Welcome mail Sender
		mailService.sendWelcomeMail(userEntity);

		return "Login";
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "Login";
	}
}
