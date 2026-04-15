package servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;

import dao.MaterialDAO;
import model.Material;

@WebServlet("/uploadMaterial")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 1,   // 1 MB
    maxFileSize = 1024 * 1024 * 50,        // 50 MB (video support)
    maxRequestSize = 1024 * 1024 * 100     // 100 MB
)
public class UploadMaterialServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        int classId = Integer.parseInt(req.getParameter("classId"));
        String title = req.getParameter("title");
        String videoLink = req.getParameter("videoLink");

        Part filePart = req.getPart("file");

        String fileName = null;

        // ===== FILE UPLOAD LOGIC =====
        if (filePart != null && filePart.getSize() > 0) {

            String originalName = filePart.getSubmittedFileName();

            // Create unique file name
            fileName = System.currentTimeMillis() + "_" + originalName;

            // Upload path
            String uploadPath = getServletContext().getRealPath("/uploads");
            File uploadDir = new File(uploadPath);

            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            // Save file
            filePart.write(uploadPath + File.separator + fileName);
        }

        // ===== SAVE DATA =====
        Material m = new Material();
        m.setClassId(classId);
        m.setTitle(title);
        m.setFilePath(fileName);   // may be null if only video link
        m.setVideoLink(videoLink);

        MaterialDAO dao = new MaterialDAO();
        dao.addMaterial(m);

        // ===== REDIRECT BACK TO MATERIAL TAB =====
        res.sendRedirect("classroom.jsp?id=" + classId + "&tab=material");
    }
}