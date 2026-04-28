import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import com.db.DB;

@WebServlet("/AdminLoginServlet")   // 🔥 VERY IMPORTANT
public class AdminLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // ✅ SAFE STRING COMPARISON
        if ("admin".equals(username) && "admin123".equals(password)) {

            HttpSession session = request.getSession();
            session.setAttribute("admin", username);

            // ✅ GO TO ADMIN DASHBOARD
            response.sendRedirect("view.jsp");

        } else {

            // ❌ WRONG LOGIN
            response.sendRedirect("admin_login.html");
        }
    }
}