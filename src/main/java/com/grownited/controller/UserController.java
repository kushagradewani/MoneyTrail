package com.grownited.controller;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.entity.userEntity;
import com.grownited.repository.UserRepository;
@Controller
public class UserController {
	
	@Autowired
	UserRepository userRepository;
	
	@GetMapping(value =  {"user"})
	public String user() {
		return "User"; //jsp name
	}
	
	@PostMapping("addUser")
	public String register(userEntity userEntity) {
		userEntity.setRole("Customer");
		userEntity.setActive(true);
		userEntity.setCreatedAt(LocalDate.now());
		
		userRepository.save(userEntity);
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
