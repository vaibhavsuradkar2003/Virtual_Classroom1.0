package servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;

import dao.AnnouncementDAO;
import model.Announcement;

@WebServlet("/addAnnouncement")
@MultipartConfig
public class AnnouncementServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {

        int classId = Integer.parseInt(req.getParameter("classId"));
        String message = req.getParameter("message");

        Part filePart = req.getPart("file");

        String fileName = "";
        if(filePart != null && filePart.getSize() > 0){
            fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();

            String uploadPath = getServletContext().getRealPath("") + "uploads";
            File uploadDir = new File(uploadPath);

            if(!uploadDir.exists()){
                uploadDir.mkdir();
            }

            filePart.write(uploadPath + File.separator + fileName);
        }

        Announcement a = new Announcement();
        a.setClassId(classId);
        a.setMessage(message);
        a.setFilePath(fileName);

        AnnouncementDAO dao = new AnnouncementDAO();
        dao.addAnnouncement(a);

        res.sendRedirect("classroom.jsp?id=" + classId);
    }
}