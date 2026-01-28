package vn.edu.nlu.fit.shopquanao.Controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.shopquanao.Dao.NewsDao;
import vn.edu.nlu.fit.shopquanao.model.News;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "NewsAdminServlet", value = "/news-admin")
@MultipartConfig
public class NewsAdminServlet extends HttpServlet {
    private final NewsDao newsDAO = new NewsDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            newsDAO.deleteNews(id);
            response.sendRedirect("news-admin");
            return;
        }

        String mode = request.getParameter("mode");

        if ("add".equals(mode)) {
            request.setAttribute("mode", "add");
            request.getRequestDispatcher("/news-form.jsp").forward(request, response);
            return;
        }

        if ("edit".equals(mode)) {
            int id = Integer.parseInt(request.getParameter("id"));
            newsDAO.getNewsById(id).ifPresent(n ->
                    request.setAttribute("news", n)
            );
            request.setAttribute("mode", "edit");
            request.getRequestDispatcher("/news-form.jsp").forward(request, response);
            return;
        }

        List<News> allNews = newsDAO.getAllNews();
        request.setAttribute("newsList", allNews);
        request.setAttribute("total", allNews.size());
        request.setAttribute("totalActive", allNews.stream().filter(n -> n.getStatus() == 1).count());

        request.getRequestDispatcher("newsAdmin.jsp").forward(request, response);
    }



    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        String title = request.getParameter("title");
        String shortDescription = request.getParameter("shortDescription");
        String content = request.getParameter("content");

        String statusRaw = request.getParameter("status");
        int status = (statusRaw != null) ? Integer.parseInt(statusRaw) : 0;

        if ("create".equals(action)) {
            News news = new News();
            news.setTitle(title);
            news.setShortDescription(shortDescription);
            news.setContent(content);
            news.setStatus(status);
            news.setAuthorId(1);
            news.setSlug(newsDAO.generateSlug(title));

            newsDAO.createNews(news);
        }

        if ("update".equals(action)) {
            String idRaw = request.getParameter("id");
            if (idRaw != null) {
                int id = Integer.parseInt(idRaw);

                News news = new News();
                news.setId(id);
                news.setTitle(title);
                news.setShortDescription(shortDescription);
                news.setContent(content);
                news.setStatus(status);
                news.setSlug(newsDAO.generateSlug(title));

                newsDAO.updateNews(news);
            }
        }

        response.sendRedirect("news-admin");
    }
}