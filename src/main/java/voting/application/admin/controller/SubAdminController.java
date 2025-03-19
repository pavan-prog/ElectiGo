package voting.application.admin.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jakarta.servlet.http.HttpSession;
import voting.application.election.entities.Election;
import voting.application.election.services.ElectionServices;
import voting.application.reports.services.ReportService;
import voting.application.admin.entities.Admin;
import voting.application.admin.services.AdminServices;
import voting.application.candidate.entities.CandidateWithElection;
import voting.application.candidate.services.CandidateServices;

@Controller
@RequestMapping("/subadmin")
public class SubAdminController {

    @Autowired
    ElectionServices electionServices;

    @Autowired
    AdminServices adminServices;
    
    @Autowired
    CandidateServices candidateServices;
    
    @Autowired
    ReportService reportService;
    
	@GetMapping("/opendashboard")
    public String opendashboard(HttpSession session, Model model) {
        Admin admin = (Admin) session.getAttribute("admin");
        if (admin == null) {
            return "redirect:/admin/openLoginPage";
        }
        model.addAttribute("admin", admin);
        return "sub_admin/subAdminDashboard";
    }
    

    
    @GetMapping("/viewElections")
    public String viewAssignedElections(@RequestParam("adminId") int adminId, Model model) {
        System.out.println("Fetching elections for Sub Admin ID: " + adminId);
        List<Election> elections = electionServices.getElectionsBySubAdminId(adminId);
        System.out.println("Fetched Elections: " + elections);
        model.addAttribute("listOfElections", elections);

        return "sub_admin/view_elections";
    }

    
    
    @GetMapping("/addCandidate/{electionId}")
    public String showAddCandidateForm(@RequestParam("electionId") int electionId, Model model) {
        Election election = electionServices.getElectionById(electionId);
        model.addAttribute("election", election);
        return "candidate/add_candidate"; 
        
    }

    @GetMapping("/profile")
    public String showProfilePage(Model model, @RequestParam("adminId") int adminId) {
    	System.out.println("Checkkkkk sub admin id (in sub admin controller) : " + adminId);
        Admin admin = adminServices.getAdminById(adminId); 
        model.addAttribute("admin", admin);
        return "sub_admin/profile";
    }
    
    
    @PostMapping("/updateProfile")
    public String updateProfile(@RequestParam("adminId") int adminId,
                                 @RequestParam("firstName") String firstName,
                                 @RequestParam("lastName") String lastName,
                                 @RequestParam("username") String username,
                                 @RequestParam("currentPassword") String currentPassword, // Old password to verify before update
                                 @RequestParam(value = "password", required = false) String password,
                                 Model model) {
        Admin admin = adminServices.getAdminById(adminId);

 
        if (adminServices.matchPassword(currentPassword, admin)) {
            admin.setFirstName(firstName);
            admin.setLastName(lastName);
            admin.setUsername(username);
            
            if (password != null && !password.isEmpty()) {
                admin.setPassword(password);
            }

            adminServices.updateAdmin(admin);
            
    		model.addAttribute("message", "Profile Updated");

            model.addAttribute("admin", admin);  // Send updated admin object to the view

            return "sub_admin/profile";
        } else {
            model.addAttribute("message", "Incorrect old password");
            return "sub_admin/profile"; 
        }
    }
    
    @GetMapping("/dashboard")
    public String showDashboard(@RequestParam("adminId") int adminId, Model model) {

        model.addAttribute("adminId", adminId);
        return "sub_admin/subAdminDashboard";
    }

    @GetMapping("/manageElections")
    public String manageElections(@RequestParam("adminId") int adminId, Model model) {
        System.out.println("Fetching elections for Sub Admin ID: " + adminId);
        List<Election> elections = electionServices.getElectionsBySubAdminId(adminId);
        System.out.println("Fetched Elections: " + elections);
        model.addAttribute("listOfElections", elections);

        return "elections/manageElections";
    }


    
    @GetMapping("/openViewAllElectionsforsubadmin")
    public String openViewAllElectionsforsubadmin(Model model) {
        System.out.println("\n Inside openViewAllPageforsubadmin()");
		List<Election> electionsList = electionServices.viewAllElections();
		model.addAttribute("listOfElections", electionsList);	
		return "sub_admin/viewElectionsForsubadmin";
    }
    
    @GetMapping("/viewByElectionForSubadmin")
	public String viewByElectionForSubadmin(@RequestParam("electionId") int electionId, Model model,
			HttpSession session) {

		session.setAttribute("electionId", electionId);

		List<CandidateWithElection> candidateWithElection = candidateServices.getCandidatesWithElectionDetails(electionId);

		Map<Integer, Integer> votesMap = candidateServices.fetchVotesForCandidates();
		for (CandidateWithElection candidate : candidateWithElection) {
			candidate.setNumberOfVotes(votesMap.getOrDefault(candidate.getCandidateId(), 0));
		}
		model.addAttribute("candidateWithElection", candidateWithElection);
		return "sub_admin/viewpageforsubadmin"; 
	}
    
    
    @GetMapping("/reportsHomeForsubadmin")
    public String reportsHomeForsubadmin() {
        return "sub_admin/reportsForSubadmin";
    }
    
    @GetMapping("/candidateReportByElectionForsubadmin")
    public String candidateReportByElection(Model model) {
        System.out.println("\n Inside openViewAllPage()");
		List<Election> electionsList = electionServices.viewAllElections();

		model.addAttribute("listOfElections", electionsList);	
		return "sub_admin/electionsReportforSubadmin";
    }
    
    @GetMapping("/voterParticipationForSubadmin")
    public String voterParticipationForSubadmin(Model model) {
        model.addAttribute("voterParticipationData", reportService.getVoterParticipationData());
        return "sub_admin/voterParticipationReportForSubadmin"; 
    }
    
   
    
    
    
}
