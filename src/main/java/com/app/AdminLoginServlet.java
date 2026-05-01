package com.app;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class AdminLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {

            if ("admin".equals(username) && "admin123".equals(password)) {

                HttpSession session = request.getSession();
                session.setAttribute("admin", username);

                response.sendRedirect("view.jsp");

            } else {
                response.getWriter().println("Invalid admin login");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("ERROR: " + e.getMessage());
        }
    }
}