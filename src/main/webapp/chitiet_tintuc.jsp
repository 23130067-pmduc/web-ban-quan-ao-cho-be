<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${news.title} - SunnyBear</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/tintuc_1.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
</head>
<body>

<!-- HEADER -->
<jsp:include page="header.jsp"/>

<!-- TITLE -->
<div class="title">
    <span>TIN TỨC / ${news.title}</span>
</div>

<!-- MAIN CONTENT -->
<main class="content">

    <article class="mainArticle">
        <h1>${news.title}</h1>

        <p class="meta">
            <i class="fa-regular fa-calendar"></i>
            <fmt:formatDate value="${news.createdAt}" pattern="dd/MM/yyyy"/>
        </p>

        <div class="news-thumbnail">
            <img src="${pageContext.request.contextPath}/${news.thumbnail}"
                 alt="${news.title}">
        </div>

        <p class="lead">
            ${news.shortDescription}
        </p>

        <!-- CONTENT HTML TỪ DATABASE -->
        <div class="article-content">
            ${news.content}
        </div>

        <p class="back">
            <a href="${pageContext.request.contextPath}/tin-tuc">
                ← Quay lại trang tin tức
            </a>
        </p>
    </article>

</main>

<!-- FOOTER -->
<jsp:include page="footer.jsp"/>

<script src="${pageContext.request.contextPath}/javaScript/header.js"></script>

</body>
</html>