package com.app;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import com.db.DB;

public class UpdateStatusServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String idStr = request.getParameter("id");
            String status = request.getParameter("status");

            if (idStr == null || status == null) {
                response.getWriter().println("Missing parameters");
                return;
            }

            int id = Integer.parseInt(idStr);

            Connection con = DB.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "UPDATE complaints SET status=? WHERE id=?"
            );

            ps.setString(1, status);
            ps.setInt(2, id);

            int updated = ps.executeUpdate();

            if (updated > 0) {
                response.sendRedirect("view.jsp");
            } else {
                response.getWriter().println("Update failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("ERROR: " + e.getMessage());
        }
    }
}