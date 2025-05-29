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
import model.Post;
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


    public List<Registration> getRegistrationsByAllFilters(String emailSearch, String courseName, String name, String status, String sortBy, String sortOrder) {
        List<Registration> list = new ArrayList<>();

        try {
            StringBuilder sql = new StringBuilder
                     ("SELECT r.registrationID FROM Registration r "
                    + "JOIN [User] u ON r.userID = u.userID "
                    + "JOIN Course c ON r.courseID = c.courseID "
                    + "JOIN PricePackage p ON r.pricePackageID = p.pricePackageID "
                    + "LEFT JOIN [User] lu ON r.lastUpdateBy = lu.userID " // lấy tất cả các bản ghi từ bên trái là registration phù hợp với bản ghi bên phải là user
                    + "WHERE 1=1 "); // để có thể thêm các điều kiện khác ( AND )
            // Danh sách các giá trị tham số sẽ truyền vào câu SQL
            List<Object> params = new ArrayList<>();
            
            // Lọc theo email người dùng nếu có
            if (emailSearch != null && !emailSearch.trim().isEmpty()) {
                sql.append("AND LOWER(u.email) LIKE ? ");
                params.add("%" + emailSearch.toLowerCase() + "%");
            }
            // Lọc theo tên khóa học nếu có
            if (courseName != null && !courseName.trim().isEmpty()) {
                sql.append("AND c.courseName = ? ");
                params.add(courseName);
            }
            // Lọc theo tên gói học phí nếu có
            if (name != null && !name.trim().isEmpty()) {
                sql.append("AND p.name = ? ");
                params.add(name);
            }
            // Lọc theo trạng thái nếu có
            if (status != null && !status.trim().isEmpty()) {
                sql.append("AND r.status = ? ");
                params.add(status);
            }

            // Handle sorting
            // kiểm tra xem có yêu cầu sắp xếp không
            if (sortBy != null && !sortBy.trim().isEmpty()) {
                //Dựa vào giá trị sortBy, xác định cột thực tế trong SQL cần dùng để sắp xếp
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
                        orderColumn = "c.courseName";
                        break;
                    case "name":
                        orderColumn = "p.name";
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
                        orderColumn = "r.userID";
                }

                sql.append(" ORDER BY ").append(orderColumn).append(" ")  //  sắp xếp kết quả truy vấn theo yêu cầu của người dùng
                        .append("desc".equalsIgnoreCase(sortOrder) ? "DESC" : "ASC");
            }
            // chuyển đối tượng StringBuilder thành chuỗi hoàn chỉnh.
            PreparedStatement ps = connection.prepareStatement(sql.toString());
            //gán từng giá trị trong danh sách params vào các dấu ? trong câu SQL tương ứng.
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int registrationID = rs.getInt("registrationID");
                Registration registration = getRegistrationByRegistrationID(registrationID); //  lấy chi tiết thông tin Registration dựa vào registrationID từ hàm getRegistrationByRegistrationID() .
                list.add(registration);
            }

        } catch (SQLException e) {
            System.out.println("Error in getRegistrationsByAllFilters: " + e.getMessage());
        }

        return list;
    }

    public static void main(String[] args) {
        RegistrationDAO d = new RegistrationDAO();
        List<Registration> list = d.getAllRegistration();
        for (Registration x : list) {
            System.out.println(x.getUser().getFullName());
        }
    }
    

}
