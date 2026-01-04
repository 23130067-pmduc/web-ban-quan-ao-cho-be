package vn.edu.nlu.fit.shopquanao.Service;

import vn.edu.nlu.fit.shopquanao.Dao.NewsDao;
import vn.edu.nlu.fit.shopquanao.model.News;

import java.util.List;
import java.util.Optional;

public class NewsService {

    private final NewsDao newsDao = new NewsDao();

    public List<News> getNewsPage(int page, int pageSize) {
        if (page < 1) page = 1;
        return newsDao.getNewsPaginated(page, pageSize);
    }

    public int getTotalPages(int pageSize) {
        return newsDao.getTotalPages(pageSize);
    }

    public int getTotalNews() {
        return newsDao.getTotalNewsCount();
    }

    public Optional<News> getBySlug(String slug) {
        if (slug == null || slug.isEmpty()) return Optional.empty();
        return newsDao.getNewsBySlug(slug);
    }

    public List<News> getRelatedNews(int currentId, int limit) {
        return newsDao.getRelatedNews(currentId, limit);
    }

    public List<News> search(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return List.of();
        }
        return newsDao.searchNews(keyword.trim());
    }

    public List<News> getLatest(int limit) {
        return newsDao.getLatestNews(limit);
    }
}
