package com.app;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import com.db.DB;
public class LogoutServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        session.invalidate();

        response.sendRedirect("index.html");
    }
}