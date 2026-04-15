package dao;

import java.sql.*;
import java.util.*;
import model.Material;

public class MaterialDAO {

    // ✅ ADD MATERIAL
    public boolean addMaterial(Material m) {
        boolean status = false;

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "INSERT INTO materials(class_id, title, file_path, video_link) VALUES(?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setInt(1, m.getClassId());
            ps.setString(2, m.getTitle());
            ps.setString(3, m.getFilePath());
            ps.setString(4, m.getVideoLink());

            status = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // ✅ GET MATERIALS BY CLASS
    public List<Material> getMaterialsByClass(int classId) {
        List<Material> list = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "SELECT * FROM materials WHERE class_id=? ORDER BY id DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, classId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Material m = new Material();

                m.setId(rs.getInt("id"));
                m.setClassId(rs.getInt("class_id"));
                m.setTitle(rs.getString("title"));
                m.setFilePath(rs.getString("file_path"));
                m.setVideoLink(rs.getString("video_link"));

                list.add(m);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // ✅ DELETE MATERIAL
    public boolean deleteMaterial(int id) {
        boolean status = false;

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "DELETE FROM materials WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            status = ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }

    // ✅ GET SINGLE MATERIAL
    public Material getMaterialById(int id) {
        Material m = null;

        try (Connection conn = DBConnection.getConnection()) {

            String sql = "SELECT * FROM materials WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                m = new Material();

                m.setId(rs.getInt("id"));
                m.setClassId(rs.getInt("class_id"));
                m.setTitle(rs.getString("title"));
                m.setFilePath(rs.getString("file_path"));
                m.setVideoLink(rs.getString("video_link"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return m;
    }
}