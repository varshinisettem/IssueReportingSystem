package com.app;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import com.db.DB;

public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        res.setContentType("text/html");

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        try {
            Connection con = DB.getConnection();

            // 🔥 CHECK IF EMAIL ALREADY EXISTS
            PreparedStatement check = con.prepareStatement(
                "SELECT * FROM users WHERE email=?"
            );
            check.setString(1, email);

            ResultSet rs = check.executeQuery();

            if (rs.next()) {
                res.getWriter().println("❌ Email already registered. Please use another email.");
                return;
            }

            // ✔ INSERT NEW USER
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO users(name,email,password) VALUES(?,?,?)"
            );

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);

            ps.executeUpdate();

            res.sendRedirect("login.html");

        } catch (Exception e) {
            e.printStackTrace();
            res.getWriter().println("ERROR: " + e.getMessage());
        }
    }
}