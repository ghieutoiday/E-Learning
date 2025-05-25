/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Post;
import model.PostCategory;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.User;

/**
 *
 * @author ASUS
 */
public class PostDAO extends DBContext {

    private static PostDAO instance;

    public static PostDAO getInstance() {

        if (instance == null) {
            instance = new PostDAO();
        }

        return instance;
    }

    public PostDAO() {
        super();
    }

    UserDAO userDAO = new UserDAO();

    //Lấy ra đối tượng PostCategory từ ID truyền vào
    public PostCategory getPostCategortByID(int id) {
        PostCategory postCategory = null;

        try {
            String sql = "select * from PostCategory where postCategoryID = " + id;
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            //Kiểm tra xem còn dữ liệu trong rs hay không
            if (rs.next()) {
                //Lấy cột thứ 2 trong bảng 
                String postCategoryName = rs.getString(2);
                String description = rs.getString(3);

                //Lấy ra đối tượng
                postCategory = new PostCategory(id, postCategoryName, description);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return postCategory;
    }

    public Post getPostByID(int id) {
        Post post = null;
        try {
            String sql = "Select * from Post where postID = " + id;

            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                User owner = userDAO.getUserByID(rs.getInt(2));
                String title = rs.getString(3);
                PostCategory postCategory = getPostCategortByID(rs.getInt(4));
                String thumbnail = rs.getString(5);
                String briefInfor = rs.getString(6);
                String description = rs.getString(7);
                String status = rs.getString(8);
                boolean feature = rs.getBoolean(9);
                Date createDate = rs.getDate(10);
                Date updateDate = rs.getDate(10);

                //Lấy entity
                post = new Post(id, owner, title, postCategory, thumbnail, briefInfor, description, status, feature, createDate, updateDate);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return post;
    }

    public List<Post> getAllPost() {
        List<Post> list = new ArrayList();
        try {
            String sql = "Select * from Post";

            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                int id = rs.getInt(1);
                User owner = userDAO.getUserByID(rs.getInt(2));
                String title = rs.getString(3);
                PostCategory postCategory = getPostCategortByID(rs.getInt(4));
                String thumbnail = rs.getString(5);
                String briefInfor = rs.getString(6);
                String description = rs.getString(7);
                String status = rs.getString(8);
                boolean feature = rs.getBoolean(9);
                Date createDate = rs.getDate(10);
                Date updateDate = rs.getDate(10);

                //Lấy entity
                Post post = new Post(id, owner, title, postCategory, thumbnail, briefInfor, description, status, feature, createDate, updateDate);
                list.add(post);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    public static void main(String[] args) {
        Post p = getInstance().getPostByID(1);
        System.out.println(p.getDescription());
    }
}
