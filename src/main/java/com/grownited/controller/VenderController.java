package com.grownited.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.entity.VenderEntity;
import com.grownited.repository.VenderRepository;

@Controller
public class VenderController {
	
	@Autowired
	VenderRepository venderRepository;
	
	@GetMapping(value =  {"vender"})
	public String vender() {
		return "Vender";
	}
	
	@PostMapping("saveVender")
	public String saveVender(VenderEntity venderEntity) {
		venderEntity.setActive(true);
		venderRepository.save(venderEntity); 
		return "redirect:/venderList";
	}
	
	@GetMapping(value = {"venderList"})
	public String venderList(Model model) {
		List<VenderEntity> venderList = venderRepository.findAll();
		model.addAttribute("venderList",venderList);
		return "VenderList";
	}
	
	@GetMapping("deleteVender")
	public String deleteVender(Integer venderId) {
		venderRepository.deleteById(venderId);
		
		return "redirect:/VenderList";//do not open jsp , open another url -> listHackathon
	}
	
}
