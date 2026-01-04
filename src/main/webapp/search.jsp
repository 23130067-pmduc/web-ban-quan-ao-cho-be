<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%
    request.setAttribute("pageCss", "search.css");
    request.setAttribute("pageTitle" , "Tìm kiếm");
%>
<%@include file="header.jsp"%>

<section class="products search-page">

    <h2 class="search-title">
        Kết quả tìm kiếm cho:
        <span class="keyword">"${param.keyword}"</span>
    </h2>

    <c:if test="${empty list}">
        <p class="search-empty">
            Không tìm thấy sản phẩm phù hợp.
        </p>
    </c:if>

    <div class="product-list search-results">
        <c:forEach var="p" items="${list}">
            <div class="product-card">
                <img src="${p.thumbnail}" alt="${p.name}">
                <h3>${p.name}</h3>

                <div class="price">
                    <c:choose>
                        <c:when test="${p.sale_price > 0}">
                            <span class="new-price">${p.sale_price}đ</span>
                            <span class="old-price">${p.price}đ</span>
                        </c:when>
                        <c:otherwise>
                            <span class="new-price">${p.price}đ</span>
                        </c:otherwise>
                    </c:choose>
                </div>

                <a class="btn-add" href="chi-tiet-san-pham?id=${p.id}">Xem chi tiết
                </a>
            </div>
        </c:forEach>
    </div>

</section>

<%@include file="footer.jsp"%>
