package vn.edu.nlu.fit.shopquanao.Controller;

import vn.edu.nlu.fit.shopquanao.Dao.AddressDao;
import vn.edu.nlu.fit.shopquanao.model.Address;
import vn.edu.nlu.fit.shopquanao.model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/dia-chi")
public class AddressController extends HttpServlet {

    private final AddressDao addressDao = new AddressDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userlogin") == null) {
            res.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("userlogin");

        List<Address> addressList = addressDao.getByUser(user.getId());

        req.setAttribute("addressList", addressList);
        req.getRequestDispatcher("/diachi.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userlogin") == null) {
            res.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("userlogin");
        String action = req.getParameter("action");

        if ("add".equals(action)) {
            Address a = new Address();
            a.setUserId(user.getId());
            a.setReceiverName(req.getParameter("receiverName"));
            a.setPhone(req.getParameter("phone"));
            a.setCity(req.getParameter("city"));
            a.setDistrict(req.getParameter("district"));
            a.setWard(req.getParameter("ward"));
            a.setDetailAddress(req.getParameter("detailAddress"));
            a.setDefaultAddress(req.getParameter("isDefault") != null);

            addressDao.insert(a);
        }

        if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            addressDao.softDelete(id, user.getId());
        }

        res.sendRedirect("dia-chi");
    }
}
