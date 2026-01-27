package vn.edu.nlu.fit.shopquanao.Controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.shopquanao.Dao.OrderDao;
import vn.edu.nlu.fit.shopquanao.Dao.OrderItemDao;

import java.io.IOException;

@WebServlet(name = "OrderSuccessController", value = "/order-success")
public class OrderSuccessController extends HttpServlet {
    private OrderDao orderDao;
    private OrderItemDao orderItemDao;


    @Override
    public void init() {
        orderDao = new OrderDao();
        orderItemDao = new OrderItemDao();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userlogin") == null) {
            response.sendRedirect("login");
            return;
        }

        Integer orderId = (Integer) session.getAttribute("lastOrderId");
        if (orderId == null) {
            response.sendRedirect("trang-chu");
            return;
        }

        //Lấy order
        var order = orderDao.getById(orderId);
        if (order == null) {
            response.sendRedirect("trang-chu");
            return;
        }

        //Lấy order items
        var orderItems = orderItemDao.getByOrderId(orderId);

        //Set attribute cho JSP
        request.setAttribute("order", order);
        request.setAttribute("orderItems", orderItems);

        //Tránh F5 tạo lại đơn
        session.removeAttribute("lastOrderId");

        request.getRequestDispatcher("thanhtoanthanhcong.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}

