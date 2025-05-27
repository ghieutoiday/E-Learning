/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.List;
import model.Course;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.CourseCategory;
import model.User;

/**
 *
 * @author gtrun
 */
public class CourseDAO extends DBContext{

    public CourseDAO() {
        super();
    }
    
    public List getAllCourse() {
        List<Course> list = new ArrayList<>();
        String sql = "SELECT [courseID]\n"
                + "      ,[courseName]\n"
                + "      ,[courseCategoryID]\n"
                + "      ,[thumbnail]\n"
                + "      ,[description]\n"
                + "      ,[ownerID]\n"
                + "      ,[status]\n"
                + "      ,[numberOfLesson]\n"
                + "      ,[createDate]\n"
                + "  FROM [CourseManagementDB].[dbo].[Course]";
        
        try {
            CourseCategoryDAO courseCategoryDao = new CourseCategoryDAO();
            UserDAO userDao = new UserDAO();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {                
                CourseCategory courseCategory = courseCategoryDao.getCategoryById(rs.getInt("courseCategoryID"));
                User user = userDao.getUser(rs.getInt("ownerID"));
                Course course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory, 
                        rs.getString("thumbnail"), rs.getString("description"), user, rs.getString("status"), rs.getInt("numberOfLesson"), rs.getDate("createDate"));
                list.add(course);
            }            
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }       
        return list;
    }
    
    //Hàm filter by categoryID
    public List<Course> getAllCoureByCategoryAndStatus(int categoryId, String status){
        List<Course> list = new ArrayList<>();
        Course course = null;
        String sql = "SELECT [courseID]\n"
                + "      ,[courseName]\n"
                + "      ,[courseCategoryID]\n"
                + "      ,[thumbnail]\n"
                + "      ,[description]\n"
                + "      ,[ownerID]\n"
                + "      ,[status]\n"
                + "      ,[numberOfLesson]\n"
                + "      ,[createDate]\n"
                + " FROM [dbo].[Course]\n"
                + " where [courseCategoryID] = ? and [status] = ?";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, categoryId);
            ps.setString(2, status);
            ResultSet rs = ps.executeQuery();
            CourseCategoryDAO courseCategoryDAO = new CourseCategoryDAO();
            UserDAO userDao = new UserDAO();
            while (rs.next()) {                
                CourseCategory courseCategory = courseCategoryDAO.getCategoryById(rs.getInt("courseCategoryID"));
                User user = userDao.getUser(rs.getInt("ownerID"));
                course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory, 
                        rs.getString("thumbnail"), rs.getString("description"), user, rs.getString("status"), rs.getInt("numberOfLesson"), rs.getDate("createDate"));
                list.add(course);               
            } 
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
        public List<Course> getAllCoureByCategory(int categoryId){
        List<Course> list = new ArrayList<>();
        Course course = null;
        String sql = "SELECT [courseID]\n"
                + "      ,[courseName]\n"
                + "      ,[courseCategoryID]\n"
                + "      ,[thumbnail]\n"
                + "      ,[description]\n"
                + "      ,[ownerID]\n"
                + "      ,[status]\n"
                + "      ,[numberOfLesson]\n"
                + "      ,[createDate]\n"
                + " FROM [dbo].[Course]\n"
                + " where [courseCategoryID] = ?";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            CourseCategoryDAO courseCategoryDAO = new CourseCategoryDAO();
            UserDAO userDao = new UserDAO();
            while (rs.next()) {                
                CourseCategory courseCategory = courseCategoryDAO.getCategoryById(rs.getInt("courseCategoryID"));
                User user = userDao.getUser(rs.getInt("ownerID"));
                course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory, 
                        rs.getString("thumbnail"), rs.getString("description"), user, rs.getString("status"), rs.getInt("numberOfLesson"), rs.getDate("createDate"));
                list.add(course);               
            } 
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    
    public static void main(String[] args) {
        CourseDAO courseDao = new CourseDAO();
        System.out.println(courseDao.getAllCoureByCategoryAndStatus(1, null).size());
    }
    
    
    
}
