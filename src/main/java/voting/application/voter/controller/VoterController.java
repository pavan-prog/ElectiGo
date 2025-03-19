package voting.application.voter.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.sql.rowset.serial.SerialException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;
import voting.application.candidate.entities.CandidateWithElection;
import voting.application.candidate.services.CandidateServices;
import voting.application.election.entities.Election;
import voting.application.election.services.ElectionServices;
import voting.application.voter.entities.Voter;
import voting.application.voter.services.VoterServices;

@Controller
@RequestMapping("/voter")
public class VoterController {

	Voter voter;

	@Autowired
	VoterServices voterServices;
	
	@Autowired
	ElectionServices electionServices;
	
	@Autowired
	CandidateServices candidateServices;

	
	@GetMapping("/opendashboard")
    public String opendashboard(HttpSession session, Model model) {
        Voter voter = (Voter) session.getAttribute("voter");
        if (voter == null) {
            return "redirect:/voter/openLoginPage";
        }
        model.addAttribute("voter", voter);
        return "voter/dashboard";
    }
	
	 @GetMapping("/openhomepage")
	    public String home() {
	        return "/sabha_index";
	    }
	
	@GetMapping("/voters")
	public Voter getVoter(@RequestParam String aadharNumber) {
		return voterServices.getVoterById(aadharNumber);
	}

	@GetMapping("/openLoginPage")
	public String openLoginPage() {
		return "voter/login";
	}

	@PostMapping("/login")
	public ModelAndView login(@RequestParam String aadharNumber, @RequestParam String password, HttpSession session,ModelAndView mView) {

		mView.setViewName("voter/login");

		System.out.println("\n login page");
		System.out.println("\n Aadhar Number : " + aadharNumber);
		System.out.println("\n password : " + password);

		String destination = "voter/login";
		String message = "Login Failed,You are not authorized to log in. Please wait for permission";

		Optional<Voter> optVoter = voterServices.fetchVoterDetails(aadharNumber);
		System.out.println(optVoter);

		if (optVoter.isEmpty()) {
			mView.setViewName("voter/login");
			mView.addObject("message", "Check username.");
			return mView;
		}

		voter = optVoter.get();
		System.out.println("\n voter from db");

		if (!voterServices.matchPassword(password, voter)) {
			mView.setViewName("voter/login");
			mView.addObject("message", "Check password.");
			return mView;
		}

		if (!voter.isAuthorized()) {
			mView.setViewName("voter/login");
			mView.addObject("message", "Authorization pending.");
			return mView;
		}

		System.out.println("\n voter from db : " + voter);

        mView.setViewName("redirect:/voter/opendashboard");
        session.setAttribute("voter", voter);

		mView.addObject("message", message);

		return mView;
	}

	
	@GetMapping("/openRegistrationPage")
	public String openRegistrationPage() {
		return "voter/registration";
	}


	
	@PostMapping("/registration")
	public ModelAndView voterRegistration(@RequestParam String fullName, @RequestParam Date dob,
	        @RequestParam String mobile, @RequestParam String aadharNumber, @RequestParam String password,
	        @RequestParam String nationality, @RequestParam("profilePic") MultipartFile profilePic, ModelAndView mView)
	        throws SerialException, IOException, SQLException {

	    mView.setViewName("voter/registration");

	    if (voterServices.fetchVoterDetails(aadharNumber).isPresent()) {
	        mView.addObject("message", "Aadhar number already exists. Please use a unique Aadhar number.");
	        return mView;
	    }

	    Voter voter = new Voter();
	    voter.setFullName(fullName);
	    voter.setDateOfBirth(dob);
	    voter.setMobile(mobile);
	    voter.setAadharNumber(aadharNumber);
	    voter.setNationality(nationality);
	    voter.setPassword(password);
	    voter.setProfilePic(profilePic);

	    System.out.println("\n inside registration" + voter);

	    int result = voterServices.registerVoter(voter);

	    String message = "Registration Successful. \n Please Wait for 1-day for Autorization.";

	    if (result <= 0) {
	        message = "Registration failed. \n Please try again.";
	    }

	    mView.addObject("message", message);

	    return mView;
	}
	

	@GetMapping("/openview_allPage")
	public String openview_allPage(Model model) {

		System.out.println("\n Inside openview_allPage()");

		List<Voter> votersList = voterServices.fetchAllVoters();

		model.addAttribute("listOfVoters", votersList);

		return "voter/view_all";
	}

	@GetMapping("/delete/{id}")
	public String deleteVoter(@PathVariable("id") String aadharNumber, Model model) {
		int result = voterServices.deleteVoterById(aadharNumber);

		String message = "Deletion Successful.";
		if (result <= 0) {
			message = "Deletion failed. Please try again.";
		}

		List<Voter> votersList = voterServices.fetchAllVoters();
		model.addAttribute("listOfVoters", votersList);
		model.addAttribute("message", message);

		return "voter/view_all";
	}

	@GetMapping("/changeAuth/{id}")
	public String changeVoterAuthority(@PathVariable("id") String aadharNumber, Model model) {
		int result = voterServices.changeVoterAuthority(aadharNumber);

		String message = "Authority change successful.";
		if (result <= 0) {
			message = "Authority change failed. Please try again.";
		}

		List<Voter> votersList = voterServices.fetchAllVoters();
		model.addAttribute("listOfVoters", votersList);
		model.addAttribute("message", message);

		return "voter/view_all";
	}

	@GetMapping("/edit/{aadharNumber}")
	public String openEditForm(@PathVariable String aadharNumber, Model model) {
		Voter voter = voterServices.getVoterById(aadharNumber);
		model.addAttribute("voter", voter);
		return "voter/updateForm";
	}
	

	@PostMapping("/update")
	public ModelAndView updateVoter(@ModelAttribute Voter voter, ModelAndView mView) {
	    String message;
	    try {
	        boolean isUpdated = voterServices.updateVoter(voter);
	        if (isUpdated) {
	            message = "voter updated successfully!";
	        } else {
	            message = "Failed to update voter. Please try again.";
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        message = "Error occurred while updating the voter.";
	    }
	    
	    mView.setViewName("voter/dashboard");
	    mView.addObject("message", message);
	    return mView;
	}
	
	



	
	@GetMapping("/openActiveElection/{voterId}")
	public String openActiveElection(@PathVariable("voterId") int voterId, Model model) {
	    System.out.println("\n Inside openActiveElection()");
	    List<Election> electionsList = electionServices.viewAllElections();
	    
	    Map<Integer, Boolean> votingStatusMap = new HashMap<>();
	    for (Election election : electionsList) {
	        boolean isVoted = voterServices.isVoted(voterId, election.getElectionId());
	        votingStatusMap.put(election.getElectionId(), isVoted);
	    }
	    
	    model.addAttribute("voterId", voterId);
	    model.addAttribute("listOfElections", electionsList);
	    model.addAttribute("votingStatusMap", votingStatusMap);
	    return "voter/activeElection";
	}
	
	
	
	

	
	@GetMapping("/openVotingPage/{election_id}/{voter_id}")
    public String openVotingPage(@PathVariable("election_id") int electionId,@PathVariable("voter_id") int voterId,Model model) {
        System.out.println("\n Inside openViewAllPage()");
		List<CandidateWithElection> candidatesList =candidateServices.getCandidatesWithElectionDetails(electionId);
		
		
		boolean isVoted;
		try {
			isVoted = voterServices.isVoted(voterId, electionId);
		} catch (Exception e) {
			isVoted = false;
		}
		
		System.out.println("\n\nisVoted====="+isVoted);
		
		model.addAttribute("candidatesList", candidatesList);	
		model.addAttribute("voterId",voterId);
		if(isVoted)
			return "voter/votedPage";
		else
			return "voter/votingPage";
}
	

	@GetMapping("/castVote/{candidateId}/{electionId}/{voterId}")
	public String castVote(@PathVariable int candidateId, @PathVariable int electionId, @PathVariable("voterId") int voterId) {
	    candidateServices.incrementVotesByOne(electionId, candidateId);
	    voterServices.updateVoterStatus(voterId, electionId);
	    
	    
	    return "voter/successful"; 
	}
	

	
	@GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/voter/openLoginPage";
    }
	

}
