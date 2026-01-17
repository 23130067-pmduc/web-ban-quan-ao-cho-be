<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<%
    request.setAttribute("pageCss", "thanhtoan.css");
    request.setAttribute("pageTitle" , "Thanh toán");
%>

<%@include file="header.jsp"%>
<!-- ========== PAYMENT ========== -->
<div class="title">
    <span>THANH TOÁN SẢN PHẦM</span>
</div>
<section class="payment">
    <div class="container">
        <div class="payment-content row">
            <div class="payment-content-left">
                <div class="payment-content-left-method-delivery">
                    <p style="font-weight: bold;">Phương thức giao hàng</p>
                    <div class="payment-content-left-method-delivery-item">
                        <input checked type="radio">
                        <label for="">Giao hàng chuyển phát nhanh</label>
                    </div>
                </div>
                <div class="payment-content-left-method-payment">
                    <p style="font-weight: bold;">Phương thức thanh toán</p>
                    <label>Mọi giao dịch đều được bảo mật và mã hóa. Thông tin thẻ tín dụng sẽ không bao giờ được lưu lại.</label>
                    <div class="payment-content-left-method-payment-item">
                        <input name="method-payment" type="radio">
                        <label for="">Thanh toán bằng thẻ tín dụng(OnePay)</label>
                    </div>
                    <div class="payment-content-left-method-payment-item-img">
                        <img src="./img/ttd.jpg" alt="">
                    </div>
                    <div class="payment-content-left-method-payment-item">
                        <input checked name="method-payment" type="radio">
                        <label for="">Thanh toán bằng thẻ ATM(OnePay)</label>
                    </div>
                    <div class="payment-content-left-method-payment-item-img">
                        <img src="./img/nganhang.jpg" alt="">
                    </div>
                    <div class="payment-content-left-method-payment-item">
                        <input name="method-payment" type="radio">
                        <label for="">Thanh toán MOMO</label>
                    </div>
                    <div class="payment-content-left-method-payment-item-img">
                        <img src="./img/momoo.jpg" alt="">
                    </div>
                    <div class="payment-content-left-method-payment-item">
                        <input name="method-payment" type="radio">
                        <label for="">Thanh toán khi nhận hàng</label>
                    </div>
                </div>

            </div>
            <div class="payment-content-right">
                <!-- Danh sách sản phẩm gọn, số lượng cố định 1 -->
                <div class="payment-cart">
                    <h3>Danh sách sản phẩm</h3>
                    <c:if test="${not empty checkoutItems}">
                        <table class="checkout-table">
                            <tr>
                                <th>Hình ảnh</th>
                                <th>Tên sản phẩm</th>
                                <th>Số lượng</th>
                                <th>Thành tiền</th>
                            </tr>

                            <c:set var="total" value="0"/>

                            <c:forEach var="item" items="${checkoutItems}">
                                <tr>
                                    <td>
                                        <img src="${item.product.thumbnail}" style="height:60px">
                                    </td>
                                    <td>${item.product.name}</td>
                                    <td>${item.quantity}</td>
                                    <td style="color:#c62828; font-weight:600">
                                        <fmt:formatNumber value="${item.price * item.quantity}" type="number"/>₫
                                    </td>
                                </tr>

                                <c:set var="total" value="${total + item.price * item.quantity}"/>
                            </c:forEach>
                        </table>

                        <div class="cart-total">
                            <p><b>Tổng tiền:</b>
                                <span style="color:#c62828; font-size:18px">
                                <fmt:formatNumber value="${total}" type="number"/>₫
                            </span>
                            </p>
                        </div>
                    </c:if>
                </div>

                <!-- 🧾 Thông tin người nhận hàng -->
                <div class="payment-content-left-customer-info">
                    <p style="font-weight: bold;">Thông tin người nhận hàng</p>

                    <div class="customer-info-item">
                        <label>Họ và tên:</label>
                        <input type="text" placeholder="Nhập họ và tên người nhận">
                    </div>

                    <div class="customer-info-item">
                        <label>Số điện thoại:</label>
                        <input type="text" placeholder="Nhập số điện thoại liên hệ">
                    </div>

                    <div class="customer-info-item">
                        <label>Địa chỉ nhận hàng:</label>
                        <input type="text" placeholder="Nhập địa chỉ nhận hàng cụ thể">
                    </div>

                    <div class="customer-info-item">
                        <label>Ghi chú (tuỳ chọn):</label>
                        <textarea placeholder="Ví dụ: Giao trong giờ hành chính, gọi trước khi giao..."></textarea>
                    </div>
                </div>
                <div class="payment-content-right-button">
                    <input type="text" placeholder="Mã giảm giá/ Quà tặng">
                    <button> <i class="fa-solid fa-check"></i> </button>
                </div>


            </div>
        </div>
        <div class="payment-content-right-payment">
            <a href="#" class="btn-pay">XÁC NHẬN THANH TOÁN</a>
        </div>
    </div>
</section>

<!-- ========== FOOTER ========== -->
<%@include file="footer.jsp"%>
<script src="./javaScript/giohang.js"></script>