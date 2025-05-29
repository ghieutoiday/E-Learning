/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Course;
import model.PricePackage;
import model.Registration;
import model.User;

/**
 *
 * @author ASUS
 */
public class RegistrationDAO extends DBContext {

    private static RegistrationDAO instance;

    public static RegistrationDAO getInstance() {

        if (instance == null) {
            instance = new RegistrationDAO();
        }

        return instance;
    }

    UserDAO userDAO = new UserDAO();
    CourseDAO courseDAO = new CourseDAO();
    PricePackageDAO pricePackageDAO = new PricePackageDAO();

    public RegistrationDAO() {
        super();
    }

    public Registration getRegistrationByRegistrationID(int registrationID) {
        Registration registration = null;
        try {
            String sql = "Select * from Registration where registrationID = " + registrationID;

            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không

                User user = userDAO.getUserByID(rs.getInt(2));
                User lastUpdateBy = userDAO.getUserByID(rs.getInt(3));
                Course course = courseDAO.getCoureByCourseID(rs.getInt(4));
                PricePackage pricePackage = pricePackageDAO.getPricePackageByPricePackageID(rs.getInt(5));
                double totalCost = rs.getDouble(6);
                String status = rs.getString(7);
                Date registrationTime = rs.getDate(8);
                Date validFrom = rs.getDate(9);
                Date validTo = rs.getDate(10);

                //Lấy entity
                registration = new Registration(registrationID, user, lastUpdateBy, course, pricePackage, totalCost, status, registrationTime, validFrom, validTo);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return registration;
    }

    public List<Registration> getAllRegistration() {
        List<Registration> list = new ArrayList();
        try {
            String sql = "Select * from Registration";

            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                int id = rs.getInt(1);

                //Lấy entity
                Registration registration = getRegistrationByRegistrationID(id);
                list.add(registration);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    //Lọc và lấy ra hết Registration theo courseID
    //để từ đó thực hiện chức năng lấy Registration theo courseCategoryID
    public List<Registration> getAllRegistrationByCourseID(int courseID) {
        List<Registration> list = new ArrayList();
        try {
            String sql = "Select * from Registration where courseID =" + courseID;

            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                int id = rs.getInt(1);

                //Lấy entity
                Registration registration = getRegistrationByRegistrationID(id);
                list.add(registration);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    //Lọc và lấy Registration theo courseCategoryID
    public List<Registration> getAllRegistrationByCourseCategory(int courseCategoryID) {
        List<Registration> list = new ArrayList();
        List<Course> listCourse = courseDAO.getAllCoureByCategory(courseCategoryID);
        try {
            String sql = "Select * from Registration";

            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                int id = rs.getInt(1);

                //Lấy entity
                Registration registration = getRegistrationByRegistrationID(id);
                list.add(registration);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Registration> getAllRegistrationOfUserByUserID(int userID) {
        List<Registration> list = new ArrayList();
        try {
            String sql = "Select * from Registration where userID =" + userID;

            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                int id = rs.getInt(1);

                //Lấy entity
                Registration registration = getRegistrationByRegistrationID(id);
                list.add(registration);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    //Lọc và lấy Registration theo courseCategoryID
    public List<Registration> getAllRegistrationByCourseCategoryOfUser(int userID, int courseCategoryID) {
        List<Registration> list = new ArrayList();
        List<Course> listCourse = new ArrayList<>();
        if (courseCategoryID == 0) {
            listCourse = courseDAO.getAllCourse();
        } else {
            listCourse = courseDAO.getAllCoureByCategory(courseCategoryID);
        }
        try {
            for (Course course : listCourse) {
                String sql = "Select * from Registration where userID = ? AND courseID = ?";

                PreparedStatement ps = connection.prepareStatement(sql);
                ps.setInt(1, userID);
                ps.setInt(2, course.getCourseID());
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                    int id = rs.getInt(1);

                    //Lấy entity
                    Registration registration = getRegistrationByRegistrationID(id);
                    list.add(registration);
                }
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    //Lọc và lấy Registration theo mà có tên course ứng với tên course 
    //được input trong thanh search ở trang my-registration.jsp
    public List<Registration> getAllRegistrationByListCourseOfUser(int userID, List<Course> listCourse) {
        List<Registration> list = new ArrayList();
        try {
            for (Course course : listCourse) {
                String sql = "Select * from Registration where userID = ? AND courseID = ?";

                PreparedStatement ps = connection.prepareStatement(sql);
                ps.setInt(1, userID);
                ps.setInt(2, course.getCourseID());
                ResultSet rs = ps.executeQuery();

                while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                    int id = rs.getInt(1);

                    //Lấy entity
                    Registration registration = getRegistrationByRegistrationID(id);
                    list.add(registration);
                }
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    //Lấy ra những registration của user mà có status = paid
    public List<Registration> getAllRegistrationOfUserHavePaidStatus(int userID) {
        List<Registration> list = new ArrayList();
        try {
            String sql = "Select * from Registration where userID = ? AND status = 'Paid'";

            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                int id = rs.getInt(1);

                //Lấy entity
                Registration registration = getRegistrationByRegistrationID(id);
                list.add(registration);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public static void main(String[] args) {
        RegistrationDAO d = new RegistrationDAO();
        List<Registration> list = d.getAllRegistrationOfUserHavePaidStatus(5);
        for (Registration x : list) {
            System.out.println(x.getTotalLesson());
        }
    }

}
