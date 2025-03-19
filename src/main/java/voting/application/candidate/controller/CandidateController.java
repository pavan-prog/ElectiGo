package voting.application.candidate.controller;

import java.io.IOException;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;
import voting.application.candidate.entities.Candidate;
import voting.application.candidate.entities.CandidateWithElection;
import voting.application.candidate.services.CandidateServices;
import voting.application.election.entities.Election;
import voting.application.election.services.ElectionServices;

@Controller
public class CandidateController {

	Candidate candidate;

	@Autowired
	CandidateServices candidateServices;

	@Autowired
	ElectionServices electionServices;

	@GetMapping("/vamshi_index")
	public String openCandidateHomepage() {
		return "index";

	}



	@GetMapping("/candidate/openRegistrationPage")
	public String openCandidateRegistrationPage(@RequestParam("election_id") int electionId, Model model) {
		Election election = electionServices.getElectionById(electionId);
		System.out.println("checkkk eid :" + election.getElectionId());
		System.out.println("electionn : " + election);
		if (election != null) {
			model.addAttribute("election", election);
			return "candidate/registration";
		} else {
			return "sub_admin/view_elections";
		}
	}
	
	
	@GetMapping("/candidate/openRegistrationPageForSubAdmin")
	public String openRegistrationPageForSubAdmin(@RequestParam("election_id") int electionId, Model model) {
		Election election = electionServices.getElectionById(electionId);
		System.out.println("checkkk eid :" + election.getElectionId());
		System.out.println("electionn : " + election);
		if (election != null) {
			model.addAttribute("election", election);
			return "candidate/registrationForm";
		} else {
			return "sub_admin/view_elections";
		}
	}

	@GetMapping("/candidate/updateCandidatePage")
	public String openUpdatePage(@RequestParam("aadhar") String aadhar, Model model) {
		Candidate candidate = candidateServices.getCandidateByAadhar(aadhar);
		model.addAttribute("candidate", candidate);
		return "candidate/update";
	}

	@GetMapping("/candidate/openCandidateDeletionPage")
	public String openCandidateDeletePage(@RequestParam("aadhar") String aadharNumber, Model model) {
		int result = candidateServices.deleteCandidateByAadhar(aadharNumber);
		String message = "Deletion Successful.";
		if (result <= 0) {
			message = "Deletion failed. Please try again.";
		}
		List<Candidate> candidateList = candidateServices.fetchAllCandidates();

		model.addAttribute("listOfCandidates", candidateList);

		return "candidate/viewpage";

	}

	@PostMapping("/candidate/updateCandidate")
	public ModelAndView updateCandidate(@ModelAttribute Candidate candidate, ModelAndView mView) {
		String message;
		try {
			boolean isUpdated = candidateServices.updateCandidate(candidate);
			if (isUpdated) {
				message = "Candidate updated successfully!";
			} else {
				message = "Failed to update candidate. Please try again.";
			}
		} catch (Exception e) {
			e.printStackTrace();
			message = "Error occurred while updating the candidate.";
		}

		mView.setViewName("candidate/update");
		mView.addObject("message", message);
		return mView;
	}

	@PostMapping("/candidate/registrationForm")
	public ModelAndView registrationForm(@ModelAttribute Candidate candidate,
			@RequestParam("electionId") int electionId, ModelAndView mView) {

		System.out.println("Received election_id: " + electionId); // Debugging line

		String message = "";
		int result = 0;

		try {
			result = candidateServices.registerCandidate(candidate);
			System.out.println(result + "this is result");
			if (result > 0) {

				System.out.println("candidates : " + candidate);
				boolean isLinked = candidateServices.linkCandidateToElection(electionId, candidate);

				if (isLinked) {
					message = "Candidate Registered and Linked to Election Successfully!";
				} else {
					message = "Failed to link candidate to the election.";
				}
			} else {
				message = "Registration failed. Please try again.";
			}
		} catch (IOException | SQLException e) {
			e.printStackTrace();
			message = "Error occurred during registration.";
		}

		mView.setViewName("candidate/registrationForm");
		mView.addObject("message", message);

		return mView;
	}

	@PostMapping("/candidate/registration")
	public ModelAndView registerCandidate(@ModelAttribute Candidate candidate,
			@RequestParam("electionId") int electionId, ModelAndView mView) {

		System.out.println("Received election_id: " + electionId); // Debugging line

		String message = "";
		int result = 0;

		try {
			result = candidateServices.registerCandidate(candidate);
			System.out.println(result + "this is result");
			if (result > 0) {

				System.out.println("candidates : " + candidate);
				boolean isLinked = candidateServices.linkCandidateToElection(electionId, candidate);

				if (isLinked) {
					message = "Candidate Registered and Linked to Election Successfully!";
				} else {
					message = "Failed to link candidate to the election.";
				}
			} else {
				message = "Registration failed. Please try again.";
			}
		} catch (IOException | SQLException e) {
			e.printStackTrace();
			message = "Error occurred during registration.";
		}

		mView.setViewName("candidate/registration");
		mView.addObject("message", message);

		return mView;
	}

	@GetMapping("/candidate/openAllCandidatesPage")
	public String openAllCandidatePage(Model model) {

		List<Candidate> candidateList = candidateServices.fetchAllCandidates();

		model.addAttribute("listOfCandidates", candidateList);

		return "candidate/viewpage";
	}



	@GetMapping("/candidate/changeAuth/{candidateId}")
	public String changeCandidateAuth(@PathVariable int candidateId) {
		System.out.println("Candidate ID: " + candidateId);
		candidateServices.modifyCandidateAuthority(candidateId);
		return "redirect:/candidate/subAdminPage";
	}
	
	@GetMapping("/candidate/changeAuthForSubAdmin/{candidateId}")
	public String changeAuthForSubAdmin(@PathVariable int candidateId) {
		System.out.println("Candidate ID: " + candidateId);
		candidateServices.modifyCandidateAuthority(candidateId);
		return "redirect:/candidate/pageForSubAdmin";
	}


	
	@GetMapping("/candidate/subAdminPage")
	public String subAdminPage(Model model, HttpSession session) {
	    Integer electionId = (Integer) session.getAttribute("electionId");
	 
	    if (electionId != null) {
	        List<CandidateWithElection> candidateWithElection = candidateServices.getCandidatesWithElectionDetails(electionId);
	        model.addAttribute("candidateWithElection", candidateWithElection);
	    } else {
	        model.addAttribute("candidateWithElection", null);
	    }
	 
	    return "candidate/subAdminelection";
	}

	@GetMapping("/candidate/pageForSubAdmin")
	public String pageForSubAdmin(Model model, HttpSession session) {
	    Integer electionId = (Integer) session.getAttribute("electionId");
	 
	    if (electionId != null) {
	        List<CandidateWithElection> candidateWithElection = candidateServices.getCandidatesWithElectionDetails(electionId);
	        model.addAttribute("candidateWithElection", candidateWithElection);
	    } else {
	        model.addAttribute("candidateWithElection", null);
	    }
	 
	    return "candidate/subAdminElectionCandidate";
	}

	@GetMapping("/candidate/authorizedCandidates")
	public String getAuthorizedCandidates(Model model) {
		List<Candidate> allCandidates = candidateServices.fetchAllCandidates();

		List<Candidate> authorizedCandidates = allCandidates.stream().filter(Candidate::isAuthorised).toList();

		model.addAttribute("authorizedCandidates", authorizedCandidates);

		return "candidate/authorizedList";
	}

	@GetMapping("/candidate/VoterauthorizedCandidates")
	public String getVoterAuthorizedCandidates(Model model) {
		List<Candidate> allCandidates = candidateServices.fetchAllCandidates();

		List<Candidate> authorizedCandidates = allCandidates.stream().filter(Candidate::isAuthorised).toList();

		model.addAttribute("authorizedCandidates", authorizedCandidates);

		return "candidate/VoterauthorizedList";
	}

	@GetMapping("/candidate/listOpenRegistrationPage")
	public String listOpenRegistrationPage() {
		return "candidate/candidate_registration";
	}

	@GetMapping("/candidate/openAddCandidatePage")
	public String openRegistrationPage() {
		return "candidate/candidate_registration";
	}

	@PostMapping("/candidate/candidate_registration")
	public ModelAndView candidateRegistration(@ModelAttribute Candidate candidate, ModelAndView mView) {

		String message;

		try {
			candidateServices.registerCandidate(candidate);
			message = "Registration Successful.";
		} catch (IllegalArgumentException e) {
			message = e.getMessage(); 
		} catch (IOException | SQLException e) {
			e.printStackTrace();
			message = "Registration failed. Please try again.";
		}

		mView.setViewName("candidate/registration");
		mView.addObject("message", message);

		return mView;
	}

	@GetMapping("/candidate/listByElection")
	public String listCandidatesByElection(@RequestParam("electionId") int electionId, Model model,
			HttpSession session) {

		session.setAttribute("electionId", electionId);

		List<CandidateWithElection> candidateWithElection = candidateServices
				.getCandidatesWithElectionDetails(electionId);
		model.addAttribute("candidateWithElection", candidateWithElection);
		return "candidate/subAdminelection"; // JSP name
	}
	
	@GetMapping("/candidate/listByElectionForSubAdmin")
	public String listByElectionForSubAdmin(@RequestParam("electionId") int electionId, Model model,
			HttpSession session) {

		session.setAttribute("electionId", electionId);

		List<CandidateWithElection> candidateWithElection = candidateServices
				.getCandidatesWithElectionDetails(electionId);
		model.addAttribute("candidateWithElection", candidateWithElection);
		return "candidate/subAdminElectionCandidate"; // JSP name
	}
	
	@GetMapping("/candidate/listByElection1")
	public String listCandidatesByElection1(@RequestParam("electionId") int electionId, Model model,
			HttpSession session) {

		session.setAttribute("electionId", electionId);

		List<CandidateWithElection> candidateWithElection = candidateServices
				.getCandidatesWithElectionDetails(electionId);
		model.addAttribute("candidateWithElection", candidateWithElection);
		return "candidate/subAdminelectionTimeout"; 
	}

	@GetMapping("/candidate/changeNomination/{candidateId}")
	public String changeNominationForm(@PathVariable int candidateId, Model model) {

		Candidate candidate = candidateServices.getCandidateById(candidateId);
		List<Election> elections = electionServices.getUpcomingElections();

		Integer nominatedElectionId = electionServices.getNominatedElectionId(candidateId);

		model.addAttribute("candidateId", candidateId);
		model.addAttribute("candidateName", candidate.getFull_name());
		model.addAttribute("elections", elections);
		model.addAttribute("nominatedElectionId", nominatedElectionId);

		return "candidate/change_nomination"; 
	}
	@GetMapping("/candidate/changeNominationForSubAdmin/{candidateId}")
	public String changeNominationForSubAdmin(@PathVariable int candidateId, Model model) {

		Candidate candidate = candidateServices.getCandidateById(candidateId);
		List<Election> elections = electionServices.getUpcomingElections();

		Integer nominatedElectionId = electionServices.getNominatedElectionId(candidateId);

		model.addAttribute("candidateId", candidateId);
		model.addAttribute("candidateName", candidate.getFull_name());
		model.addAttribute("elections", elections);
		model.addAttribute("nominatedElectionId", nominatedElectionId);

		return "candidate/change_nominationForSubAdmin"; 
	}

	@PostMapping("/candidate/updateNomination")
	public String updateNomination(@RequestParam int candidateId, @RequestParam(required = false) Integer electionId) {
		System.out.println("election id : " + electionId + ", " + "candidate id : " + candidateId);
		electionServices.updateNomination(candidateId, electionId);

		return "redirect:/elections/upcoming"; // Redirect after processing nomination
	}
	
	@PostMapping("/candidate/updateNominationForSubAdmin")
	public String updateNominationForSubAdmin(@RequestParam int candidateId, @RequestParam(required = false) Integer electionId) {
		System.out.println("election id : " + electionId + ", " + "candidate id : " + candidateId);
		electionServices.updateNomination(candidateId, electionId);

		return "redirect:/elections/upcomingForSubAdmin"; // Redirect after processing nomination
	}

	@GetMapping("/candidate/viewByElection")
	public String viewCandidatesByElection(@RequestParam("electionId") int electionId, Model model,
			HttpSession session) {

		session.setAttribute("electionId", electionId);

		List<CandidateWithElection> candidateWithElection = candidateServices.getCandidatesWithElectionDetails(electionId);

		Map<Integer, Integer> votesMap = candidateServices.fetchVotesForCandidates();
		for (CandidateWithElection candidate : candidateWithElection) {
			candidate.setNumberOfVotes(votesMap.getOrDefault(candidate.getCandidateId(), 0));
		}
		model.addAttribute("candidateWithElection", candidateWithElection);
		return "candidate/viewpage"; 
	}


	@PostMapping("/candidate/updateNominationAssignedElections")
	public String updateNominationAssignedElections(@RequestParam int candidateId, @RequestParam(required = false) Integer electionId) {
		System.out.println("election id : " + electionId + ", " + "candidate id : " + candidateId);
		electionServices.updateNomination(candidateId, electionId);

		return "redirect:/elections/upcoming"; 
	}
	
}

