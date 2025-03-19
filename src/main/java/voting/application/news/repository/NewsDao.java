package voting.application.news.repository;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import voting.application.news.entities.News;

public interface NewsDao {
    int insertNews(News news) throws IOException, SQLException;

    List<News> getAllNews();

    News getNewsById(int id);

    boolean updateNews(News news);

    int deleteNews(int id);
}