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
 * @author ASUS
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
                String address = rs.getString(7);
                Role role = getRoleByID(rs.getInt(8));
                String avatar = rs.getString(9);
                String status = rs.getString(10);

                //Lấy ra đối tượng User
                user = new User(id, fullName, email, password, gender, mobile, address, role, avatar, status);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return user;
    }

    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM [User] WHERE email = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUserID(rs.getInt("userID"));
                user.setFullName(rs.getString("fullName"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                // Get role from roleID
                int roleID = rs.getInt("roleID");
                Role role = getRoleByID(roleID);
                user.setRole(role);
                return user;
            }
        } catch (SQLException e) {
            System.out.println("Error in getUserByEmail: " + e.getMessage());
        }
        return null;
    }

    // Add getAllAuthors method
    public List<User> getAllAuthors() {
        List<User> authors = new ArrayList<>();
        String sql = "SELECT DISTINCT u.* FROM [User] u "
                + "JOIN Post p ON u.userID = p.ownerID "
                + "ORDER BY u.fullName";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                User author = new User();
                author.setUserID(rs.getInt("userID"));
                author.setFullName(rs.getString("fullName"));
                authors.add(author);
            }
        } catch (SQLException e) {
            System.out.println("Error in getAllAuthors: " + e.getMessage());
        }
        return authors;
    }

    public static void main(String[] args) {
        UserDAO dao = new UserDAO();
        System.out.println(dao.getUserByID(1).getFullName());
    }
}
