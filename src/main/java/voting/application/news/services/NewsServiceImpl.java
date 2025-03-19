package voting.application.news.services;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import voting.application.news.entities.News;
import voting.application.news.repository.NewsDao;

@Service
public class NewsServiceImpl implements NewsService {
	@Autowired
    NewsDao newsDao;

    @Override
    public int addNews(News news) throws IOException, SQLException {
        return newsDao.insertNews(news);
    }

    @Override
    public List<News> fetchAllNews() {
        return newsDao.getAllNews();
    }

    @Override
    public News getNewsById(int id) {
        return newsDao.getNewsById(id);
    }

    @Override
    public boolean updateNews(News news) {
        return newsDao.updateNews(news);
    }

    @Override
    public int deleteNews(int id) {
        return newsDao.deleteNews(id);
    }
}