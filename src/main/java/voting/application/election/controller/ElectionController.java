package voting.application.election.controller;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;
import voting.application.candidate.entities.Candidate;
import voting.application.candidate.services.CandidateServices;
import voting.application.election.entities.Election;
import voting.application.election.services.ElectionServices;

@Controller
@RequestMapping("/elections")
public class ElectionController {
    
    @Autowired
    ElectionServices electionServices;
    
    @Autowired
    CandidateServices candidateServices;
    
    @GetMapping("/openElectionInsertionPage")
    public String openElectionInsertionPage() {
        System.out.println("\n Inside openElectionInsertionPage()");
        return "elections/insertElection";
    }
    
    
    @GetMapping("/openViewAllPage")
    public String openViewAllPage(Model model) {
        System.out.println("\n Inside openViewAllPage()");
		List<Election> electionsList = electionServices.viewAllElections();
		model.addAttribute("listOfElections", electionsList);	
		return "elections/viewAll";
    }
    
    @GetMapping("/openViewElectionsForSuperAdmin")
    public String openViewElectionsForSuperAdmin(Model model) {
        System.out.println("\n Inside openViewElectionsForSuperAdmin()");
		List<Election> electionsList = electionServices.viewAllElections();
		model.addAttribute("listOfElections", electionsList);	
		return "elections/superAdminViewElections";
    }
    
    @PostMapping("/insertElection")
    public ModelAndView insertElection(
            @RequestParam String electionName,
            @RequestParam Date startDate, 
            @RequestParam Date endDate, 
            ModelAndView mView) {
        
        mView.setViewName("elections/successfull");
        
        Election election = new Election();
        election.setElectionName(electionName);
        election.setElectionStartDate(startDate);
        election.setElectionEndDate(endDate);
        
        System.out.println("\n\n"+election);
        
        String destination = "elections/successfull";
        
        int result = electionServices.addNewElection(election);
        String message = "Election added successfully!";

        if(result <= 0) {
            message = "Failed to add election";
        }
        
        mView.setViewName(destination);
        mView.addObject("message", message);
        
        return mView;
    }
    
    @GetMapping("/openElectionUpdationPage/{id}")
    public String openElectionUpdationPage(@PathVariable("id") int electionId, Model model/*, HttpSession session*/) {
    	

    	Election election = electionServices.fetchElection(electionId);
    	
    	model.addAttribute("election", election);
        System.out.println("\n Inside openElectionUpdationPage()");
        return "elections/updateElection";
    }
    @GetMapping("/openElectionUpdationPageForSubAdmin/{id}")
    public String openElectionUpdationPageForSubAdmin(@PathVariable("id") int electionId, Model model/*, HttpSession session*/) {
    	

    	Election election = electionServices.fetchElection(electionId);
    	
    	model.addAttribute("election", election);
        System.out.println("\n Inside openElectionUpdationPage()");
        return "elections/updateElectionForSubAdmin";
    }
    
    
    @PostMapping("/updateElection")
    public ModelAndView updateElection(
            @RequestParam String electionName,
            @RequestParam Date startDate, 
            @RequestParam Date endDate, 
            ModelAndView mView) {
        
        mView.setViewName("elections/successfull");
        
        Election election = new Election();
        election.setElectionName(electionName);
        election.setElectionStartDate(startDate);
        election.setElectionEndDate(endDate);
        
        System.out.println("\n\n"+election);
        
        
        String destination = "elections/successfull";
        
        int result = electionServices.modifyElection(election, electionName);
        
        String message = "Election updated successfully!";

        if(result <= 0) {
            message = "Failed to update election";
        }
       
        mView.setViewName(destination);
        
        mView.addObject("message", message);
        return mView;
    }
    
    @PostMapping("/updateElectionForSubAdmin")
    public ModelAndView updateElectionForSubAdmin(
            @RequestParam String electionName,
            @RequestParam Date startDate, 
            @RequestParam Date endDate, 
            ModelAndView mView) {
        
        mView.setViewName("elections/successfull");
        
        Election election = new Election();
        election.setElectionName(electionName);
        election.setElectionStartDate(startDate);
        election.setElectionEndDate(endDate);
        
        System.out.println("\n\n"+election);
        
        
        String destination = "elections/successfullForSubAdmin";
        
        int result = electionServices.modifyElection(election, electionName);
        
        String message = "Election updated successfully!";

        if(result <= 0) {
            message = "Failed to update election";
        }
       
        mView.setViewName(destination);
        
        mView.addObject("message", message);
        return mView;
    }
    
    @GetMapping("/openElectionDeletionPage/{id}")
    public String deleteElection(@PathVariable("id") int electionId, Model model) {
        int result = electionServices.removeElection(electionId);
        String message = "Deletion Successful.";
        if (result <= 0) {
            message = "Deletion failed. Please try again.";
        }

        List<Election> electionsList = electionServices.viewAllElections();
        model.addAttribute("listOfElections", electionsList);
        model.addAttribute("message", message);
        
        return "elections/successfull";
    }

    
    
    @GetMapping("/upcoming")
    public String upcoming(Model model) {
        List<Election> elections = electionServices.getUpcomingElections();
        model.addAttribute("listOfElections", elections);
        return "elections/upcoming_elections"; 
    }
    
    
    @GetMapping("/upcomingForSubAdmin")
    public String upcomingForSubAdmin(Model model) {
        List<Election> elections = electionServices.getUpcomingElections();
        model.addAttribute("listOfElections", elections);
        return "elections/upcoming_electionsForSubAdmin"; 
    }
    
    
    
   
    @GetMapping("/openViewAllElections")
    public String openViewAllElections(Model model) {
        System.out.println("\n Inside openViewAllPage()");
		List<Election> electionsList = electionServices.viewAllElections();
		model.addAttribute("listOfElections", electionsList);	
		return "elections/viewElections";
    }
    
    
    
    
    @GetMapping("/candidateReportByElection")
    public String candidateReportByElection(Model model) {
        System.out.println("\n Inside openViewAllPage()");
		List<Election> electionsList = electionServices.viewAllElections();

		model.addAttribute("listOfElections", electionsList);	
		return "elections/electionsForReports";
    }
    
    
    @GetMapping("/candidateReportByElectionForSubAdmin")
    public String candidateReportByElectionForSubAdmin(Model model) {
        System.out.println("\n Inside candidateReportByElectionForSubAdmin()");
		List<Election> electionsList = electionServices.viewAllElections();

		model.addAttribute("listOfElections", electionsList);	
		return "elections/electionsForReportsForSubAdmin";
    }
    

    
    @GetMapping("/openlistOfElections")
    public String openlistOfElections(Model model) {
        System.out.println("\n Inside openViewAllPage()");
		List<Election> electionsList = electionServices.viewAllElections();
		model.addAttribute("listOfElections", electionsList);	
		return "elections/listOfElections";
    }
}




