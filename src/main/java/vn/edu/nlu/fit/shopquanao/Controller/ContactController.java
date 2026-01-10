package vn.edu.nlu.fit.shopquanao.Controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.shopquanao.Service.ContactService;
import vn.edu.nlu.fit.shopquanao.model.Contact;
import vn.edu.nlu.fit.shopquanao.model.User;

import java.io.IOException;

@WebServlet("/lien-he")
public class ContactController extends HttpServlet {


    private ContactService contactService;

    @Override
    public void init() {
        contactService = new ContactService();
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/lienhe.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        User user = (User) request.getSession().getAttribute("userlogin");



        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String message = request.getParameter("message");



        Contact contact = new Contact();

        if (user != null){
            int userId = user.getId();
            contact.setUserId(userId);
        } else {
            contact.setUserId(0);
        }

        contact.setName(name);
        contact.setEmail(email);
        contact.setPhone(phone);
        contact.setMessage(message);
        contact.setAddress(address);
        contact.setStatus("Mới");

        contactService.addContact(contact);

        request.setAttribute("successMessage", "Thông tin liên hệ của bạn đã được gửi thành công!");

        request.getRequestDispatcher("/lienhe.jsp").forward(request, response);


    }
}