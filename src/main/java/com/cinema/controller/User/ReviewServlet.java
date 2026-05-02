package com.cinema.controller.User;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.cinema.dao.ReviewDAO;
import com.cinema.model.Review;
import com.cinema.model.User;

@WebServlet("/movie/review")
public class ReviewServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("authUser") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("authUser");
        int movieId = Integer.parseInt(req.getParameter("movieId"));
        int rating = Integer.parseInt(req.getParameter("rating"));
        String content = req.getParameter("content");

        Review r = new Review();
        r.setMovieId(movieId);
        r.setUserId(user.getUserId());
        r.setRating(rating);
        r.setContent(content);

        ReviewDAO dao = new ReviewDAO();
        dao.insert(r);

        resp.sendRedirect(req.getContextPath() + "/movie/detail?id=" + movieId + "#reviews");
    }
}
