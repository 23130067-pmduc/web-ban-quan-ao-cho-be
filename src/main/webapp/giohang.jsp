<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>


<%
    request.setAttribute("pageCss", "giohang.css");
    request.setAttribute("pageTitle" , "Giỏ hàng");
%>

<%@include file="header.jsp"%>

<!-- ============MAIN GIỎ HÀNG ==================== -->
<div class="title">
    <span>GIỎ HÀNG CỦA BẠN</span>
</div>
<section class="card">

    <div class="container">
        <div class="card-content-left">
            <c:choose>
                <c:when test="${empty sessionScope.cart || empty sessionScope.cart.items}">
                    <p style="text-align:center; padding:40px; font-size:18px;">
                        🛒 Giỏ hàng của bạn đang trống
                    </p>
                </c:when>

                <c:otherwise>
                    <table>
                        <tr>
                            <th>Sản phẩm</th>
                            <th>Tên sản phẩm</th>
                            <th>Số lượng</th>
                            <th>Thành tiền</th>
                            <th>Xóa</th>
                        </tr>

                        <c:forEach var="item" items="${sessionScope.cart.items}">
                            <tr>
                                <td>
                                    <img src="${item.product.thumbnail}" alt="${item.product.name}">
                                </td>

                                <td>
                                    <p>${item.product.name}</p>
                                </td>

                                <td>
                                    <input type="number"
                                           value="${item.quantity}"
                                           min="1"
                                           readonly>
                                </td>

                                <td>
                                    <fmt:formatNumber
                                            value="${item.quantity * item.price}"
                                            type="number"/>₫
                                </td>

                                <td>
                                    <a href="remove-cart?productId=${item.product.id}">
                                        <span style="cursor:pointer">X</span>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:otherwise>
            </c:choose>

        </div>
        <div class="card-content-right">
            <table>
                <tr>
                    <th colspan="2">TỔNG TIỀN GIỎ HÀNG</th>
                </tr>

                <tr>
                    <td>TỔNG SẢN PHẨM</td>
                    <td>${sessionScope.cart.totalQuantity}</td>
                </tr>

                <tr>
                    <td>TỔNG TIỀN HÀNG</td>
                    <td>
                        <fmt:formatNumber value="${sessionScope.cart.total()}" type="number"/>₫
                    </td>
                </tr>

                <tr>
                    <td>TẠM TÍNH</td>
                    <td style="font-weight:bold">
                        <fmt:formatNumber value="${sessionScope.cart.total()}" type="number"/>₫
                    </td>
                </tr>
            </table>


            <div class="card-content-right-button">
                <a href="san-pham">
                    <button id="ttms">TIẾP TỤC MUA SẮM</button>
                </a>

                <c:if test="${not empty sessionScope.cart && sessionScope.cart.totalQuantity > 0}">
                    <a href="thanhtoan.jsp">
                        <button id="tt">THANH TOÁN</button>
                    </a>
                </c:if>
            </div>

        </div>
    </div>
</section>


<!-- ========== FOOTER ========== -->
<%@include file="footer.jsp"%>