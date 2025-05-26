/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.PostCategory;

/**
 *
 * @author DELL
 */
public class PostCategoryDAO extends DBContext{
      public PostCategoryDAO() {
        super();
    }

    public PostCategory getCategoryByName(String categoryName) {
        String sql = "SELECT * FROM PostCategory WHERE postCategoryName = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, categoryName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                PostCategory category = new PostCategory();
                category.setPostCategoryID(rs.getInt("postCategoryID")); //
                category.setPostCategoryName(rs.getString("postCategoryName"));//
                category.setDescription(rs.getString("description"));
                return category;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public PostCategory getCategoryByID(int categoryID) {
        String sql = "SELECT * FROM PostCategory WHERE postCategoryID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, categoryID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                PostCategory category = new PostCategory();
                category.setPostCategoryID(rs.getInt("postCategoryID"));
                category.setPostCategoryName(rs.getString("postCategoryName"));
                category.setDescription(rs.getString("description"));
                return category;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
