package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Slider;

public class SliderDAO extends DBContext {
    private static final String SELECT_ACTIVE_SLIDERS = 
        "SELECT [sliderID], [title], [image], [backlink], [status], [notes] " +
        "FROM [CourseManagementDB].[dbo].[Slider] " +
        "WHERE [status] = 'Active' " +
        "ORDER BY [sliderID] DESC";

    private static final String SELECT_SLIDER_BY_ID = 
        "SELECT TOP (1) [sliderID], [title], [image], [backlink], [status], [notes] " +
        "FROM [CourseManagementDB].[dbo].[Slider] " +
        "WHERE [sliderID] = ?";

    private static final String INSERT_SLIDER = 
        "INSERT INTO [CourseManagementDB].[dbo].[Slider] ([title], [image], [backlink], [status], [notes]) " +
        "VALUES (?, ?, ?, ?, ?)";

    private static final String UPDATE_SLIDER = 
        "UPDATE [CourseManagementDB].[dbo].[Slider] " +
        "SET [title] = ?, [image] = ?, [backlink] = ?, [status] = ?, [notes] = ? " +
        "WHERE [sliderID] = ?";

    private static final String DELETE_SLIDER = 
        "DELETE FROM [CourseManagementDB].[dbo].[Slider] " +
        "WHERE [sliderID] = ?";

    private static final String SELECT_ALL_SLIDERS = 
        "SELECT [sliderID], [title], [image], [backlink], [status], [notes] " +
        "FROM [CourseManagementDB].[dbo].[Slider] " +
        "ORDER BY [sliderID] DESC";

    public SliderDAO() {
        super();
    }

    public List<Slider> getActiveSliders() {
        List<Slider> sliders = new ArrayList<>();
        try (PreparedStatement stmt = connection.prepareStatement(SELECT_ACTIVE_SLIDERS);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Slider slider = new Slider();
                slider.setSliderID(rs.getInt("sliderID"));
                slider.setTitle(rs.getString("title"));
                slider.setImage(rs.getString("image"));
                slider.setBacklink(rs.getString("backlink"));
                slider.setStatus(rs.getString("status"));
                slider.setNotes(rs.getString("notes"));
                sliders.add(slider);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sliders;
    }

    public Slider getSliderById(int id) {
        try (PreparedStatement stmt = connection.prepareStatement(SELECT_SLIDER_BY_ID)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Slider slider = new Slider();
                    slider.setSliderID(rs.getInt("sliderID"));
                    slider.setTitle(rs.getString("title"));
                    slider.setImage(rs.getString("image"));
                    slider.setBacklink(rs.getString("backlink"));
                    slider.setStatus(rs.getString("status"));
                    slider.setNotes(rs.getString("notes"));
                    return slider;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addSlider(Slider slider) {
        try (PreparedStatement stmt = connection.prepareStatement(INSERT_SLIDER)) {
            stmt.setString(1, slider.getTitle());
            stmt.setString(2, slider.getImage());
            stmt.setString(3, slider.getBacklink());
            stmt.setString(4, slider.getStatus());
            stmt.setString(5, slider.getNotes());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateSlider(Slider slider) {
        try (PreparedStatement stmt = connection.prepareStatement(UPDATE_SLIDER)) {
            stmt.setString(1, slider.getTitle());
            stmt.setString(2, slider.getImage());
            stmt.setString(3, slider.getBacklink());
            stmt.setString(4, slider.getStatus());
            stmt.setString(5, slider.getNotes());
            stmt.setInt(6, slider.getSliderID());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteSlider(int id) {
        try (PreparedStatement stmt = connection.prepareStatement(DELETE_SLIDER)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Slider> getAllSliders() {
        List<Slider> sliders = new ArrayList<>();
        try (PreparedStatement stmt = connection.prepareStatement(SELECT_ALL_SLIDERS);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Slider slider = new Slider();
                slider.setSliderID(rs.getInt("sliderID"));
                slider.setTitle(rs.getString("title"));
                slider.setImage(rs.getString("image"));
                slider.setBacklink(rs.getString("backlink"));
                slider.setStatus(rs.getString("status"));
                slider.setNotes(rs.getString("notes"));
                sliders.add(slider);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sliders;
    }

    public List<Slider> getFilteredSliders(String search, String status, int page, int rowsPerPage) {
        List<Slider> sliders = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT [sliderID], [title], [image], [backlink], [status], [notes] " +
            "FROM [CourseManagementDB].[dbo].[Slider] " +
            "WHERE 1=1 ");
        
        List<Object> params = new ArrayList<>();
        
        if (search != null && !search.trim().isEmpty()) {
            sql.append("AND ([title] LIKE ? OR [backlink] LIKE ?) ");
            params.add("%" + search + "%");
            params.add("%" + search + "%");
        }
        
        if (status != null && !status.isEmpty()) {
            sql.append("AND [status] = ? ");
            params.add(status);
        }
        
        // Add sorting
        sql.append("ORDER BY ");
         sql.append("[sliderID] ASC");
        
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        
        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            stmt.setInt(params.size() + 1, (page - 1) * rowsPerPage);
            stmt.setInt(params.size() + 2, rowsPerPage);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Slider slider = new Slider();
                    slider.setSliderID(rs.getInt("sliderID"));
                    slider.setTitle(rs.getString("title"));
                    slider.setImage(rs.getString("image"));
                    slider.setBacklink(rs.getString("backlink"));
                    slider.setStatus(rs.getString("status"));
                    slider.setNotes(rs.getString("notes"));
                    sliders.add(slider);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sliders;
    }

    public int getTotalFilteredSliders(String search, String status) {
        StringBuilder sql = new StringBuilder(
            "SELECT COUNT(*) " +
            "FROM [CourseManagementDB].[dbo].[Slider] " +
            "WHERE 1=1 ");
        
        List<Object> params = new ArrayList<>();
        
        if (search != null && !search.trim().isEmpty()) {
            sql.append("AND ([title] LIKE ? OR [backlink] LIKE ?) ");
            params.add("%" + search + "%");
            params.add("%" + search + "%");
        }
        
        if (status != null && !status.isEmpty()) {
            sql.append("AND [status] = ? ");
            params.add(status);
        }
        
        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
} 