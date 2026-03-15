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
                <c:when test="${empty cartItems}">
                    <p style="text-align:center; padding:40px; font-size:18px;">
                        🛒 Giỏ hàng của bạn đang trống
                    </p>
                </c:when>

                <c:otherwise>
                    <table border="1" cellpadding="10" cellspacing="0" width="100%">
                        <thead>
                        <tr>
                            <th>Sản phẩm</th>
                            <th>Phân loại</th>
                            <th>Số lượng</th>
                            <th>Thành tiền</th>
                            <th>Xóa</th>
                        </tr>
                        </thead>

                        <tbody>
                        <c:set var="count" value="1"/>
                        <c:forEach var="item" items="${cartItems}">
                            <tr data-price="${item.price}">
                                <!-- SẢN PHẨM -->
                                <td>
                                    <img src="${item.product.thumbnail}" width="60">
                                    <br>
                                        ${item.product.name}
                                </td>

                                <!-- SIZE + MÀU -->
                                <td>
                                    Size: <b>${item.size}</b><br>
                                    Màu: <b>${item.color}</b>
                                </td>


                                <!-- UPDATE SỐ LƯỢNG -->
                                <td>
                                    <form action="update-cart"
                                          method="post"
                                          class="qty-form"
                                          style="display:flex; justify-content:center; align-items:center; gap:6px;">

                                        <input type="hidden" name="variantId" value="${item.variantId}">

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
                                <!-- THÀNH TIỀN -->
                                <td>
                                    <fmt:formatNumber value="${item.price * item.quantity}" type="number"/> ₫
                                </td>

                                </td>

                                <!-- XÓA -->
                                <td>
                                    <form action="del-item" method="post">
                                        <input type="hidden" name="variantId" value="${item.variantId}">
                                        <button type="submit"> <i class="fa fa-trash"></i></button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
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

                <c:if test="${not empty cartItems}">
                    <form action="${pageContext.request.contextPath}/checkout" method="post" id="checkoutForm" class="checkout-form">

                        <button type="submit" id="tt">
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