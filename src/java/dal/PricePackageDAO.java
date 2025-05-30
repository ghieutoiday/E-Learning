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
            String sql = "Select * from PricePackage where pricePackageID = " + pricePackageId;

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
    
    //get all pricePackage
    public List getAllPricePackage() {
        List<PricePackage> list = new ArrayList<>();
        

        try {
            String sql = "SELECT * FROM PricePackage";
            
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                //Lấy PricePackage
                PricePackage pricePackage = getPricePackageByPricePackageID(rs.getInt(1));
                list.add(pricePackage);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    public List<PricePackage> getAllDistinctPricePackagesByName() {
        List<PricePackage> list = new ArrayList<>();

        try {
            //  lọc ra các bản ghi PricePackage với tên name duy nhất (không trùng nhau).
            // Mỗi name chỉ lấy 1 bản ghi đại diện (bản ghi có pricePackageID nhỏ nhất).
            String sql = "SELECT * FROM PricePackage WHERE pricePackageID IN ( "
                    + "SELECT MIN(pricePackageID) FROM PricePackage GROUP BY name )";

            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("pricePackageID");
                PricePackage pkg = getPricePackageByPricePackageID(id);
                list.add(pkg);
            }

        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        }

        return list;
    }
    
    public static void main(String[] args) {
        PricePackageDAO dao = new PricePackageDAO();
        System.out.println(dao.getPricePackageByPricePackageID(1).getName());
    }
}
