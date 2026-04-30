package com.app;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import com.db.DB;

public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Connection con = DB.getConnection();

            // 🔥 IMPORTANT SAFETY CHECK
            if (con == null) {
                response.getWriter().println("Database connection failed");
                return;
            }

            PreparedStatement ps = con.prepareStatement(
                "SELECT * FROM users WHERE email=? AND password=?"
            );

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                HttpSession session = request.getSession();
                session.setAttribute("user", email);

                response.sendRedirect("home.jsp");

            } else {

                response.getWriter().println("Invalid email or password");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Server error occurred. Check logs.");
        }
    }
}