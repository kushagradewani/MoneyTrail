package com.grownited.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.TreeMap;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.cloudinary.Cloudinary;
import com.grownited.entity.AccountEntity;
import com.grownited.entity.CategoryEntity;
import com.grownited.entity.ExpenseEntity;
import com.grownited.entity.IncomeEntity;
import com.grownited.entity.userEntity;
import com.grownited.repository.AccountRepository;
import com.grownited.repository.CategoryRepository;
import com.grownited.repository.ExpenseRepository;
import com.grownited.repository.IncomeRepository;
import com.grownited.repository.UserRepository;
import com.grownited.service.MailService;
import com.grownited.service.UserService;

import jakarta.servlet.http.HttpSession;
import tools.jackson.databind.ObjectMapper;

@Controller
public class SessionController {
	
	@Autowired
	UserRepository userRepository;
	
	@Autowired 
	AccountRepository accountRepository;
	
	@Autowired
	MailService mailService;
	
	@Autowired
	UserService userService;
	
	@Autowired
	PasswordEncoder passwordEncoder;
	
	@Autowired
	IncomeRepository incomeRepository;
	
	@Autowired
	ExpenseRepository expenseRepository;
	
	@Autowired
	CategoryRepository categoryRepository;
	
	@Autowired
	Cloudinary cloudinary;
	
	@GetMapping("/signup")
	public String openSignUpPage() {
		return "SignUp"; //jsp name
	}
	
	 // =========================
    // 👉 OPEN PROFILE PAGE
    // =========================
    @GetMapping("/adminProfile")
    public String adminProfile(HttpSession session, Model model) {

        userEntity user = (userEntity) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        }

        // fresh data from DB (important)
        Optional<userEntity> op = userRepository.findById(user.getUserId());

        if (op.isPresent()) {
            session.setAttribute("user", op.get());
        }

        return "AdminProfile"; // JSP name
    }

    // =========================
    // 👉 UPDATE PROFILE
    // =========================
    @PostMapping("/updateAdmin")
    public String updateUser(userEntity User,MultipartFile profilePic,
                             HttpSession session) throws IOException {

    	userEntity sessionUser = (userEntity) session.getAttribute("user");

        if (sessionUser == null) {
            return "redirect:/login";
        }

        // Fetch original user from DB
        userEntity dbUser = userRepository.findById(sessionUser.getUserId()).get();

        // ===== Update Fields =====
        dbUser.setFirstName(User.getFirstName());
        dbUser.setLastName(User.getLastName());
        dbUser.setEmail(User.getEmail());
        dbUser.setGender(User.getGender());
        dbUser.setBirthYear(User.getBirthYear());
        dbUser.setContactNum(User.getContactNum());

        // ===== Handle Image Upload =====
        try {
			Map  map = 	cloudinary.uploader().upload(profilePic.getBytes(), null);
			String profilePicURL = map.get("secure_url").toString();
			System.out.println(profilePicURL);
			dbUser.setProfilePicURL(profilePicURL);
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

        // Save updated user
        userRepository.save(dbUser);

        // Update session
        session.setAttribute("user", dbUser);

        return "redirect:/adminProfile";
    }
	
	@GetMapping("/Home")
	public String openHome(Model model, HttpSession session) {

	    // Get the logged-in user from session
	    userEntity loggedUser = (userEntity) session.getAttribute("user");
	    if (loggedUser == null) {
	        return "redirect:/login";
	    }
	    Integer userId = loggedUser.getUserId();

	    // ================== Calculate amounts ==================
	    // This month
	    Double thisMonthIncome = incomeRepository.totalIncomeByUserAndMonth(userId, LocalDate.now().getMonthValue(), LocalDate.now().getYear());
	    thisMonthIncome = thisMonthIncome == null ? 0 : thisMonthIncome;

	    Double thisMonthExpense = expenseRepository.totalExpenseByUserAndMonth(userId, LocalDate.now().getMonthValue(), LocalDate.now().getYear());
	    thisMonthExpense = thisMonthExpense == null ? 0 : thisMonthExpense;

	    // This quarter
	    int currentQuarter = (LocalDate.now().getMonthValue() - 1) / 4 + 1;
	    Double qtrIncome = incomeRepository.totalIncomeByUserAndQuarter(userId, currentQuarter, LocalDate.now().getYear());
	    qtrIncome = qtrIncome == null ? 0 : qtrIncome;

	    Double qtrExpense = expenseRepository.totalExpenseByUserAndQuarter(userId, currentQuarter, LocalDate.now().getYear());
	    qtrExpense = qtrExpense == null ? 0 : qtrExpense;

	    // ================== Add to model ==================
	    model.addAttribute("thisMonthIncome", String.format("%.1f", thisMonthIncome / 1000) + "k");
	    model.addAttribute("thisMonthExpense", String.format("%.1f", thisMonthExpense / 1000) + "k");
	    model.addAttribute("qtrIncome", String.format("%.1f", qtrIncome / 1000) + "k");
	    model.addAttribute("qtrExpense", String.format("%.1f", qtrExpense / 1000) + "k");

	    model.addAttribute("pageTitle", "Home");
	    model.addAttribute("activePage", "dashboard");
	    	
	    
//	    List<ExpenseEntity> expenses = expenseRepository.findAll();
//	    Map<Integer, Double> categorySum = expenses.stream()
//	        .collect(Collectors.groupingBy(
//	            ExpenseEntity::getCategoryId,
//	            Collectors.summingDouble(ExpenseEntity::getAmount)
//	        ));
//
//	    // Convert to JSON string
//	    String chartDataJson = new ObjectMapper().writeValueAsString(categorySum);
//	    model.addAttribute("chartDataJson", chartDataJson);
	    
	    userEntity loggedInUser = (userEntity) session.getAttribute("user");

	    if (loggedInUser == null) {
	        return "redirect:/login";
	    }

	    // ✅ Fetch only logged-in user data
	    List<ExpenseEntity> expenses = expenseRepository.findByUserId(loggedInUser.getUserId());
	    List<IncomeEntity> incomes = incomeRepository.findByUserId(loggedInUser.getUserId());

	    // ==========================
	    // 1. Monthly Expense
	    // ==========================
	    Map<Integer, Double> monthlyExpense = expenses.stream()
	        .collect(Collectors.groupingBy(
	            e -> e.getDate().getMonthValue(),
	            Collectors.summingDouble(ExpenseEntity::getAmount)
	        ));

	    // ==========================
	    // 2. Monthly Income
	    // ==========================
	    Map<Integer, Double> monthlyIncome = incomes.stream()
	        .collect(Collectors.groupingBy(
	            i -> i.getDate().getMonthValue(),
	            Collectors.summingDouble(IncomeEntity::getAmount)
	        ));

	    // Fill missing months
	    Map<Integer, Double> finalExpense = new TreeMap<>();
	    Map<Integer, Double> finalIncome = new TreeMap<>();

	    for (int i = 1; i <= 12; i++) {
	        finalExpense.put(i, monthlyExpense.getOrDefault(i, 0.0));
	        finalIncome.put(i, monthlyIncome.getOrDefault(i, 0.0));
	    }

	    // ==========================
	    // 3. Category-wise Expense
	    // ==========================
	    Map<Integer, String> categoryMap = categoryRepository.findAll()
	        .stream()
	        .collect(Collectors.toMap(
	            CategoryEntity::getCategoryId,
	            CategoryEntity::getCategoryName
	        ));

	    Map<String, Double> categoryData = expenses.stream()
	        .collect(Collectors.groupingBy(
	            e -> categoryMap.get(e.getCategoryId()),
	            Collectors.summingDouble(ExpenseEntity::getAmount)
	        ));

	    ObjectMapper mapper = new ObjectMapper();

	    model.addAttribute("expenseJson", mapper.writeValueAsString(finalExpense));
	    model.addAttribute("incomeJson", mapper.writeValueAsString(finalIncome));
	    model.addAttribute("categoryJson", mapper.writeValueAsString(categoryData));
	    

	    return "USER/UserHome";
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
	                return "redirect:/Home";
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

            if ("ADMIN".equalsIgnoreCase(user.getRole())) {
    	        mailService.sendAdminPasswordSuccessMail(user);
    	    } else {
    	        mailService.sendUserPasswordSuccessMail(user);
    	    }
    		
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
		mailService.sendUserWelcomeMail(userEntity);

		return "Login";
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "Login";
	}
}
