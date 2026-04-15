package dao;

import java.sql.*;
import java.util.*;
import model.ClassRoom;

public class ClassDAO {

    // ✅ CREATE CLASS
    public boolean createClass(ClassRoom c) {
        boolean status = false;

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "INSERT INTO classes(class_name, faculty_id, class_code, subject, section) VALUES(?,?,?,?,?)";

            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, c.getClassName());
            ps.setInt(2, c.getFacultyId());
            ps.setString(3, c.getClassCode());
            ps.setString(4, c.getSubject());
            ps.setString(5, c.getSection());

            status = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // ✅ GET ALL CLASSES
    public List<ClassRoom> getAllClasses() {
        List<ClassRoom> list = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "SELECT * FROM classes";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ClassRoom c = new ClassRoom();

                c.setId(rs.getInt("id"));
                c.setClassName(rs.getString("class_name"));
                c.setFacultyId(rs.getInt("faculty_id"));
                c.setClassCode(rs.getString("class_code"));
                c.setSubject(rs.getString("subject"));   // ✅ FIX
                c.setSection(rs.getString("section"));   // ✅ FIX

                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ✅ GET CLASSES BY FACULTY
    public List<ClassRoom> getClassesByFaculty(int facultyId) {
        List<ClassRoom> list = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "SELECT * FROM classes WHERE faculty_id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, facultyId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ClassRoom c = new ClassRoom();

                c.setId(rs.getInt("id"));
                c.setClassName(rs.getString("class_name"));
                c.setFacultyId(rs.getInt("faculty_id"));
                c.setClassCode(rs.getString("class_code"));

                // ✅ IMPORTANT FIX
                c.setSubject(rs.getString("subject"));
                c.setSection(rs.getString("section"));

                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ✅ GET CLASS BY CODE (JOIN CLASS)
    public ClassRoom getClassByCode(String code) {
        ClassRoom c = null;

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "SELECT * FROM classes WHERE class_code=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, code);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                c = new ClassRoom();

                c.setId(rs.getInt("id"));
                c.setClassName(rs.getString("class_name"));
                c.setFacultyId(rs.getInt("faculty_id"));
                c.setClassCode(rs.getString("class_code"));
                c.setSubject(rs.getString("subject"));   // ✅ FIX
                c.setSection(rs.getString("section"));   // ✅ FIX
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return c;
    }

    // ✅ DELETE CLASS
    public boolean deleteClass(int classId) {
        boolean status = false;

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "DELETE FROM classes WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, classId);

            status = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }
}