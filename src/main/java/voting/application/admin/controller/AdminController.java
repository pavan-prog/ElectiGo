package voting.application.admin.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;
import voting.application.admin.entities.Admin;
import voting.application.admin.services.AdminServices;
import voting.application.utility.SessionUtils;

@Controller
@RequestMapping("/admin")
public class AdminController {

	Admin admin;

	@Autowired
	AdminServices adminServices;
	

	
	@GetMapping("/logout")
	public ModelAndView logout(HttpSession session) {
	    session.invalidate(); 
	    ModelAndView mView = new ModelAndView("redirect:/admin/openLoginPage");
	    mView.addObject("message", "You have been logged out successfully.");
	    return mView;
	}


	@GetMapping("/openListOfAllAdminsPage")
	public String openListOfAllAdminsPage(Model model, HttpSession session) {


	    List<Admin> adminsList = adminServices.fetchAllAdmins();
	    model.addAttribute("listOfAdmins", adminsList);
	    return "super_admin/subAdmins_list";
	}

	@GetMapping("/openLoginPage")
	public String openLoginPage() {
		return "admin/login";
	}
	
	


	@GetMapping("/openRegistrationPage")
	public String openRegistrationPage() {
		System.out.println("this is registration page");
		return "admin/registration";
	}



	@PostMapping("/login")
	public ModelAndView login(@RequestParam String username, @RequestParam String password, HttpSession session, ModelAndView mView) {

		mView.setViewName("admin/login");

		System.out.println("\n Username : " + username);
		System.out.println("\n password : " + password);

		String destination = "admin/login";
		String message = "Login Failed.\nPlease try again.";

		Optional<Admin> optAdmin = adminServices.fetchAdminDetails(username);
		System.out.println("\n Admin from db : " + admin);

		if (optAdmin.isEmpty()) {
			mView.setViewName("admin/login");
			mView.addObject("message", "Invalid username.\nPlease try again.");
			return mView;
		}

		admin = optAdmin.get();
		System.out.println("\n Admin from db : " + admin);

		if (!adminServices.matchPassword(password, admin)) {
			mView.setViewName("admin/login");
			mView.addObject("message", "Invalid Password.\nPlease try again.");
			return mView;
		}

		System.out.println("\n Admin from db " + admin);

		int roleId = admin.getRoleId();

		boolean authorizationStatus = admin.isAuthorized();

		if (roleId == 1) {
			destination = "super_admin/grid_dashboard";
	        session.setAttribute("loggedInAdmin", admin); // Save admin in session
			mView.addObject("admin", admin);
			message = "You have successfully logged in as super-admin.";
		} else if (roleId == 2) {
			if (authorizationStatus) {
				destination = "sub_admin/subAdminDashboard";
	            session.setAttribute("loggedInAdmin", admin); // Save admin in session
				mView.addObject("admin", admin);
				message = "You have successfully logged in as sub-admin.";
			} else {
				message = "Your account is not authorized. Please contact the administrator.";
			}
		}

		mView.setViewName(destination);
		session.setAttribute("admin", admin);
		mView.addObject("message", message);

		
		return mView;

	}


	
	@PostMapping("/registration")
	public String adminRegistration(@ModelAttribute Admin admin, Model model) {

		Optional<Admin> optAdmin1 = adminServices.fetchAdminDetails(admin.getUsername());
		System.out.println("\n\noptAdmin1: " + optAdmin1);
		if (optAdmin1.isPresent()) {
			model.addAttribute("message", "sub admin already exists");
			return "admin/registration";
		}

		Optional<Admin> optAdmin2 = adminServices.fetchAdminDetailsWithEmail(admin.getEmail());
		System.out.println("\n\noptAdmin2 ====: " + optAdmin2);

		if (optAdmin2.isPresent()) {

			model.addAttribute("message", "sub admin with same mail already exists");
			return "admin/registration";
		}

		int result = adminServices.registerAdmin(admin);

		System.out.println("this is postmapping for regisrtration : " + admin.getEmail());
		String message = (result > 0) ? "Sub-Admin added successfully!" : "Failed to add Sub-Admin. Please try again.";

		model.addAttribute("message", message);

		if (result > 0) {
			model.addAttribute("success", true); // Set success flag
		}
		return "admin/registration";
	}
	
	@GetMapping("/changeAuth/{adminId}")
	public String changeAuth(@PathVariable int adminId) {

		System.out.println("\n adminId : " + adminId);

		adminServices.modifyAuthority(adminId);

		return "redirect:/superadmin/openViewSubAdminsPage";
	}

}