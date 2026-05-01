package com.app;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import com.db.DB;

public class ComplaintServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");

        HttpSession session = request.getSession();

        // ✅ GET logged-in user (NOT setAttribute)
        String user = (String) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.html");
            return;
        }

        String title = request.getParameter("subject");
        String desc = request.getParameter("description");
        String category = request.getParameter("category");

        try {
            Connection con = DB.getConnection();

            if (con == null) {
                response.getWriter().println("DB Connection failed");
                return;
            }

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO complaints(user_email, title, description, category, status) VALUES(?,?,?,?,?)"
            );

            ps.setString(1, user);
            ps.setString(2, title);
            ps.setString(3, desc);
            ps.setString(4, category);
            ps.setString(5, "Pending");

            int i = ps.executeUpdate();

            if (i > 0) {
                response.sendRedirect("view_status.jsp");
            } else {
                response.getWriter().println("Complaint not submitted");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("ERROR: " + e.getMessage());
        }
    }
}