/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.PostCategory;

/**
 *
 * @author DELL
 */
public class PostCategoryDAO extends DBContext{
      public PostCategoryDAO() {
        super();
    }
    //Tìm và trả về một danh mục bài viết dựa trên tên danh mục 
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
    
    //Tìm và trả về một danh mục bài viết dựa trên ID 
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
    
    public List<PostCategory> getAllPostCategories() {
        List<PostCategory> categories = new ArrayList<>();
        String sql = "SELECT * FROM PostCategory";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                PostCategory category = new PostCategory();
                category.setPostCategoryID(rs.getInt("postCategoryID"));
                category.setPostCategoryName(rs.getString("postCategoryName"));
                categories.add(category);
            }
        } catch (SQLException e) {
            System.out.println("Error in getAllPostCategories: " + e.getMessage());
        }
        return categories;
    }
    
    public PostCategory getPostCategoryByID(int id) {
        String sql = "SELECT * FROM PostCategory WHERE postCategoryID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                PostCategory category = new PostCategory();
                category.setPostCategoryID(rs.getInt("postCategoryID"));
                category.setPostCategoryName(rs.getString("postCategoryName"));
                return category;
            }
        } catch (SQLException e) {
            System.out.println("Error in getPostCategoryByID: " + e.getMessage());
        }
        return null;
    }
}
