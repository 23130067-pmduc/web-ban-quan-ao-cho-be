<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="pageTitle" value="Tin tức - SunnyBear" scope="request"/>
<c:set var="pageCss" value="tintuc.css" scope="request"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/${pageCss}">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/7.0.1/css/all.min.css">
</head>
<body>

<!-- ========== HEADER (CHỈ 1 LẦN) ========== -->
<jsp:include page="header.jsp"/>

<!-- =========== SEARCH OVERLAY ============= -->
<div class="search-overlay" id="searchOverlay">
    <img class="logo" src="${pageContext.request.contextPath}/img/gau.jpg" alt="Logo">

    <!-- SEARCH ĐỘNG -->
    <form action="${pageContext.request.contextPath}/tin-tuc" method="get" class="boxSearch">
        <input type="text"
               name="search"
               placeholder="Tìm kiếm tin tức..."
               value="${param.search}">
        <button type="submit">
            <i class="fa-solid fa-magnifying-glass"></i>
        </button>
    </form>

    <span class="closeSearch" id="closeSearch">&times;</span>
</div>

<!-- =========== TITLE ============= -->
<div class="title">
    <span>TIN TỨC</span>
</div>

<!-- =========== MAIN ============= -->
<main class="container">
    <div class="newsContainer">

        <c:choose>
            <c:when test="${not empty newsList}">
                <c:forEach var="news" items="${newsList}">
                    <div class="newsItem">

                        <a href="${pageContext.request.contextPath}/tin-tuc?slug=${news.slug}">
                            <img src="${pageContext.request.contextPath}/${news.thumbnail}"
                                 alt="${news.title}">
                        </a>

                        <h3>
                            <a href="${pageContext.request.contextPath}/tin-tuc?slug=${news.slug}">
                                    ${news.title}
                            </a>
                        </h3>

                        <p>${news.shortDescription}</p>

                        <div class="news-meta">
                            <span class="news-date">
                                <i class="fa-regular fa-calendar"></i>
                                <fmt:formatDate value="${news.createdAt}" pattern="dd/MM/yyyy"/>
                            </span>
                        </div>
                    </div>
                </c:forEach>
            </c:when>

            <c:otherwise>
                <p style="text-align:center">Không có tin tức nào.</p>
            </c:otherwise>
        </c:choose>

    </div>

    <!-- ========== PAGINATION (chỉ khi không search) ========== -->
    <c:if test="${empty param.search && totalPages > 1}">
        <div class="pagination">
            <c:forEach begin="1" end="${totalPages}" var="pageNum">
                <a href="${pageContext.request.contextPath}/tin-tuc?page=${pageNum}"
                   class="${pageNum == currentPage ? 'active' : ''}">
                        ${pageNum}
                </a>
            </c:forEach>
        </div>
    </c:if>

</main>

<!-- ========== FOOTER ========== -->
<jsp:include page="footer.jsp"/>

<!-- ========== JS ========== -->
<script src="${pageContext.request.contextPath}/javaScript/header.js"></script>
<script src="${pageContext.request.contextPath}/javaScript/thongBao.js"></script>
<script src="${pageContext.request.contextPath}/javaScript/search.js"></script>

</body>
</html>
