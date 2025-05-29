/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Course;
import model.Lesson;

/**
 *
 * @author ASUS
 */
public class LessonDAO extends DBContext {

    private static LessonDAO instance;

    public static LessonDAO getInstance() {

        if (instance == null) {
            instance = new LessonDAO();
        }

        return instance;
    }

    CourseDAO courseDAO = new CourseDAO();

    //Lấy 1 bài Lesson với ID cụ thể
    public Lesson getLessonByLessonID(int lessonId) {
        Lesson lesson = null;
        try {
            String sql = "Select * from Lesson where status = 'Active' AND lessonId = " + lessonId;

            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                Course course = courseDAO.getCoureByCourseID(rs.getInt(2));
                String name = rs.getString(3);
                String contentHtml = rs.getString(4);
                String contentVideo = rs.getString(5);
                String type = rs.getString(6);
                int orderNum = rs.getInt(7);
                String status = rs.getString(8);
                //Lấy entity
                lesson = new Lesson(lessonId, course, name, contentHtml, contentVideo, type, orderNum, status);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return lesson;
    }

    //Lấy số Lesson trong 1 khóa học mà có trạng thái là Active
    public int getTotalNumberOfLessonInCourse(int courseID) {
        int total = -1;
        try {
            String sql = """
                         SELECT COUNT(*) AS totalActiveLessons
                         FROM Lesson l
                         WHERE l.courseID = ?
                         AND l.status = 'Active';""";

            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, courseID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                total = rs.getInt(1);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }

        return total;
    }

    //Lấy số Lesson trong 1 khóa học mà có trạng thái là Active
    //và người dùng đã hoàn thành
    public int getTotalNumberOfCompletedLessonInCourse(int userID, int courseID) {
        int total = -1;
        try {
            String sql =  """
                          SELECT COUNT(*) AS lessonsCompleted
                          FROM UserLessonProgress ulp
                          JOIN Lesson l ON ulp.lessonID = l.lessonID
                          JOIN Registration r ON r.userID = ulp.userID AND r.courseID = l.courseID
                          WHERE ulp.userID = ?
                          AND l.courseID = ?
                          AND ulp.status = 'Completed'
                          AND l.status = 'Active'
                          AND r.status IN ('Submitted', 'Paid');
                          """;

            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setInt(2, courseID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                total = rs.getInt(1);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }

        return total;
    }

    public static void main(String[] args) {
        System.out.println(LessonDAO.getInstance().getTotalNumberOfCompletedLessonInCourse(5,4));
    }
}
