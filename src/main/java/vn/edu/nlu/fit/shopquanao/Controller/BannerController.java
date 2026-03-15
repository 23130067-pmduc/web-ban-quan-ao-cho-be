package vn.edu.nlu.fit.shopquanao.Controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import vn.edu.nlu.fit.shopquanao.Service.BannerService;
import vn.edu.nlu.fit.shopquanao.model.Banner;

import java.io.IOException;
import java.util.List;

public class BannerController extends HttpServlet {

    private BannerService bannerService;

    @Override
    public void init() {
        bannerService = new BannerService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        List<Banner> banners = bannerService.getActiveBanners();

        request.setAttribute("banners", banners);
        request.getRequestDispatcher("/trangchu.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}