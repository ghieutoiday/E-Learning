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
    
    public List<Registration> getAllRegistrationAfterSort(String sortBy, String sortOrder) {
    List<Registration> list = new ArrayList<>();

    try {
        String sql = "SELECT r.*, u.email, c.courseName, pp.name, lu.fullName " +
                     "FROM Registration r " +
                     "JOIN [User] u ON r.userID = u.userID " +
                     "JOIN Course c ON r.courseID = c.courseID " +
                     "JOIN PricePackage pp ON r.pricePackageID = pp.pricePackageID " +
                     "LEFT JOIN [User] lu ON r.lastUpdateBy = lu.userID ";  //dùng LEFT JOIN để phòng trường hợp lastUpdateBy là NULL.

        if (sortBy != null && !sortBy.trim().isEmpty()) {
            String orderColumn;

            switch (sortBy) {
                case "userID":
                    orderColumn = "r.userID";
                    break;
                case "email":
                    orderColumn = "u.email";
                    break;
                case "registrationTime":
                    orderColumn = "r.registrationTime";
                    break;
                case "courseName":
                    orderColumn = "c.courseName"; // Sort theo tên khóa học
                    break;
                case "name":
                    orderColumn = "pp.name";  // sort theo tên gói
                    break;
                case "totalCost":
                    orderColumn = "r.totalCost";
                    break;
                case "status":
                    orderColumn = "r.status";
                    break;
                case "validFrom":
                    orderColumn = "r.validFrom";
                    break;
                case "validTo":
                    orderColumn = "r.validTo";
                    break;
                case "fullName":
                    orderColumn = "lu.fullName";
                    break;
                default:
                    orderColumn = "r.registrationID";
            }


            sql += " ORDER BY " + orderColumn;

            if ("desc".equalsIgnoreCase(sortOrder)) {
                sql += " DESC";
            } else {
                sql += " ASC";
            }
        }

        PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            int id = rs.getInt("registrationID");

            // Giả sử bạn đã có hàm getRegistrationByRegistrationID
            Registration registration = getRegistrationByRegistrationID(id);
            list.add(registration);
        }

    } catch (SQLException e) {
        System.out.println("Error in getAllRegistration: " + e.getMessage());
    }

    return list;
}




//    public static void main(String[] args) {
//        RegistrationDAO d = new RegistrationDAO();
//        List<Registration> list = d.getAllRegistration();
//        for (Registration x : list) {
//            System.out.println(x.getUser().getFullName());
//        }
//    }
    
    
    public static void main(String[] args) {
        // Tạo instance DAO
        RegistrationDAO dao = new RegistrationDAO();

        // Gọi hàm getAllRegistration và sắp xếp theo totalCost giảm dần
        List<Registration> registrations = dao.getAllRegistrationAfterSort("fullName", "desc");

        // In kết quả
        for (Registration reg : registrations) {
            System.out.println("================================");
            System.out.println("Registration ID: " + reg.getRegistrationID());
            System.out.println("User ID: " + reg.getUser().getUserID()); // Nếu bạn có User object
            System.out.println("Course ID: " + reg.getCourse().getCourseName()); // Nếu có Course object
            System.out.println("Price Package ID: " + reg.getPricePackage().getName()); // Nếu có PricePackage object
            System.out.println("Total Cost: " + reg.getTotalCost());
            System.out.println("Status: " + reg.getStatus());
            System.out.println("Registration Time: " + reg.getRegistrationTime());
            System.out.println("Valid From: " + reg.getValidFrom());
            System.out.println("Valid To: " + reg.getValidTo());
            System.out.println("Last Update By: " + reg.getLastUpdateBy().getFullName());
        }
    }



}
