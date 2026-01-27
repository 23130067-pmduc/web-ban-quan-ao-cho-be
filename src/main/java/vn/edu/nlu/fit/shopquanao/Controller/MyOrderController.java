package vn.edu.nlu.fit.shopquanao.Controller;
import vn.edu.nlu.fit.shopquanao.Dao.OrderItemDao;

import vn.edu.nlu.fit.shopquanao.Dao.OrderDao;
import vn.edu.nlu.fit.shopquanao.model.Order;
import vn.edu.nlu.fit.shopquanao.model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/don-mua")
public class MyOrderController extends HttpServlet {

    private final OrderDao orderDao = new OrderDao();
    private final OrderItemDao orderItemDao = new OrderItemDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userlogin") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("userlogin");

        // Lấy danh sách đơn hàng của user
        List<Order> orders = orderDao.getByUserId(user.getId());

        // Gắn item cho từng order
        for (Order o : orders) {
            o.setItems(orderItemDao.getByOrderId(o.getId()));
        }

        req.setAttribute("orders", orders);
        req.getRequestDispatcher("/donmua.jsp").forward(req, resp);
    }
}
