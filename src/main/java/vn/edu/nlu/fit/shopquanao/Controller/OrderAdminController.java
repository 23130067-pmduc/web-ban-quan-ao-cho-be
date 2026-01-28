package vn.edu.nlu.fit.shopquanao.Controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.shopquanao.Service.EmailService;
import vn.edu.nlu.fit.shopquanao.Service.OrderService;

import java.io.IOException;

@WebServlet(name = "OrderAdminController", value = "/order-admin")
public class OrderAdminController extends HttpServlet {

    private OrderService orderService;

    @Override
    public void init() {
        orderService = new OrderService();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String mode = req.getParameter("mode");

        if (mode == null) {
            var orders = orderService.getAllOrders();

            long pending = orders.stream()
                    .filter(o -> "PENDING".equals(o.getOrderStatus()))
                    .count();

            long completed = orders.stream()
                    .filter(o -> "COMPLETED".equals(o.getOrderStatus()))
                    .count();

            req.setAttribute("orders", orders);
            req.setAttribute("total", orders.size());
            req.setAttribute("countPending", pending);
            req.setAttribute("countCompleted", completed);

            req.getRequestDispatcher("/orderAdmin.jsp").forward(req, resp);
            return;
        }


        if ("view".equals(mode)) {
            int id = Integer.parseInt(req.getParameter("id"));
            req.setAttribute("order", orderService.findById(id));
            req.setAttribute("items", orderService.getOrderItems(id));
            req.getRequestDispatcher("/order-detail.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String action = req.getParameter("action");
        if (!"update".equals(action)) return;

        int id = Integer.parseInt(req.getParameter("id"));
        String newStatus = req.getParameter("orderStatus");

        // 1. Lấy order hiện tại
        var order = orderService.findById(id);
        if (order == null) {
            resp.sendRedirect("order-admin");
            return;
        }

        String currentStatus = order.getOrderStatus();

        // 2. Không cho sửa nếu đã kết thúc
        if ("COMPLETED".equals(currentStatus) || "CANCELLED".equals(currentStatus)) {
            resp.sendRedirect("order-admin?mode=view&id=" + id);
            return;
        }

        // 3. Chặn nhảy cóc
        if ("PENDING".equals(currentStatus) && "COMPLETED".equals(newStatus)) {
            resp.sendRedirect("order-admin?mode=view&id=" + id);
            return;
        }

        // 4. Update trạng thái
        orderService.updateStatus(id, newStatus);
        String userEmail = orderService.getUserEmailByOrderId(id);
        // 5. Gửi mail cho user
        EmailService.sendEmail(
                userEmail,
                "Cập nhật trạng thái đơn hàng #" + id,
                "Đơn hàng của bạn đã chuyển sang trạng thái: " + newStatus
        );

        resp.sendRedirect("order-admin?mode=view&id=" + id);
    }

}