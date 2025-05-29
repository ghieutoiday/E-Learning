/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import model.Lesson;
import model.User;
import model.UserLessonProgress;

/**
 *
 * @author ASUS
 */
public class UserLessonProgressDAO extends DBContext {

    private static UserLessonProgressDAO instance;

    public static UserLessonProgressDAO getInstance() {

        if (instance == null) {
            instance = new UserLessonProgressDAO();
        }

        return instance;
    }

    UserDAO userDAO = new UserDAO();
    LessonDAO lessonDAO = new LessonDAO();
    
    
    //Lấy 1 bài UserLessonProgress với ID cụ thể
    public UserLessonProgress getUserLessonProgressByUserLessonProgressID(int userLessonProgressID) {
        UserLessonProgress userLessonProgress = null;
        try {
            String sql = "Select * from UserLessonProgress where userLessonProgressID = " + userLessonProgressID;

            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                User user = userDAO.getUserByID(rs.getInt(2));
                Lesson lesson = lessonDAO.getLessonByLessonID(rs.getInt(3));
                String status = rs.getString(4);
                Date completedAt = rs.getDate(5);
                Date createdAt = rs.getDate(6);
                Date updatedAt = rs.getDate(7);
                //Lấy entity
                
                userLessonProgress = new UserLessonProgress(userLessonProgressID, user, lesson, status, completedAt, createdAt, updatedAt);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return userLessonProgress;
    }
    
    //Lấy tiến độ 1 khóa học của 1 user
    
    
    public static void main(String[] args) {
        UserLessonProgressDAO dao = new UserLessonProgressDAO();
        System.out.println(dao.getUserLessonProgressByUserLessonProgressID(24).getUpdatedAt());
    }
}
