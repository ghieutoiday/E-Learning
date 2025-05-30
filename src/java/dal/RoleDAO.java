/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Role;
import org.apache.tomcat.dbcp.dbcp2.PoolingConnection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author gtrun
 */
public class RoleDAO extends DBContext{

    public RoleDAO() {
        super();
    }
    
    public Role getRole(int id){
        Role role = null;
        String sql = "SELECT TOP (1000) [roleID]\n"
                + "      ,[roleName]\n"
                + "  FROM [CourseManagementDB].[dbo].[Role]\n"
                + "  where roleID = ?";     
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {                
                role = new Role(rs.getInt("roleID"), rs.getString("roleName"));
            }          
        } catch (SQLException ex) {
            Logger.getLogger(RoleDAO.class.getName()).log(Level.SEVERE, null, ex);
        }   
        return role;
    }
    
    public static void main(String[] args) {
        RoleDAO roleDao = new RoleDAO();
        System.out.println(roleDao.getRole(1));
    }
    
    
    
}


