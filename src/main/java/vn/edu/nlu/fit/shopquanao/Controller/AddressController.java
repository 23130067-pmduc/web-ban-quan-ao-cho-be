package vn.edu.nlu.fit.shopquanao.Controller;

import vn.edu.nlu.fit.shopquanao.Dao.AddressDao;
import vn.edu.nlu.fit.shopquanao.model.Address;
import vn.edu.nlu.fit.shopquanao.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/dia-chi")
public class AddressController extends HttpServlet {

    private final AddressDao dao = new AddressDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // 🔒 BẮT BUỘC LOGIN
        if (session == null || session.getAttribute("userlogin") == null) {
            res.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("userlogin");
        int userId = user.getId();

        List<Address> addressList = dao.getByUser(userId);

        req.setAttribute("addressList", addressList);
        req.getRequestDispatcher("/diachi.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);

        // 🔒 BẮT BUỘC LOGIN
        if (session == null || session.getAttribute("userlogin") == null) {
            res.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("userlogin");
        int userId = user.getId();

        String action = req.getParameter("action");

        // ========== ADD ==========
        if ("add".equals(action)) {
            Address a = new Address();
            a.setUserId(userId);
            a.setReceiverName(req.getParameter("receiverName"));
            a.setPhone(req.getParameter("phone"));
            a.setCity(req.getParameter("city"));          // ✅ ĐÃ FIX
            a.setDistrict(req.getParameter("district"));
            a.setWard(req.getParameter("ward"));
            a.setDetailAddress(req.getParameter("detailAddress"));
            a.setDefault(req.getParameter("isDefault") != null);

            dao.insert(a);
        }

        // ========== DELETE (SOFT) ==========
        if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            dao.softDelete(id, userId);
        }

        res.sendRedirect("dia-chi");
    }
}
