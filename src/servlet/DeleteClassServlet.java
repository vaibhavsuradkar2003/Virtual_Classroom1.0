package servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;

import dao.ClassDAO;
import model.User;

@WebServlet("/deleteClass")
public class DeleteClassServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        // 🔐 Session validation
        HttpSession session = req.getSession(false);

        if(session == null || session.getAttribute("user") == null){
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        // 🔐 Only faculty can delete class
        if(!"faculty".equals(user.getRole())){
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        try {
            // 📥 Get class ID
            int classId = Integer.parseInt(req.getParameter("id"));

            // 🗑 Delete class
            ClassDAO dao = new ClassDAO();
            boolean status = dao.deleteClass(classId);

            // 🔁 Redirect with message
            if(status){
                res.sendRedirect(req.getContextPath() + "/faculty_dashboard.jsp?msg=deleted");
            } else {
                res.sendRedirect(req.getContextPath() + "/faculty_dashboard.jsp?msg=error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect(req.getContextPath() + "/faculty_dashboard.jsp?msg=error");
        }
    }
}