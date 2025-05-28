/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.Course;
import model.PricePackage;

/**
 *
 * @author ASUS
 */


public class PricePackageDAO extends DBContext{

    public PricePackageDAO() {
        super();
    }
    
    CourseDAO courseDAO = new CourseDAO();
    
    public PricePackage getPricePackageByPricePackageID(int pricePackageId) {
        PricePackage pricePackage = null;
        try {
            String sql = "Select * from PricePackage where status = 'Active' AND pricePackageID = " + pricePackageId;

            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không

                Course course = courseDAO.getCoureByCourseID(rs.getInt(2));
                String name =rs.getString(3);
                int accessDuration = rs.getInt(4);
                double listPrice = rs.getDouble(5);
                double salePrice = rs.getDouble(6);
                String desc = rs.getString(7);
                String status = rs.getString(8);
                
                pricePackage = new PricePackage(pricePackageId, course, name, accessDuration, listPrice, salePrice, desc, status);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return pricePackage;
    }
    
    public static void main(String[] args) {
        PricePackageDAO dao = new PricePackageDAO();
        System.out.println(dao.getPricePackageByPricePackageID(1).getName());
    }
}
