<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="vn.edu.nlu.fit.shopquanao.model.News" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    News news = (News) request.getAttribute("news");
    List<News> relatedNews = (List<News>) request.getAttribute("relatedNews");
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= news != null ? news.getTitle() : "Chi tiết tin tức" %> - SunnyBear</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
    <link rel="stylesheet" href="./css/tintuc_1.css">
    <link rel="stylesheet" href="./css/header.css">
    <link rel="stylesheet" href="./css/footer.css">
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="header.jsp"/>

    <!-- Breadcrumb -->
    <div class="title">
        <span>TIN TỨC / <%= news != null ? news.getTitle() : "" %></span>
    </div>

    <!-- Main Content -->
    <main class="content">
        <% if (news != null) { %>
        <article class="mainArticle">
            <h2><%= news.getTitle() %></h2>
            
            <p class="meta">
                🗓 <%= dateFormat.format(news.getCreatedAt()) %>
            </p>

            <!-- Thumbnail -->
            <% if (news.getThumbnail() != null && !news.getThumbnail().isEmpty()) { %>
            <div class="news-thumbnail">
                <img src="<%= request.getContextPath() %>/<%= news.getThumbnail() %>" alt="<%= news.getTitle() %>">
            </div>
            <% } %>

            <!-- Short Description -->
            <% if (news.getShortDescription() != null && !news.getShortDescription().isEmpty()) { %>
            <p class="lead"><%= news.getShortDescription() %></p>
            <% } %>

            <!-- Main Content (HTML from database) -->
            <div class="article-content">
                <%= news.getContent() %>
            </div>
        </article>

        <!-- Sidebar with Related News -->
        <aside class="sidebar">
            <h3>Tin tức liên quan</h3>

            <% if (relatedNews != null && !relatedNews.isEmpty()) { 
                for (News related : relatedNews) { %>
                <div class="related">
                    <div class="relativeContent">
                        <a href="<%= request.getContextPath() %>/tin-tuc?slug=<%= related.getSlug() %>">
                            <img src="<%= request.getContextPath() %>/<%= related.getThumbnail() %>" alt="<%= related.getTitle() %>">
                            <p><%= related.getTitle() %></p>
                        </a>
                    </div>
                </div>
            <% } 
            } else { %>
                <p>Không có tin tức liên quan</p>
            <% } %>
        </aside>
        <% } else { %>
        <div class="error-message">
            <h2>Không tìm thấy bài viết</h2>
            <p><a href="<%= request.getContextPath() %>/tin-tuc">← Quay lại trang tin tức</a></p>
        </div>
        <% } %>
    </main>

    <!-- Include Footer -->
    <jsp:include page="footer.jsp"/>

    <!-- Scripts -->
    <script src="./javaScript/header.js"></script>
    <script src="./javaScript/thongBao.js"></script>
    <script src="./javaScript/search.js"></script>
</body>
</html>
