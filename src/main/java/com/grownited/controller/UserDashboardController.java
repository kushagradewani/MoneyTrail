package com.grownited.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.io.IOException;
import java.time.LocalDate;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import com.cloudinary.Cloudinary;
import com.grownited.entity.AccountEntity;
import com.grownited.entity.CategoryEntity;
import com.grownited.entity.ExpenseEntity;
import com.grownited.entity.IncomeEntity;
import com.grownited.entity.StatusEntity;
import com.grownited.entity.SubCategoryEntity;
import com.grownited.entity.VenderEntity;
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
    
    @Autowired
	Cloudinary cloudinary;
    
    
 // =========================
    // 👉 OPEN PROFILE PAGE
    // =========================
    @GetMapping("/profile")
    public String userProfile(HttpSession session, Model model) {

        userEntity user = (userEntity) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        }

        // fresh data from DB (important)
        Optional<userEntity> op = userRepository.findById(user.getUserId());

        if (op.isPresent()) {
            session.setAttribute("user", op.get());
        }

        return "USER/UserProfile"; // JSP name
    }

    // =========================
    // 👉 UPDATE PROFILE
    // =========================
    @PostMapping("/updateUser")
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

        return "redirect:/profile";
    }


 // ==================== USER ACCOUNT PAGE ====================
    @GetMapping("/userAccount")
    public String account(Model model, HttpSession session) {

        userEntity sessionUser = (userEntity) session.getAttribute("user");
        if (sessionUser == null) return "redirect:/login";

        model.addAttribute("user", sessionUser);
        model.addAttribute("activePage", "account");

        return "USER/UserAccount";
    }

    // ==================== ACCOUNT LIST ====================
    @GetMapping("/userAccountList")
    public String accountList(Model model, HttpSession session) {

        userEntity sessionUser = (userEntity) session.getAttribute("user");
        if (sessionUser == null) return "redirect:/login";

        List<AccountEntity> userAccounts =
                accountRepository.findByUserId(sessionUser.getUserId());

        model.addAttribute("user", sessionUser);
        model.addAttribute("accountList", userAccounts);
        model.addAttribute("activePage", "account");

        return "USER/UserAccountList";
    }

    // ==================== SAVE ACCOUNT ====================
    @PostMapping("/userSaveAccount")
    public String saveAccount(AccountEntity accountEntity, HttpSession session) {

        userEntity sessionUser = (userEntity) session.getAttribute("user");
        if (sessionUser == null) return "redirect:/login";

        accountEntity.setUserId(sessionUser.getUserId()); // 🔥 link to user
        accountEntity.setActive(true);

        accountRepository.save(accountEntity);

        return "redirect:/userAccountList";
    }

    // ==================== EDIT ACCOUNT ====================
    @GetMapping("/userEditAccount")
    public String editAccount(Integer inaccountId, Model model, HttpSession session) {

        userEntity sessionUser = (userEntity) session.getAttribute("user");
        if (sessionUser == null) return "redirect:/login";

        Optional<AccountEntity> opAccount = accountRepository.findById(inaccountId);

        if (opAccount.isEmpty() ||
            !opAccount.get().getUserId().equals(sessionUser.getUserId())) {
            return "redirect:/userAccountList"; // 🔒 block other user data
        }

        model.addAttribute("user", sessionUser);
        model.addAttribute("account", opAccount.get());
        model.addAttribute("activePage", "account");

        return "USER/UserAccountEdit";
    }

    // ==================== UPDATE ACCOUNT ====================
    @PostMapping("/userUpdateAccount")
    public String updateAccount(Integer inaccountId,
                                String title,
                                Float amount,
                                Boolean exDefault,
                                Boolean active,
                                HttpSession session) {

        userEntity sessionUser = (userEntity) session.getAttribute("user");
        if (sessionUser == null) return "redirect:/login";

        Optional<AccountEntity> opAccount = accountRepository.findById(inaccountId);

        if (opAccount.isPresent() &&
            opAccount.get().getUserId().equals(sessionUser.getUserId())) {

            AccountEntity account = opAccount.get();

            account.setTitle(title);
            account.setAmount(amount);
            account.setExDefault(exDefault != null && exDefault);
            account.setActive(active != null && active);

            accountRepository.save(account);
        }

        return "redirect:/userAccountList";
    }

    // ==================== DELETE ACCOUNT ====================
    @GetMapping("/userDeleteAccount")
    public String deleteAccount(Integer accountId, HttpSession session) {

        userEntity sessionUser = (userEntity) session.getAttribute("user");
        if (sessionUser == null) return "redirect:/login";

        Optional<AccountEntity> opAccount = accountRepository.findById(accountId);

        if (opAccount.isPresent() &&
            opAccount.get().getUserId().equals(sessionUser.getUserId())) {

            accountRepository.deleteById(accountId);
        }

        return "redirect:/userAccountList";
    }


    // ==================== USER CATEGORY ====================
    @GetMapping("/userCategoryList")
    public String categoryList(Model model) {
        model.addAttribute("categoryList", categoryRepository.findAll());
//        userRepository.findById(userId).ifPresent(u -> model.addAttribute("user", u));
        model.addAttribute("activePage", "category");
        return "/USER/UserCategoryList";
    }

    // ==================== USER SUBCATEGORY ====================
    @GetMapping("/userSubCategoryList")
    public String subCategoryList(Model model, Integer userId) {
        model.addAttribute("categoryList", categoryRepository.findAll());
        model.addAttribute("subCategoryList", subCategoryRepository.findAll());
//        userRepository.findById(userId).ifPresent(u -> model.addAttribute("user", u));
        model.addAttribute("activePage", "subCategory");
        return "USER/UserSubCategoryList";
    }

    // ==================== USER VENDER ====================
    @GetMapping("/userVenderList")
    public String venderList(Model model, Integer userId) {
        model.addAttribute("venderList", venderRepository.findAll());
//        userRepository.findById(userId).ifPresent(u -> model.addAttribute("user", u));
        model.addAttribute("activePage", "vender");
        return "USER/UserVenderList";
    }

    @GetMapping("/userExpenseList")
    public String expenseList(HttpSession session, Model model) {

        // 1️⃣ Get logged-in user from session
        userEntity loggedInUser = (userEntity) session.getAttribute("user");
        if (loggedInUser == null) {
            return "redirect:/login"; // user not logged in
        }

        Integer userId = loggedInUser.getUserId();

        // 2️⃣ Fetch user-specific expenses
        List<ExpenseEntity> expenses = expenseRepository.findByUserId(userId);
        if (expenses == null) expenses = new ArrayList<ExpenseEntity>();

        // 3️⃣ Fetch statuses for mapping statusId -> status
        List<StatusEntity> statusList = statusRepository.findAll();
        if (statusList == null) statusList = new ArrayList<StatusEntity>();

        // 4️⃣ Add to model
        model.addAttribute("expenseList", expenses);
        model.addAttribute("statusList", statusList);
        model.addAttribute("user", loggedInUser);
        
        model.addAttribute("activePage", "expense");

        return "USER/UserExpenseList"; // correct JSP path
    }

    @GetMapping("/userExpense")
    public String expenseForm(Model model, HttpSession session) {
        userEntity loggedInUser = (userEntity) session.getAttribute("user");
        if (loggedInUser == null) return "redirect:/login";

        model.addAttribute("allCategory", categoryRepository.findAll());
        model.addAttribute("allSubCategory", subCategoryRepository.findAll());
        model.addAttribute("allVender", venderRepository.findAll());
        
        // Only accounts added by the logged-in user
        List<AccountEntity> userAccounts = accountRepository.findByUserId(loggedInUser.getUserId());
        model.addAttribute("allAccount", safeList(userAccounts));
        
        model.addAttribute("allStatus", safeList(statusRepository.findAll()));
        model.addAttribute("user", loggedInUser);
        model.addAttribute("activePage", "expense");

        return "USER/UserExpense";
    }

    
    @GetMapping("/viewUserExpense")
	public String viewExpense(Integer expenseId, Model model) {

		Optional<ExpenseEntity> opExpense = expenseRepository.findById(expenseId);

		if (opExpense.isEmpty()) {
			return "redirect:/userExpenseList";
		}

		ExpenseEntity expense = opExpense.get();

		CategoryEntity category = categoryRepository.findById(expense.getCategoryId()).orElse(null);
		SubCategoryEntity subCategory = subCategoryRepository.findById(expense.getSubCategoryId()).orElse(null);
		VenderEntity vender = venderRepository.findById(expense.getVenderId()).orElse(null);
		AccountEntity account = accountRepository.findById(expense.getInaccountId()).orElse(null);
		StatusEntity status = statusRepository.findById(expense.getStatusId()).orElse(null);

		model.addAttribute("expense", expense);
		model.addAttribute("category", category);
		model.addAttribute("subCategory", subCategory);
		model.addAttribute("vender", vender);
		model.addAttribute("account", account);
		model.addAttribute("status", status);
		
		model.addAttribute("activePage", "expense");

		return "USER/UserExpenseView";
	}

    @PostMapping("/userSaveExpense")
    public String saveExpense(ExpenseEntity expenseEntity, HttpSession session,Model model) {
        userEntity loggedInUser = (userEntity) session.getAttribute("user");
        if (loggedInUser == null) return "redirect:/login";

        expenseEntity.setActive(true);
        expenseEntity.setUserId(loggedInUser.getUserId());
        expenseRepository.save(expenseEntity);
        
     // Fetch account
	    Optional<AccountEntity> opAccount = accountRepository.findById(expenseEntity.getInaccountId());

	    if (opAccount.isPresent()) {
	        AccountEntity account = opAccount.get();

	        // Debug (optional)
	        System.out.println("Expense from: " + account.getTitle());

	        // 🔴 Balance check (IMPORTANT)
	        if (account.getAmount() >= expenseEntity.getAmount()) {
	            account.setAmount(account.getAmount() - expenseEntity.getAmount());
	            accountRepository.save(account);
	        } else {
	            System.out.println("Insufficient balance in " + account.getTitle());
	            return "redirect:/expense?error=insufficient";
	        }
	    }
        
        model.addAttribute("activePage", "expense");

        return "redirect:/userExpenseList";
    }

    @GetMapping("/userEditExpense")
    public String editExpense(Integer expenseId, Model model, HttpSession session) {
        userEntity loggedInUser = (userEntity) session.getAttribute("user");
        if (loggedInUser == null) return "redirect:/login";

        Optional<ExpenseEntity> opExpense = expenseRepository.findById(expenseId);
        if (opExpense.isEmpty()) return "redirect:/user/expenseList";

        model.addAttribute("expense", opExpense.get());
        model.addAttribute("categoryList", categoryRepository.findAll());
        model.addAttribute("subCategoryList", subCategoryRepository.findAll());
        model.addAttribute("venderList", venderRepository.findAll());
        model.addAttribute("accountList", accountRepository.findAll());
        model.addAttribute("statusList", statusRepository.findAll());
        model.addAttribute("user", loggedInUser);
        
        model.addAttribute("activePage", "expense");

        return "USER/UserExpenseEdit";
    }

    @PostMapping("/userUpdateExpense")
    public String updateExpense(
            Integer expenseId, String title, Integer categoryId, Integer subCategoryId,
            Integer venderId, Integer inaccountId, Integer statusId, Float amount,
            String date, String description, Boolean active, HttpSession session,Model model
    ) {
        userEntity loggedInUser = (userEntity) session.getAttribute("user");
        if (loggedInUser == null) return "redirect:/login";

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
        
        model.addAttribute("activePage", "expense");

        return "redirect:/userExpenseList";
    }

    @GetMapping("/userDeleteExpense")
    public String deleteExpense(Integer expenseId, HttpSession session,Model model) {
        userEntity loggedInUser = (userEntity) session.getAttribute("user");
        if (loggedInUser == null) return "redirect:/login";

        if (expenseId != null) expenseRepository.deleteById(expenseId);
        
        model.addAttribute("activePage", "expense");

        return "redirect:/userExpenseList";
    }

 // ==================== ADD INCOME PAGE ====================
    @GetMapping("/userIncome")
    public String income(Model model, HttpSession session) {
        userEntity loggedUser = (userEntity) session.getAttribute("user");
        if (loggedUser == null) return "redirect:/login";

        model.addAttribute("user", loggedUser);

        // Only accounts added by the logged-in user
        List<AccountEntity> userAccounts = accountRepository.findByUserId(loggedUser.getUserId());
        model.addAttribute("allAccount", safeList(userAccounts));

        model.addAttribute("allStatus", safeList(statusRepository.findAll()));
        model.addAttribute("activePage", "income");

        return "USER/UserIncome";
    }


    // ==================== SAVE INCOME ====================
    @PostMapping("/userSaveIncome")
    public String saveIncome(IncomeEntity income, HttpSession session,Model model) {
        userEntity loggedUser = (userEntity) session.getAttribute("user");
        if (loggedUser == null) return "redirect:/login";

        income.setUserId(loggedUser.getUserId()); // link income to user
        income.setActive(true);
        incomeRepository.save(income);
        
        // Fetch account
	    Optional<AccountEntity> opAccount = accountRepository.findById(income.getInaccountId());

	    if (opAccount.isPresent()) {
	        AccountEntity account = opAccount.get();

	        // Debug (optional)
	        System.out.println("Income added to: " + account.getTitle());

	        // Add amount
	        account.setAmount(account.getAmount() + income.getAmount());

	        accountRepository.save(account);
	    }
        
        model.addAttribute("activePage", "income");

        return "redirect:/userIncomeList";
    }

    // ==================== INCOME LIST ====================
    @GetMapping("/userIncomeList")
    public String incomeList(Model model, HttpSession session) {
        userEntity loggedUser = (userEntity) session.getAttribute("user");
        if (loggedUser == null) return "redirect:/login";

        List<IncomeEntity> incomeList = incomeRepository.findByUserId(loggedUser.getUserId());

        model.addAttribute("incomeList", safeList(incomeList));
        model.addAttribute("accountList", safeList(accountRepository.findAll()));
        model.addAttribute("statusList", safeList(statusRepository.findAll()));
        model.addAttribute("user", loggedUser);
        
        model.addAttribute("activePage", "income");

        return "USER/UserIncomeList";
    }
    
    @GetMapping("/viewUserIncome")
    public String viewIncome(Integer incomeId, Model model) {

        Optional<IncomeEntity> opIncome = incomeRepository.findById(incomeId);

        if (opIncome.isEmpty()) {
            return "redirect:/userIncomeList";
        }

        IncomeEntity income = opIncome.get();

        AccountEntity account = accountRepository.findById(income.getInaccountId()).orElse(null);
        StatusEntity status = statusRepository.findById(income.getStatusId()).orElse(null);

        model.addAttribute("income", income);
        model.addAttribute("account", account);
        model.addAttribute("status", status);
        
        model.addAttribute("activePage", "income");

        return "USER/UserIncomeView";
    }

    // ==================== EDIT INCOME ====================
    @GetMapping("/userEditIncome")
    public String editIncome(Integer incomeId, Model model, HttpSession session) {
        userEntity loggedUser = (userEntity) session.getAttribute("user");
        if (loggedUser == null) return "redirect:/login";

        Optional<IncomeEntity> opIncome = incomeRepository.findById(incomeId);
        if (opIncome.isEmpty()) return "redirect:/user/incomeList";

        IncomeEntity income = opIncome.get();
        model.addAttribute("income", income);
        model.addAttribute("accountList", accountRepository.findAll());
        model.addAttribute("statusList", statusRepository.findAll());
        model.addAttribute("user", loggedUser);
        
        model.addAttribute("activePage", "income");

        return "USER/UserIncomeEdit";
    }

    // ==================== UPDATE INCOME ====================
    @PostMapping("/userUpdateIncome")
    public String updateIncome(
            Integer incomeId,
            String title,
            Integer inaccountId,
            Integer statusId,
            Float amount,
            String date,
            String description,
            Boolean active,
            HttpSession session,Model model
    ) {
        userEntity loggedUser = (userEntity) session.getAttribute("user");
        if (loggedUser == null) return "redirect:/login";

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
        
        model.addAttribute("activePage", "income");

        return "redirect:/userIncomeList";
    }
    
    @GetMapping("/userDelete Income")
    public String deleteIncome(Integer incomeId, HttpSession session, Model model) {

        userEntity loggedInUser = (userEntity) session.getAttribute("user");
        if (loggedInUser == null) return "redirect:/login";

        if (incomeId != null) {
            incomeRepository.deleteById(incomeId);
        }

        model.addAttribute("activePage", "income");

        return "redirect:/userIncomeList";
    }

    // ==================== HELPER METHOD ====================
    private <T> List<T> safeList(List<T> list) {
        return list != null ? list : new ArrayList<>();
    }

}