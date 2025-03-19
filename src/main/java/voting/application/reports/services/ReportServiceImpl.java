package voting.application.reports.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import voting.application.reports.repository.ReportRepository;

import java.util.List;
import java.util.Map;

@Service
public class ReportServiceImpl implements ReportService {

    @Autowired
    private ReportRepository reportRepository;

    @Override
    public List<Map<String, Object>> getReportData() {
    	List<Map<String, Object>> reportData = reportRepository.fetchReportData();
        System.out.println("Fetched report data: " + reportData.size());
        return reportData;
    }
    
    @Override
    public List<Map<String, Object>> getVoterParticipationData() {
        return reportRepository.fetchVoterParticipationData();
    }
    
    @Override
    public List<Map<String, Object>> getCandidatePerformanceData(String electionName) {
        return reportRepository.fetchCandidatePerformanceData(electionName);
    }

}

