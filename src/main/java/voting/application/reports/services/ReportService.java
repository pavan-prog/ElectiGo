package voting.application.reports.services;

import java.util.List;
import java.util.Map;

public interface ReportService {

    public List<Map<String, Object>> getReportData();
    
    
    public List<Map<String, Object>> getVoterParticipationData();
    
    
    public List<Map<String, Object>> getCandidatePerformanceData(String electionName);

    
}
