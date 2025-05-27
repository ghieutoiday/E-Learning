/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Role;

/**
 *
 * @author gtrun
 */
public class UserDAO extends DBContext{

    public UserDAO() {
        super();
    }
    //Hàm getUser By ID
    public User getUser(int id){
        User user = null;
        String sql = "SELECT[userID]\n"
                + "      ,[fullName]\n"
                + "      ,[email]\n"
                + "      ,[password]\n"
                + "      ,[gender]\n"
                + "      ,[mobile]\n"
                + "      ,[roleID]\n"
                + "      ,[avatar]\n"
                + "      ,[status]\n"
                + "  FROM [CourseManagementDB].[dbo].[User]\n"
                + "  where userID = ?";
        
        RoleDAO roleDao = new RoleDAO();
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {    
                Role roleID = roleDao.getRole(rs.getInt("roleID"));
                user = new User(rs.getInt("userID"), rs.getString("fullName"), rs.getString("email"), rs.getString("password"),
                        rs.getString("gender"), rs.getString("mobile"), roleID, rs.getString("avatar"), rs.getString("status"));
                
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
  
        return user;
    }
    
    //Hàm getUserByEmail
    public User getUserByEmail(String email){
        User user = null;
        String sql = "SELECT TOP (1000) [userID]\n"
                + "      ,[fullName]\n"
                + "      ,[email]\n"
                + "      ,[password]\n"
                + "      ,[gender]\n"
                + "      ,[mobile]\n"
                + "      ,[roleID]\n"
                + "      ,[avatar]\n"
                + "      ,[status]\n"
                + "  FROM [CourseManagementDB].[dbo].[User]\n"
                + "  where email = ?";
        
        RoleDAO roleDao = new RoleDAO();
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {    
                //Role roleID = roleDao.getRole(rs.getInt(id));
                user = new User(rs.getInt("userID"), rs.getString("fullName"), rs.getString("email"), rs.getString("password"),
                        rs.getString("gender"), rs.getString("mobile"), null, rs.getString("avatar"), rs.getString("status"));
                
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
  
        return user;
    }
    
    //Hàm updatePassword
    public int UpdatePassword(String password, String email){
        int rs = 0;
        String sql = "UPDATE [dbo].[User]\n"
                + "SET [password] = ?\n"
                + "WHERE email = ?";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, password);
            ps.setString(2, email);
            rs = ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return rs;
    }
    
    
    public static void main(String[] args) {
        UserDAO u = new UserDAO();
        String email = "nguyenvanan@gmail.com";
        System.out.println(u.getUser(10));
    }
    
    
    
    
    
    
    
    
    
    
}
