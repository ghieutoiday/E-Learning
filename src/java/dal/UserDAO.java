/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Role;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.User;

/**
 *
 * @author ACER
 */
public class UserDAO extends DBContext {

    public UserDAO() {
        super();
    }

    //Lấy ra đối tượng Role từ roleID truyền vào
    public Role getRoleByID(int id) {
        Role role = null;

        try {
            String sql = "select * from Role where roleID = " + id;
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            //Kiểm tra xem còn dữ liệu trong rs hay không
            while (rs.next()) {
                //Lấy cột thứ 2 trong bảng Role - tương ứng với cột roleName
                String roleName = rs.getString(2);

                //Lấy ra đối tượng Role
                role = new Role(id, roleName);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return role;
    }

    //Lấy ra đối tượng User từ userID truyền vô
    public User getUserByID(int id) {
        User user = null;

        try {
            String sql = "select * from [User] where userID = " + id;
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            //Kiểm tra xem còn dữ liệu trong rs hay không
            if (rs.next()) {
                String fullName = rs.getString(2);
                String email = rs.getString(3);
                String password = rs.getString(4);
                String gender = rs.getString(5);
                String mobile = rs.getString(6);
                Role role = getRoleByID(rs.getInt(7));
                String avatar = rs.getString(8);
                String status = rs.getString(9);

                //Lấy ra đối tượng User
                user = new User(id, fullName, email, password, gender, mobile, role, avatar, status);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return user;
    }

    public List<User> getListUser(String keyword, String gender, Integer roleId, String status, int page, int pageSize) {
        List<User> list = new ArrayList<>();

        try {
            int offset = (page - 1) * pageSize;

            String sql = "SELECT * FROM [User] WHERE 1=1";

            if (keyword != null && !keyword.trim().isEmpty()) {
                sql += " AND (fullName LIKE ? OR email LIKE ? OR mobile LIKE ?)";
            }
            if (gender != null && !gender.equalsIgnoreCase("all")) {
                sql += " AND gender = ?";
            }
            if (roleId != null) {
                sql += " AND roleID = ?";
            }
            if (status != null && !status.equalsIgnoreCase("all")) {
                sql += " AND status = ?";
            }

            sql += " ORDER BY userID ASC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

            PreparedStatement ps = connection.prepareStatement(sql);

            int index = 1;

            if (keyword != null && !keyword.trim().isEmpty()) {
                String kw = "%" + keyword.trim() + "%";
                ps.setString(index++, kw);
                ps.setString(index++, kw);
                ps.setString(index++, kw);
            }
            if (gender != null && !gender.equalsIgnoreCase("all")) {
                ps.setString(index++, gender);
            }
            if (roleId != null) {
                ps.setInt(index++, roleId);
            }
            if (status != null && !status.equalsIgnoreCase("all")) {
                ps.setString(index++, status);
            }

            ps.setInt(index++, offset);
            ps.setInt(index++, pageSize);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("userID");
                String fullName = rs.getString("fullName");
                String emailVal = rs.getString("email");
                String password = rs.getString("password");
                String genderVal = rs.getString("gender");
                String mobile = rs.getString("mobile");
                Role role = getRoleByID(rs.getInt("roleID"));
                String avatar = rs.getString("avatar");
                String statusVal = rs.getString("status");

                User user = new User(id, fullName, emailVal, password, genderVal, mobile, role, avatar, statusVal);
                list.add(user);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return list;
    }

    public int getTotalUsers(String keyword, String gender, Integer roleId, String status) {
        int total = 0;
        try {
            String sql = "SELECT COUNT(*) FROM [User] WHERE 1=1";

            if (keyword != null && !keyword.trim().isEmpty()) {
                sql += " AND (fullName LIKE ? OR email LIKE ? OR mobile LIKE ?)";
            }
            if (gender != null && !gender.equalsIgnoreCase("all")) {
                sql += " AND gender = ?";
            }
            if (roleId != null) {
                sql += " AND roleID = ?";
            }
            if (status != null && !status.equalsIgnoreCase("all")) {
                sql += " AND status = ?";
            }

            PreparedStatement ps = connection.prepareStatement(sql);
            int index = 1;

            if (keyword != null && !keyword.trim().isEmpty()) {
                String kw = "%" + keyword.trim() + "%";
                ps.setString(index++, kw);
                ps.setString(index++, kw);
                ps.setString(index++, kw);
            }
            if (gender != null && !gender.equalsIgnoreCase("all")) {
                ps.setString(index++, gender);
            }
            if (roleId != null) {
                ps.setInt(index++, roleId);
            }
            if (status != null && !status.equalsIgnoreCase("all")) {
                ps.setString(index++, status);
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return total;
    }
    
    public List<Role> getAllRoles() {
    List<Role> roles = new ArrayList<>();
    try {
        String sql = "SELECT roleID, roleName FROM Role"; // Đảm bảo câu SQL đúng
        PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            roles.add(new Role(rs.getInt("roleID"), rs.getString("roleName")));
        }
    } catch (SQLException e) {
        System.out.println("Error in getAllRoles: " + e.getMessage());
    }
    return roles;
}


    public static void main(String[] args) {
        UserDAO dao = new UserDAO();

    }
}
