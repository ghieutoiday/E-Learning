/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
//Hieu
import model.Course;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.CourseCategory;

/**
 *
 * @author gtrun
 */
public class CourseCategoryDAO extends DBContext{

    public CourseCategoryDAO() {
        super();
    }
    
    //Hàm getCourseCategory
    public CourseCategory getCategoryById(int id){
        CourseCategory courseCategory = null;
        
        String sql = "SELECT [courseCategoryID]\n"
                + "      ,[courseCategoryName]\n"
                + "  FROM [dbo].[CourseCategory]"
                + "where [courseCategoryID] = ?";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {                
                courseCategory = new CourseCategory(rs.getInt("courseCategoryID"), rs.getString("courseCategoryName"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseCategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }  
        return courseCategory;
    }
    
    //Hàm getAllCategory
    public List<CourseCategory> getAllCategory(){
        List<CourseCategory> list = new ArrayList<>();
        CourseCategory courseCategory = null;
        String sql = "SELECT [courseCategoryID]\n"
                + "      ,[courseCategoryName]\n"
                + "  FROM [dbo].[CourseCategory]";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {                
                courseCategory = new CourseCategory(rs.getInt("courseCategoryID"), rs.getString("courseCategoryName"));
                list.add(courseCategory);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseCategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    //Hàm lấy courseID từ name
    public CourseCategory getCategoryByName(String nameCategory){
        CourseCategory courseCategory = null;
        
        String sql = "SELECT [courseCategoryID]\n"
                + "      ,[courseCategoryName]\n"
                + "  FROM [dbo].[CourseCategory]"
                + "where [courseCategoryName] = ?";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, nameCategory);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {                
                courseCategory = new CourseCategory(rs.getInt("courseCategoryID"), rs.getString("courseCategoryName"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseCategoryDAO.class.getName()).log(Level.SEVERE, null, ex);
        }  
        return courseCategory;
    }
    
    public static void main(String[] args) {
        CourseCategoryDAO cd = new CourseCategoryDAO();
        CourseCategory c = cd.getCategoryByName("Web Development");
//        System.out.println(c.getCourseCategory());
    }
    
    
}
