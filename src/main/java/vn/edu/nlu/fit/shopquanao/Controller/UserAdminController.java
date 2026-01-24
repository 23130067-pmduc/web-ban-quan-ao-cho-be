package vn.edu.nlu.fit.shopquanao.Controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.shopquanao.Service.UserService;
import vn.edu.nlu.fit.shopquanao.model.User;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "UserAdminController", value = "/user-admin")
public class UserAdminController extends HttpServlet {
    private UserService userService;

    @Override
    public void init(){
        userService = new UserService();
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String mode = request.getParameter("mode");

        if(mode == null){
            List<User> users = userService.getAllUser();

            int total = users.size();
            int countInWeek = userService.getCountInWeek();
            int countActive = userService.getCountActive();
            int countBlock = userService.getCountBlock();

            String keyword = request.getParameter("keyword");

            if (keyword != null && !keyword.trim().isEmpty()) {
                users = userService.searchByUsernameOrEmail(keyword);
            }


            request.setAttribute("total", total);
            request.setAttribute("countInWeek", countInWeek);
            request.setAttribute("countActive", countActive);
            request.setAttribute("countBlock", countBlock);
            request.setAttribute("users", users);
            request.getRequestDispatcher("/userAdmin.jsp").forward(request,response);
            return;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}