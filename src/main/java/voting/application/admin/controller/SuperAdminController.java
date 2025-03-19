package voting.application.admin.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import voting.application.admin.entities.Admin;
import voting.application.admin.services.AdminServices;
import voting.application.election.entities.Election;
import voting.application.election.services.ElectionServices;

@Controller
@RequestMapping("/superadmin")
public class SuperAdminController {

	@Autowired
	AdminServices adminServices;

	@Autowired
	ElectionServices electionServices;
	
	@GetMapping("/returnDashboard")
	public String returnDashBoard()
	{
		return "super_admin/grid_dashboard";
	}
	
	@GetMapping("/openViewSubAdminsPage")
	public String openViewSubAdminsPage(Model model) {

		List<Admin> adminsList = adminServices.fetchAllAdmins();

		model.addAttribute("adminsList", adminsList);

		return "super_admin/view_sub_admins";
	}
	

	
	
	@GetMapping("/openAssignElectionsPage/{subAdminId}")
	public String openAssignElectionsPage(@PathVariable int subAdminId, Model model) {
	    Admin subAdmin = adminServices.getAdminById(subAdminId);

	    List<Election> elections = electionServices.getAllElections();

	    List<Integer> assignedElectionIds = electionServices.getAssignedElectionIds(subAdminId);

	    model.addAttribute("subAdminId", subAdminId);
	    model.addAttribute("subAdminName", subAdmin.getFirstName() + " " + subAdmin.getLastName());
	    model.addAttribute("elections", elections);
	    model.addAttribute("assignedElectionIds", assignedElectionIds);

	    return "super_admin/assign_elections";
	}

	
	


	
	@PostMapping("/assignElections")
	public String assignElections(@RequestParam int subAdminId, @RequestParam(required = false) List<Integer> electionIds) {
	    electionServices.assignElectionsToSubAdmin(subAdminId, electionIds);

	    return "redirect:/superadmin/openViewSubAdminsPage";
	}


}
