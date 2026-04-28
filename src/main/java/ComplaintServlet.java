import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import com.db.DB;

public class ComplaintServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(); // ✅ FIXED
        String user = (String) session.getAttribute("user");

        if(user == null){
            response.sendRedirect("login.html");
            return;
        }

        String title = request.getParameter("subject"); // ❗ FIXED
        String desc = request.getParameter("description");
        String category = request.getParameter("category");
        try {
            Connection con = DB.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO complaints(user_email, title, description, category, status) VALUES(?,?,?,?,?)"
            );

            ps.setString(1, user);
            ps.setString(2, title);
            ps.setString(3, desc);
            ps.setString(4, category);
            ps.setString(5, "Pending");

            ps.executeUpdate();

            response.sendRedirect("view_status.jsp");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}