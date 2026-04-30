package com.cinema.controller.Admin;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.cinema.dao.RoomDAO;
import com.cinema.model.Room;

@WebServlet("/admin/rooms")
public class AdminRoomServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private RoomDAO roomDAO = new RoomDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<Room> roomList = roomDAO.findAll();
        request.setAttribute("roomList", roomList);
        request.getRequestDispatcher("/pages/admin/room-manage.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        String error = null;

        try {
            if ("add".equals(action)) {
                Room r = buildRoomFromRequest(request);
                roomDAO.insert(r);
            } else if ("update".equals(action)) {
                Room r = buildRoomFromRequest(request);
                String idStr = request.getParameter("roomId");
                if (idStr != null && !idStr.isEmpty()) {
                    r.setRoomId(Integer.parseInt(idStr));
                    roomDAO.update(r);
                }
            } else if ("delete".equals(action)) {
                String idStr = request.getParameter("roomId");
                if (idStr != null && !idStr.isEmpty()) {
                    roomDAO.delete(Integer.parseInt(idStr));
                }
            } else if ("generateSeats".equals(action)) {
                int roomId = Integer.parseInt(request.getParameter("roomId"));
                int rows = Integer.parseInt(request.getParameter("rows"));
                int seatsPerRow = Integer.parseInt(request.getParameter("seatsPerRow"));
                roomDAO.generateDefaultSeats(roomId, rows, seatsPerRow);
            }
        } catch (Exception e) {
            error = "Lỗi thao tác: " + e.getMessage();
        }

        if (error != null) {
            request.setAttribute("error", error);
            doGet(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/rooms");
        }
    }

    private Room buildRoomFromRequest(HttpServletRequest request) {
        Room r = new Room();
        r.setRoomName(request.getParameter("roomName"));
        
        String seatsStr = request.getParameter("totalSeats");
        if (seatsStr != null && !seatsStr.isEmpty()) {
            r.setTotalSeats(Integer.parseInt(seatsStr));
        }
        
        String cinemaIdStr = request.getParameter("cinemaId");
        if (cinemaIdStr != null && !cinemaIdStr.isEmpty()) {
            r.setCinemaId(Integer.parseInt(cinemaIdStr));
        } else {
            r.setCinemaId(1); // Default cinema
        }
        
        return r;
    }
}
