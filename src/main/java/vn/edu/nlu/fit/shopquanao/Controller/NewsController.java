package vn.edu.nlu.fit.shopquanao.Controller;

import vn.edu.nlu.fit.shopquanao.Dao.NewsDao;
import vn.edu.nlu.fit.shopquanao.model.News;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

@WebServlet("/tin-tuc")
public class NewsController extends HttpServlet {

    private transient NewsDao newsDao;

    @Override
    public void init() {
        newsDao = new NewsDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String slug = request.getParameter("slug");
        String search = request.getParameter("search");
        String pageParam = request.getParameter("page");

        if (slug != null && !slug.isEmpty()) {
            showNewsDetail(request, response, slug);
            return;
        }

        if (search != null && !search.isEmpty()) {
            searchNews(request, response, search);
            return;
        }

        showNewsList(request, response, pageParam);
    }

    private void showNewsList(HttpServletRequest request, HttpServletResponse response, String pageParam)
            throws ServletException, IOException {

        int currentPage = 1;
        int pageSize = 9;

        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageParam);
                if (currentPage < 1) currentPage = 1;
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }

        List<News> newsList = newsDao.getNewsPaginated(currentPage, pageSize);
        List<News> latestNews = newsDao.getLatestNews(5);
        int totalPages = newsDao.getTotalPages(pageSize);
        int totalNews = newsDao.getTotalNewsCount();

        request.setAttribute("newsList", newsList);
        request.setAttribute("latestNews", latestNews);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalNews", totalNews);

        // Chỉ dùng 1 file JSP - header tự động xử lý login/logout
        request.getRequestDispatcher("/tintuc.jsp").forward(request, response);
    }

    private void showNewsDetail(HttpServletRequest request, HttpServletResponse response, String slug)
            throws ServletException, IOException {

        Optional<News> newsOptional = newsDao.getNewsBySlug(slug);

        if (newsOptional.isPresent()) {
            News news = newsOptional.get();
            List<News> relatedNews = newsDao.getRelatedNews(news.getId(), 4);

            request.setAttribute("news", news);
            request.setAttribute("relatedNews", relatedNews);

            // Chỉ dùng 1 file JSP - header tự động xử lý login/logout
            request.getRequestDispatcher("/chitiet_tintuc.jsp").forward(request, response);

        } else {
            response.sendRedirect(request.getContextPath() + "/tin-tuc");
        }
    }

    private void searchNews(HttpServletRequest request, HttpServletResponse response, String keyword)
            throws ServletException, IOException {

        List<News> searchResults = newsDao.searchNews(keyword);
        List<News> latestNews = newsDao.getLatestNews(5);

        request.setAttribute("newsList", searchResults);
        request.setAttribute("latestNews", latestNews);
        request.setAttribute("searchKeyword", keyword);
        request.setAttribute("totalNews", searchResults.size());

        // Chỉ dùng 1 file JSP - header tự động xử lý login/logout
        request.getRequestDispatcher("/tintuc.jsp").forward(request, response);
    }
}