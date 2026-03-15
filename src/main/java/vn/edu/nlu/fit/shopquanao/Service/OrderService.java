package vn.edu.nlu.fit.shopquanao.Service;

import vn.edu.nlu.fit.shopquanao.Dao.OrderDao;
import vn.edu.nlu.fit.shopquanao.model.*;

import java.util.List;

public class OrderService {
    private OrderDao dao = new OrderDao();

    public List<Order> getAllOrders() {
        return dao.getAll();
    }

    public Order findById(int id) {
        return dao.findById(id);
    }

    public List<OrderItem> getOrderItems(int orderId) {
        return dao.getItems(orderId);
    }

    public void updateStatus(int id, String status) {
        dao.updateStatus(id, status);
    }
    public String getUserEmailByOrderId(int orderId) {
        return dao.getUserEmailByOrderId(orderId);
    }

}
