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


    public static void main(String[] args) {
        RegistrationDAO d = new RegistrationDAO();
        List<Registration> list = d.getAllRegistration();
        for (Registration x : list) {
            System.out.println(x.getUser().getFullName());
        }
    }

}
