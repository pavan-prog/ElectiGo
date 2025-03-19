package voting.application.reports.controller;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.ui.Model;

import voting.application.election.entities.Election;
import voting.application.election.services.ElectionServices;
import voting.application.reports.services.ReportService;

@Controller
@RequestMapping("/reports")
public class ReportsController {

    @Autowired
    private ReportService reportService;
    
    @Autowired
    private ElectionServices electionServices;

    @GetMapping("/home")
    public String reportsHome() {
        return "reports/reportsHome"; 
    }

    @GetMapping("/view")
    public String viewReports(Model model) {
    	List<Map<String, Object>> reportData = reportService.getReportData();
        System.out.println("Number of reports: " + reportData.size());
        model.addAttribute("reportData", reportData);
        return "reports/reportsView"; 
    }
    
    @GetMapping("/voter-participation")
    public String voterParticipationReport(Model model) {
        model.addAttribute("voterParticipationData", reportService.getVoterParticipationData());
        return "reports/voterParticipationReport"; 
    }
    
    @GetMapping("/candidate-performance")
    public String candidatePerformanceReport(@RequestParam(value = "electionName", required = false) String electionName, Model model) {
        if (electionName == null) {
            System.out.println("Election name not provided");
        } else {
            System.out.println("election name: " + electionName);
        }
        
        Election election = electionServices.findElectionByName(electionName);
        if (election != null) {
            model.addAttribute("electionEndDate", election.getElectionEndDate());
        } else {
            System.out.println("Election not found for the provided name");
        }
        model.addAttribute("candidatePerformanceData", reportService.getCandidatePerformanceData(electionName));
        return "reports/candidatePerformanceReport";
    }


}
