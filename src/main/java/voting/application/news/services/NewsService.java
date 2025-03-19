package voting.application.news.services;


import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import voting.application.news.entities.News;

public interface NewsService {
    int addNews(News news) throws IOException, SQLException;

    List<News> fetchAllNews();

    News getNewsById(int id);

    boolean updateNews(News news);

    int deleteNews(int id);
}
