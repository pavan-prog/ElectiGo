package voting.application.reports.repository;


import java.util.List;
import java.util.Map;

public interface ReportRepository {
    public List<Map<String, Object>> fetchReportData();
    
    public List<Map<String, Object>> fetchVoterParticipationData();
    
    public List<Map<String, Object>> fetchCandidatePerformanceData(String electionName);
    
    
}

