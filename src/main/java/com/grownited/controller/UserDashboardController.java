package com.grownited.controller;

import java.time.LocalDate;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.grownited.entity.AccountEntity;
import com.grownited.entity.ExpenseEntity;
import com.grownited.entity.IncomeEntity;
import com.grownited.entity.userEntity;
import com.grownited.repository.AccountRepository;
import com.grownited.repository.CategoryRepository;
import com.grownited.repository.ExpenseRepository;
import com.grownited.repository.IncomeRepository;
import com.grownited.repository.StatusRepository;
import com.grownited.repository.SubCategoryRepository;
import com.grownited.repository.UserRepository;
import com.grownited.repository.VenderRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class UserDashboardController {

    @Autowired
    private UserRepository userRepository;
    @Autowired
    private AccountRepository accountRepository;
    @Autowired
    private CategoryRepository categoryRepository;
    @Autowired
    private SubCategoryRepository subCategoryRepository;
    @Autowired
    private VenderRepository venderRepository;
    @Autowired
    private ExpenseRepository expenseRepository;
    @Autowired
    private IncomeRepository incomeRepository;
    @Autowired
    private StatusRepository statusRepository;
    
    
 // ------------------ VIEW PROFILE ------------------
 	@GetMapping("/profile")
 	public String openProfile(HttpSession session, Model model) {

 	    Integer userId = (Integer) session.getAttribute("userId");

 	    // If user not logged in
 	    if (userId == null) {
 	        return "redirect:/login";
 	    }

 	    Optional<userEntity> opUser = userRepository.findById(userId);

 	    if (opUser.isPresent()) {
 	        model.addAttribute("user", opUser.get());
 	        return "UserProfile";
 	    } else {
 	        return "redirect:/login";
 	    }
 	}


 	// ------------------ UPDATE PROFILE ------------------
 	@PostMapping("/updateProfile")
 	public String updateProfile(userEntity user, HttpSession session) {

 	    Integer userId = (Integer) session.getAttribute("userId");

 	    if (userId == null) {
 	        return "redirect:/login";
 	    }

 	    user.setUserId(userId);
 	    userRepository.save(user);

 	    return "redirect:/profile";
 	}
 	
 	@PostMapping("/loginUser")
 	public String loginUser(String email, String password, HttpSession session) {

 	    userEntity user = userRepository.findByEmailAndPassword(email, password);

 	    if (user != null) {

 	        session.setAttribute("userId", user.getUserId());
 	        session.setAttribute("userName", user.getFirstName());

 	        return "redirect:/home";
 	    }

 	    return "Login";
 	}

    // ==================== USER ACCOUNT ====================
    @GetMapping("/user/account")
    public String account(Model model, Integer userId) {
        Optional<userEntity> user = userRepository.findById(userId);
        user.ifPresent(u -> model.addAttribute("user", u));
        return "UserAccount";
    }

    @GetMapping("/user/accountList")
    public String accountList(Model model, Integer userId) {
        model.addAttribute("accountList", accountRepository.findAll());
        userRepository.findById(userId).ifPresent(u -> model.addAttribute("user", u));
        return "UserAccountList";
    }

    @PostMapping("/user/saveAccount")
    public String saveAccount(AccountEntity accountEntity, Integer userId) {
        accountEntity.setActive(true);
        accountRepository.save(accountEntity);
        return "redirect:/user/accountList?userId=" + userId;
    }

    @GetMapping("/user/editAccount")
    public String editAccount(Integer inaccountId, Model model, Integer userId) {
        Optional<AccountEntity> opAccount = accountRepository.findById(inaccountId);
        if (opAccount.isEmpty()) return "redirect:/user/accountList?userId=" + userId;
        model.addAttribute("account", opAccount.get());
        userRepository.findById(userId).ifPresent(u -> model.addAttribute("user", u));
        return "UserAccountEdit";
    }

    @PostMapping("/user/updateAccount")
    public String updateAccount(Integer inaccountId, String title, Float amount, Boolean exDefault, Boolean active, Integer userId) {
        accountRepository.findById(inaccountId).ifPresent(account -> {
            account.setTitle(title);
            account.setAmount(amount);
            account.setExDefault(exDefault != null && exDefault);
            account.setActive(active != null && active);
            accountRepository.save(account);
        });
        return "redirect:/user/accountList?userId=" + userId;
    }

    @GetMapping("/user/deleteAccount")
    public String deleteAccount(Integer accountId, Integer userId) {
        accountRepository.deleteById(accountId);
        return "redirect:/user/accountList?userId=" + userId;
    }

    // ==================== USER CATEGORY ====================
    @GetMapping("/usercategoryList")
    public String categoryList(Model model) {
        model.addAttribute("categoryList", categoryRepository.findAll());
//        userRepository.findById(userId).ifPresent(u -> model.addAttribute("user", u));
        return "/USER/UserCategoryList";
    }

    // ==================== USER SUBCATEGORY ====================
    @GetMapping("/user/subCategoryList")
    public String subCategoryList(Model model, Integer userId) {
        model.addAttribute("categoryList", categoryRepository.findAll());
        model.addAttribute("subCategoryList", subCategoryRepository.findAll());
        userRepository.findById(userId).ifPresent(u -> model.addAttribute("user", u));
        return "UserSubCategoryList";
    }

    // ==================== USER VENDER ====================
    @GetMapping("/user/venderList")
    public String venderList(Model model, Integer userId) {
        model.addAttribute("venderList", venderRepository.findAll());
        userRepository.findById(userId).ifPresent(u -> model.addAttribute("user", u));
        return "UserVenderList";
    }

    // ==================== USER EXPENSE ====================
    @GetMapping("/user/expense")
    public String expense(Model model, Integer userId) {
        model.addAttribute("allCategory", categoryRepository.findAll());
        model.addAttribute("allSubCategory", subCategoryRepository.findAll());
        model.addAttribute("allVender", venderRepository.findAll());
        model.addAttribute("allAccount", accountRepository.findAll());
        model.addAttribute("allStatus", statusRepository.findAll());
        userRepository.findById(userId).ifPresent(u -> model.addAttribute("user", u));
        return "UserExpense";
    }

    @PostMapping("/user/saveExpense")
    public String saveExpense(ExpenseEntity expenseEntity, Integer userId) {
        expenseEntity.setActive(true);
        expenseRepository.save(expenseEntity);
        return "redirect:/user/expenseList?userId=" + userId;
    }

    @GetMapping("/user/expenseList")
    public String expenseList(Model model, Integer userId) {
        model.addAttribute("expenseList", expenseRepository.findAll());
        model.addAttribute("categoryList", categoryRepository.findAll());
        model.addAttribute("subCategoryList", subCategoryRepository.findAll());
        model.addAttribute("venderList", venderRepository.findAll());
        model.addAttribute("accountList", accountRepository.findAll());
        model.addAttribute("statusList", statusRepository.findAll());
        userRepository.findById(userId).ifPresent(u -> model.addAttribute("user", u));
        return "UserExpenseList";
    }

    @GetMapping("/user/editExpense")
    public String editExpense(Integer expenseId, Model model, Integer userId) {
        Optional<ExpenseEntity> opExpense = expenseRepository.findById(expenseId);
        if (opExpense.isEmpty()) return "redirect:/user/expenseList?userId=" + userId;

        ExpenseEntity expense = opExpense.get();
        model.addAttribute("expense", expense);
        model.addAttribute("categoryList", categoryRepository.findAll());
        model.addAttribute("subCategoryList", subCategoryRepository.findAll());
        model.addAttribute("venderList", venderRepository.findAll());
        model.addAttribute("accountList", accountRepository.findAll());
        model.addAttribute("statusList", statusRepository.findAll());
        userRepository.findById(userId).ifPresent(u -> model.addAttribute("user", u));
        return "UserExpenseEdit";
    }

    @PostMapping("/user/updateExpense")
    public String updateExpense(
            Integer expenseId, String title, Integer categoryId, Integer subCategoryId,
            Integer venderId, Integer inaccountId, Integer statusId, Float amount,
            String date, String description, Boolean active, Integer userId
    ) {
        expenseRepository.findById(expenseId).ifPresent(expense -> {
            expense.setTitle(title);
            expense.setCategoryId(categoryId);
            expense.setSubCategoryId(subCategoryId);
            expense.setVenderId(venderId);
            expense.setInaccountId(inaccountId);
            expense.setStatusId(statusId);
            expense.setAmount(amount);
            expense.setDate(LocalDate.parse(date));
            expense.setDescription(description);
            expense.setActive(active != null && active);
            expenseRepository.save(expense);
        });
        return "redirect:/user/expenseList?userId=" + userId;
    }

    // ==================== USER INCOME ====================
    @GetMapping("/user/income")
    public String income(Model model, Integer userId) {
        model.addAttribute("allAccount", accountRepository.findAll());
        model.addAttribute("allStatus", statusRepository.findAll());
        userRepository.findById(userId).ifPresent(u -> model.addAttribute("user", u));
        return "UserIncome";
    }

    @PostMapping("/user/saveIncome")
    public String saveIncome(IncomeEntity incomeEntity, Integer userId) {
        incomeEntity.setActive(true);
        incomeRepository.save(incomeEntity);
        return "redirect:/user/incomeList?userId=" + userId;
    }

    @GetMapping("/user/incomeList")
    public String incomeList(Model model, Integer userId) {
        model.addAttribute("incomeList", incomeRepository.findAll());
        model.addAttribute("accountList", accountRepository.findAll());
        model.addAttribute("statusList", statusRepository.findAll());
        userRepository.findById(userId).ifPresent(u -> model.addAttribute("user", u));
        return "UserIncomeList";
    }

    @GetMapping("/user/editIncome")
    public String editIncome(Integer incomeId, Model model, Integer userId) {
        Optional<IncomeEntity> opIncome = incomeRepository.findById(incomeId);
        if (opIncome.isEmpty()) return "redirect:/user/incomeList?userId=" + userId;
        model.addAttribute("income", opIncome.get());
        model.addAttribute("accountList", accountRepository.findAll());
        model.addAttribute("statusList", statusRepository.findAll());
        userRepository.findById(userId).ifPresent(u -> model.addAttribute("user", u));
        return "UserIncomeEdit";
    }

    @PostMapping("/user/updateIncome")
    public String updateIncome(Integer incomeId, String title, Integer inaccountId, Integer statusId,
                               Float amount, String date, String description, Boolean active, Integer userId) {
        incomeRepository.findById(incomeId).ifPresent(income -> {
            income.setTitle(title);
            income.setInaccountId(inaccountId);
            income.setStatusId(statusId);
            income.setAmount(amount);
            income.setDate(LocalDate.parse(date));
            income.setDescription(description);
            income.setActive(active != null && active);
            incomeRepository.save(income);
        });
        return "redirect:/user/incomeList?userId=" + userId;
    }
}