package vn.edu.nlu.fit.shopquanao.Controller;

import java.io.IOException;
import java.util.List;
import java.util.Optional;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.shopquanao.Dao.NewsDao;
import vn.edu.nlu.fit.shopquanao.model.News;

@WebServlet("/tin-tuc")
public class NewsController extends HttpServlet {

    private transient NewsDao newsDao;

    @Override
    public void init() {
        newsDao = new NewsDao();
    }

    /**
     * Hiển thị danh sách tin tức hoặc chi tiết tin tức
     * URL: /tin-tuc (danh sách)
     * URL: /tin-tuc?slug=ten-bai-viet (chi tiết)
     * URL: /tin-tuc?page=2 (phân trang)
     * URL: /tin-tuc?search=keyword (tìm kiếm)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy parameters
        String slug = request.getParameter("slug");
        String search = request.getParameter("search");
        String pageParam = request.getParameter("page");

        // Nếu có slug -> hiển thị chi tiết tin tức
        if (slug != null && !slug.isEmpty()) {
            showNewsDetail(request, response, slug);
            return;
        }

        // Nếu có search -> tìm kiếm tin tức
        if (search != null && !search.isEmpty()) {
            searchNews(request, response, search);
            return;
        }

        // Mặc định: hiển thị danh sách tin tức có phân trang
        showNewsList(request, response, pageParam);
    }

    /**
     * Hiển thị danh sách tin tức với phân trang
     */
    private void showNewsList(HttpServletRequest request, HttpServletResponse response, String pageParam)
            throws ServletException, IOException {

        // Xử lý phân trang
        int currentPage = 1;
        int pageSize = 9; // Hiển thị 9 tin tức mỗi trang

        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageParam);
                if (currentPage < 1) currentPage = 1;
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }

        // Lấy danh sách tin tức theo trang
        List<News> newsList = newsDao.getNewsPaginated(currentPage, pageSize);

        // Lấy tin tức mới nhất (cho sidebar hoặc featured section)
        List<News> latestNews = newsDao.getLatestNews(5);

        // Tính tổng số trang
        int totalPages = newsDao.getTotalPages(pageSize);
        int totalNews = newsDao.getTotalNewsCount();

        // Set attributes để hiển thị trên JSP
        request.setAttribute("newsList", newsList);
        request.setAttribute("latestNews", latestNews);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalNews", totalNews);

        // Kiểm tra user đã login chưa để forward đúng JSP
        if (request.getSession().getAttribute("user") != null) {
            request.getRequestDispatcher("/tintuc_login.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/tintuc.jsp").forward(request, response);
        }
    }

    /**
     * Hiển thị chi tiết một tin tức
     */
    private void showNewsDetail(HttpServletRequest request, HttpServletResponse response, String slug)
            throws ServletException, IOException {

        Optional<News> newsOptional = newsDao.getNewsBySlug(slug);

        if (newsOptional.isPresent()) {
            News news = newsOptional.get();

            // Lấy tin tức liên quan
            List<News> relatedNews = newsDao.getRelatedNews(news.getId(), 4);

            // Set attributes
            request.setAttribute("news", news);
            request.setAttribute("relatedNews", relatedNews);

            // Kiểm tra user đã login chưa
            if (request.getSession().getAttribute("user") != null) {
                request.getRequestDispatcher("/tintuc_1_login.jsp").forward(request, response);
            } else {
                request.getRequestDispatcher("/tintuc_1.jsp").forward(request, response);
            }

        } else {
            // Tin tức không tồn tại -> redirect về trang danh sách
            response.sendRedirect(request.getContextPath() + "/tin-tuc");
        }
    }

    /**
     * Tìm kiếm tin tức
     */
    private void searchNews(HttpServletRequest request, HttpServletResponse response, String keyword)
            throws ServletException, IOException {

        List<News> searchResults = newsDao.searchNews(keyword);

        // Lấy tin tức mới nhất (cho sidebar)
        List<News> latestNews = newsDao.getLatestNews(5);

        // Set attributes
        request.setAttribute("newsList", searchResults);
        request.setAttribute("latestNews", latestNews);
        request.setAttribute("searchKeyword", keyword);
        request.setAttribute("totalNews", searchResults.size());

        // Kiểm tra user đã login chưa
        if (request.getSession().getAttribute("user") != null) {
            request.getRequestDispatcher("/tintuc_login.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/tintuc.jsp").forward(request, response);
        }
    }
}
