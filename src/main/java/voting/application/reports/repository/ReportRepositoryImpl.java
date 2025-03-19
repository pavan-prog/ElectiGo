package voting.application.reports.repository;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class ReportRepositoryImpl implements ReportRepository {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<Map<String, Object>> fetchReportData() {
        String sql = "SELECT election_name, COUNT(voter_id) AS total_votes " +
                     "FROM elections e " +
                     "JOIN elections_vote ev ON e._id = ev.election_id " +
                     "GROUP BY election_name";
        
        List<Map<String, Object>> result = jdbcTemplate.queryForList(sql);

        System.out.println("Query result size: " + result.size());

        return jdbcTemplate.queryForList(sql);
    }
    
    
    @Override
    public List<Map<String, Object>> fetchVoterParticipationData() {
        String sql = "SELECT e.election_name, COUNT(vv.voter_id) AS total_voters " +
                     "FROM elections e " +
                     "LEFT JOIN elections_vote vv ON e._id = vv.election_id " +
                     "GROUP BY e.election_name";
        
        return jdbcTemplate.queryForList(sql);
    }
    
    @Override
    public List<Map<String, Object>> fetchCandidatePerformanceData(String electionName) {
        String sql = "SELECT c.full_name AS candidate_name, SUM(ce.number_of_votes) AS total_votes " +
                     "FROM candidates c " +
                     "JOIN election_candidate ce ON c._id = ce.candidate_id " +
                     "JOIN elections e ON e._id = ce.election_id " +
                     "WHERE e.election_name = ? " +
                     "GROUP BY c.full_name";
        return jdbcTemplate.queryForList(sql, electionName);
    }

}
