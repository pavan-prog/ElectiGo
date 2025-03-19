package voting.application.news.repository;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import voting.application.news.entities.News;

@Repository
public class NewsDaoImpl implements NewsDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public int insertNews(News news) {
        String query = "INSERT INTO news (title, description, category, date_posted, video_link) VALUES (?, ?, ?, ?, ?)";
        return jdbcTemplate.update(query, news.getTitle(), news.getDescription(), news.getCategory(),
                                   news.getDatePosted(), news.getVideoLink());
    }

    @Override
    public List<News> getAllNews() {
        String query = "SELECT * FROM news ORDER BY date_posted DESC";
        return jdbcTemplate.query(query, this::mapRowToNews);
    }

    @Override
    public News getNewsById(int id) {
        String query = "SELECT * FROM news WHERE id = ?";
        return jdbcTemplate.queryForObject(query, new Object[] { id }, this::mapRowToNews);
    }

    @Override
    public boolean updateNews(News news) {
        String query = "UPDATE news SET title = ?, description = ?, category = ?, date_posted = ?, video_link = ? WHERE id = ?";
        return jdbcTemplate.update(query, news.getTitle(), news.getDescription(), news.getCategory(),
                                   news.getDatePosted(), news.getVideoLink(), news.getId()) > 0;
    }

    @Override
    public int deleteNews(int id) {
        String query = "DELETE FROM news WHERE id = ?";
        return jdbcTemplate.update(query, id);
    }

    private News mapRowToNews(ResultSet rs, int rowNum) throws SQLException {
        News news = new News();
        news.setId(rs.getInt("id"));
        news.setTitle(rs.getString("title"));
        news.setDescription(rs.getString("description"));
        news.setCategory(rs.getString("category"));
        news.setDatePosted(rs.getDate("date_posted"));
        news.setVideoLink(rs.getString("video_link"));
        return news;
    }
}
