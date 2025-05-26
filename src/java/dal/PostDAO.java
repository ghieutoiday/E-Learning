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
import java.util.logging.Level;
import java.util.logging.Logger;
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

    //Hàm getALL
    public List<Post> getAllPost(int page, int pageSize) {
        List<Post> list = new ArrayList<>();
        String sql = " SELECT p.postID, p.title, p.thumbnail, p.briefInfo, p.description, p.status, p.feature, p.createDate, p.updateDate,"
                + " u.userID, u.fullName,"
                + " pc.postCategoryID, pc.postCategoryName"
                + " FROM Post p"
                + " JOIN [User] u ON p.ownerID = u.userID"
                + " JOIN PostCategory pc ON p.postCategoryID = pc.postCategoryID"
                + " WHERE p.status = 'Active' "
                + " ORDER BY p.updateDate DESC "
                + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, (page - 1) * pageSize);
            ps.setInt(2, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                // User
                User owner = new User();
                owner.setUserID(rs.getInt("userID"));
                owner.setFullName(rs.getString("fullName"));

                // PostCategory
                PostCategory postCategory = new PostCategory();
                postCategory.setPostCategoryID(rs.getInt("postCategoryID"));
                postCategory.setPostCategoryName(rs.getString("postCategoryName"));

                // Post
                Post post = new Post();
                post.setPostID(rs.getInt("postID"));
                post.setTitle(rs.getString("title"));
                post.setThumbnail(rs.getString("thumbnail"));
                post.setBriefInfo(rs.getString("briefInfo"));
                post.setDescription(rs.getString("description"));
                post.setStatus(rs.getString("status"));
                post.setFeature(rs.getBoolean("feature"));
                post.setCreateDate(rs.getDate("createDate"));
                post.setUpdateDate(rs.getDate("updateDate"));
                post.setOwner(owner);
                post.setPostCategory(postCategory);

                list.add(post);
            }

        } catch (SQLException ex) {
            Logger.getLogger(PostDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    public int getTotalPost() {

        String sql = " SELECT COUNT(*)"
                + " FROM Post p"
                + " JOIN [User] u ON p.ownerID = u.userID"
                + " JOIN PostCategory pc ON p.postCategoryID = pc.postCategoryID";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException ex) {
            Logger.getLogger(PostDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return 0;
    }

    public int getTotalPostAfterSearch(String titleSearch) {

        String sql = " SELECT COUNT(*)"
                + " FROM Post p"
                + " JOIN [User] u ON p.ownerID = u.userID"
                + " JOIN PostCategory pc ON p.postCategoryID = pc.postCategoryID"
                + " where LOWER(title) LIKE LOWER(?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + titleSearch + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException ex) {
            Logger.getLogger(PostDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return 0;
    }

    //Lấy ra đối tượng PostCategory từ ID truyền vào
    public PostCategory getPostCategortByID(int id) {
        PostCategory postCategory = null;

        try {
            String sql = "select * from PostCategory where postCategoryID = " + id;
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            //Kiểm tra xem còn dữ liệu trong rs hay không
            while (rs.next()) {
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

    //Lấy 1 bài Post với ID cụ thể
    public Post getPostByID(int id) {
        Post post = null;
        try {
            String sql = "Select * from Post where postID = " + id;

            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
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

    //Lấy tất cả bài Post trong DB
    public List<Post> getAllPost() {
        List<Post> list = new ArrayList();
        try {
            String sql = "Select * from Post";

            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
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

    //Lấy 5 bài viết có createDate mới nhất
    public List<Post> getRecentPost() {
        List<Post> list = new ArrayList();
        try {
            String sql = "Select TOP 5 * from Post Order By createDate DESC";

            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
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

    //Lấy tất cả các bài Post có PostCategory cụ thể
    public List<Post> getAllPostByPostCategoryID(int postCategoryID, int page, int pageSize) {
        List<Post> list = new ArrayList();
        try {
            //String sql = "Select * from Post where postCategoryID = " + postCategoryID;
            String sql = " SELECT p.postID, p.title, p.thumbnail, p.briefInfo, p.description, p.status, p.feature, p.createDate, p.updateDate,"
                + " u.userID, u.fullName,"
                + " pc.postCategoryID, pc.postCategoryName"
                + " FROM Post p"
                + " JOIN [User] u ON p.ownerID = u.userID"
                + " JOIN PostCategory pc ON p.postCategoryID = pc.postCategoryID"
                + " WHERE p.status = 'Active' AND postCategoryID =  " + postCategoryID
                + " ORDER BY p.updateDate DESC "
                + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, (page - 1) * pageSize);
            ps.setInt(2, pageSize);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                // User
                User owner = new User();
                owner.setUserID(rs.getInt("userID"));
                owner.setFullName(rs.getString("fullName"));

                // PostCategory
                PostCategory postCategory = new PostCategory();
                postCategory.setPostCategoryID(rs.getInt("postCategoryID"));
                postCategory.setPostCategoryName(rs.getString("postCategoryName"));

                // Post
                Post post = new Post();
                post.setPostID(rs.getInt("postID"));
                post.setTitle(rs.getString("title"));
                post.setThumbnail(rs.getString("thumbnail"));
                post.setBriefInfo(rs.getString("briefInfo"));
                post.setDescription(rs.getString("description"));
                post.setStatus(rs.getString("status"));
                post.setFeature(rs.getBoolean("feature"));
                post.setCreateDate(rs.getDate("createDate"));
                post.setUpdateDate(rs.getDate("updateDate"));
                post.setOwner(owner);
                post.setPostCategory(postCategory);

                list.add(post);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    //Lấy hết Post theo title hoặc 1 phần title
    public List<Post> getAllPostByTitle(String titleSearch, int page, int pageSize) {
        List<Post> list = new ArrayList();
        try {
            String sql = "SELECT p.postID, p.title, p.thumbnail, p.briefInfo, p.description, \n"
                    + "       p.status, p.feature, p.createDate, p.updateDate,\n"
                    + "       u.userID, u.fullName,\n"
                    + "       pc.postCategoryID, pc.postCategoryName\n"
                    + "FROM Post p\n"
                    + "JOIN [User] u ON p.ownerID = u.userID\n"
                    + "JOIN PostCategory pc ON p.postCategoryID = pc.postCategoryID\n"
                    + "WHERE p.status = 'Active'\n"
                    + "  AND LOWER(p.title) LIKE LOWER(?)\n"
                    + "ORDER BY p.updateDate DESC\n"
                    + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";

            PreparedStatement ps = connection.prepareStatement(sql);
            

            //Gán gía trị cho tham số
            ps.setString(1, "%" + titleSearch + "%");
            ps.setInt(2, (page - 1) * pageSize);
            ps.setInt(3, pageSize);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                // User
                User owner = new User();
                owner.setUserID(rs.getInt("userID"));
                owner.setFullName(rs.getString("fullName"));

                // PostCategory
                PostCategory postCategory = new PostCategory();
                postCategory.setPostCategoryID(rs.getInt("postCategoryID"));
                postCategory.setPostCategoryName(rs.getString("postCategoryName"));

                // Post
                Post post = new Post();
                post.setPostID(rs.getInt("postID"));
                post.setTitle(rs.getString("title"));
                post.setThumbnail(rs.getString("thumbnail"));
                post.setBriefInfo(rs.getString("briefInfo"));
                post.setDescription(rs.getString("description"));
                post.setStatus(rs.getString("status"));
                post.setFeature(rs.getBoolean("feature"));
                post.setCreateDate(rs.getDate("createDate"));
                post.setUpdateDate(rs.getDate("updateDate"));
                post.setOwner(owner);
                post.setPostCategory(postCategory);

                list.add(post);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    //Lấy hết PostCategory để hiển thị trong sider của trang PostDetail
    public List<PostCategory> getAllPostCategory() {
        List<PostCategory> list = new ArrayList();
        try {
            String sql = "Select * from PostCategory";

            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                int id = rs.getInt(1);
                String postCategoryName = rs.getString(2);
                String description = rs.getString(3);

                //Lấy entity
                PostCategory postCategory = new PostCategory(id, postCategoryName, description);
                list.add(postCategory);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public static void main(String[] args) {

        List<Post > p = getInstance().getAllPostByTitle("lear", 1, 5);

        for (Post x : p) {
            System.out.println(x.getTitle());
        }

    }
}
