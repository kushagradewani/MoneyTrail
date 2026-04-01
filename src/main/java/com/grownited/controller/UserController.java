package com.grownited.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import com.cloudinary.Cloudinary;
import com.grownited.entity.userEntity;
import com.grownited.repository.UserRepository;
import com.grownited.service.MailService;
@Controller
public class UserController {
	
	@Autowired
	UserRepository userRepository;
	
	@Autowired
	MailService mailService;
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@Autowired
	Cloudinary cloudinary;
	
	@GetMapping(value =  {"user"})
	public String user() {
		return "User"; //jsp name
	}
	
	@PostMapping("addUserAdmin")
	public String register(userEntity userEntity,MultipartFile profilePic) {
		userEntity.setActive(true);
		userEntity.setCreatedAt(LocalDate.now());
		
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
		
		if ("ADMIN".equalsIgnoreCase(userEntity.getRole())) {
	        mailService.sendAdminWelcomeMail(userEntity);
	    } else {
	        mailService.sendUserWelcomeMail(userEntity);
	    }
		
		return "redirect:/userList";
	}
	@GetMapping(value = {"userList"})
	public String userList(Model model) {
		List<userEntity> userList = userRepository.findAll();
		model.addAttribute("userList",userList);
		return "UserList";
	}
	
	@GetMapping("viewUser")
	public String viewUser(Integer userId, Model model) {
		// read userId
		// select * from users where userId = rock?
		Optional<userEntity> opUser = userRepository.findById(userId);
		if (opUser.isEmpty()) {
			// error set
			// list redirect
			return "";
		} else {

			userEntity userEntity = opUser.get();

			model.addAttribute("user", userEntity);
			return "ViewUser";
		}

	}
	
	// ------------------ EDIT USER ------------------
	@GetMapping("editUser")
	public String editUser(Integer userId, Model model) {
	    Optional<userEntity> opUser = userRepository.findById(userId);

	    if (opUser.isPresent()) {
	        model.addAttribute("user", opUser.get());
	        return "EditUser";
	    } else {
	        return "redirect:/userList";
	    }
	}

    // ------------------ DELETE USER ------------------
    @GetMapping("deleteUser")
    public String deleteUser(Integer userId) {
        userRepository.deleteById(userId);
        return "redirect:/userList";
    }

}
