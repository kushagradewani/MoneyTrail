package com.grownited.controller;

import java.util.List;
import java.util.Optional;

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
	
	// ------------------ VENDER ------------------

	// Edit Vender
	/*
	 * @GetMapping("editVender") public String editVender(Integer venderId, Model
	 * model) { Optional<VenderEntity> opVender =
	 * venderRepository.findById(venderId);
	 * 
	 * if(opVender.isPresent()) { model.addAttribute("vender", opVender.get());
	 * return "EditVender"; } else { return "redirect:/venderList"; } }
	 */

	// Delete Vender
	@GetMapping("deleteVender")
	public String deleteVender(Integer venderId) {
	    venderRepository.deleteById(venderId);
	    return "redirect:/venderList";//do not open jsp , open another url -> listHackathon
	}
	
	// ---------------- GET EDIT VENDER ----------------
	@GetMapping("/editVender")
	public String editVender(Integer venderId, Model model) {

	    Optional<VenderEntity> opVender = venderRepository.findById(venderId);

	    if (opVender.isEmpty()) {
	        return "redirect:/venderList";
	    }

	    VenderEntity vender = opVender.get();
	    model.addAttribute("vender", vender);

	    return "VenderEdit";
	}

	// ---------------- POST UPDATE VENDER ----------------
	@PostMapping("/updateVender")
	public String updateVender(
	        Integer venderId,
	        String venderName,
	        Boolean active
	) {
	    Optional<VenderEntity> opVender = venderRepository.findById(venderId);

	    if (opVender.isPresent()) {
	    	VenderEntity vender = opVender.get();
	        vender.setVenderName(venderName);
	        vender.setActive(active != null && active);

	        venderRepository.save(vender);
	    }

	    return "redirect:/venderList";
	}
}
