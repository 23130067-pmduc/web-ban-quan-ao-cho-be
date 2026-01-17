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
                    <table class="table table-bordered table-striped">
                        <tr>
                            <th>Chọn</th>
                            <th>Tên sản phẩm</th>
                            <th>Hình ảnh</th>
                            <th>Số lượng</th>
                            <th>Giá tiền</th>
                            <th>Xóa</th>
                        </tr>
                        <c:set var="count" value="1"/>
                        <c:forEach var="item" items="${sessionScope.cart.items}">
                            <tr>
                                <td>
                                    <input type="checkbox"
                                           class="item-check"
                                           data-id="${item.product.id}"
                                           data-price="${item.price}">
                                </td>

                                <td>
                                    <p>${item.product.name}</p>
                                </td>

                                <td>
                                    <img src="${item.product.thumbnail}" alt="${item.product.name}"style="height: 80px">
                                </td>

                                <td>
                                    <form action="update-cart"
                                          method="post"
                                          class="qty-form"
                                          style="display:flex; justify-content:center; align-items:center; gap:6px;">

                                        <input type="hidden" name="productId" value="${item.product.id}">

                                        <button type="button" class="btn-minus">−</button>

                                        <input type="text"
                                               name="quantity"
                                               class="qty-display"
                                               value="${item.quantity}"
                                               readonly
                                               style="width:40px; text-align:center;">

                                        <button type="button" class="btn-plus">+</button>
                                    </form>

                                </td>

                                <td>
                                    <fmt:formatNumber value="${item.price}" type="number"/>₫
                                </td>

                                <td>
                                    <form action="${pageContext.request.contextPath}/del-item" method="post"
                                        onsubmit="saveCheckedBeforeDelete(${item.product.id})">
                                        <input type="hidden" name="productId" value="${item.product.id}">
                                        <button type="submit"> <i class="fa fa-trash"></i></button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                            <tr>
                                <td>
                                    <input type="checkbox" id="checkAll">
                                </td>
                                <td colspan="5" style="text-align:center; font-weight:600">
                                    Chọn tất cả sản phẩm
                                </td>
                            </tr>

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
                    <td><span id="totalQuantity">0</span></td>
                </tr>

                <tr>
                    <td>TỔNG TIỀN HÀNG</td>
                    <td>
                        <span id="totalPrice">0</span>₫
                    </td>
                </tr>

                <tr>
                    <td>TẠM TÍNH</td>
                    <td style="font-weight:bold">
                        <span id="totalFinal">0</span>₫
                    </td>
                </tr>
            </table>


            <div class="card-content-right-button">
                <a href="san-pham">
                    <button id="ttms">TIẾP TỤC MUA SẮM</button>
                </a>

                <c:if test="${not empty sessionScope.cart && sessionScope.cart.totalQuantity > 0}">
                    <form action="checkout" method="post" id="checkoutForm" class="checkout-form">

                        <input type="hidden" name="selectedIds" id="selectedIds">

                        <button type="submit"
                                id="tt"
                                onclick="return prepareCheckout()">
                            THANH TOÁN
                        </button>
                    </form>
                </c:if>
            </div>

        </div>
    </div>
</section>


<!-- ========== FOOTER ========== -->
<%@include file="footer.jsp"%>
<script src="./javaScript/giohang.js"></script>