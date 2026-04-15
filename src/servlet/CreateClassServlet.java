package servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;

import dao.ClassDAO;
import model.ClassRoom;

@WebServlet("/createClass")
public class CreateClassServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException {

        String className = req.getParameter("className");
        String subject = req.getParameter("subject");
        String section = req.getParameter("section");

        int facultyId = Integer.parseInt(req.getParameter("facultyId"));

        // ✅ USE CUSTOM CODE GENERATOR
        String classCode = generateClassCode();

        ClassRoom c = new ClassRoom();
        c.setClassName(className);
        c.setSubject(subject);
        c.setSection(section);
        c.setFacultyId(facultyId);
        c.setClassCode(classCode);

        ClassDAO dao = new ClassDAO();
        dao.createClass(c);

        res.sendRedirect(req.getContextPath() + "/faculty_dashboard.jsp");
    }

    // ✅ CUSTOM CLASS CODE (123abcde)
    private String generateClassCode() {

        String numbers = String.valueOf((int)(Math.random() * 900) + 100);

        String letters = "";
        String alphabet = "abcdefghijklmnopqrstuvwxyz";

        for(int i=0; i<5; i++){
            letters += alphabet.charAt((int)(Math.random() * alphabet.length()));
        }

        return numbers + letters;
    }
}