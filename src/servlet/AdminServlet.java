package servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import java.sql.*;
import dao.DBConnection;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        String action = req.getParameter("action");
        String id = req.getParameter("id");

        String path = req.getContextPath();

        try (Connection conn = DBConnection.getConnection()) {

            // ✅ APPROVE USER
            if ("approve".equals(action)) {
                String sql = "UPDATE users SET status='approved' WHERE id=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, Integer.parseInt(id));
                ps.executeUpdate();
            }

            // ❌ REJECT USER (keep user but change status)
            else if ("reject".equals(action)) {
                String sql = "UPDATE users SET status='rejected' WHERE id=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, Integer.parseInt(id));
                ps.executeUpdate();
            }

            // 🗑 DELETE USER (remove permanently)
            else if ("delete".equals(action)) {
                String sql = "DELETE FROM users WHERE id=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, Integer.parseInt(id));
                ps.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        res.sendRedirect(path + "/manage_users.jsp");
    }
}