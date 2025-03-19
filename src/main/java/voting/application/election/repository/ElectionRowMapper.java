package voting.application.election.repository;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import voting.application.election.entities.Election;

public class ElectionRowMapper implements RowMapper<Election> {

	@Override
	public Election mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		int _id = rs.getInt("_id");
		String election_name = rs.getString("election_name");
		Date start_date = rs.getDate("start_date");
		Date end_date = rs.getDate("end_date");

		return new Election(_id,election_name,start_date,end_date);
	}

}
