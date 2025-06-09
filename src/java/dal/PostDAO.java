package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Post;
import model.PostCategory;
import model.User;

public class PostDAO extends DBContext {
    private static final String SELECT_POSTS_WITH_PAGINATION = 
        "SELECT p.postID, p.title, pc.postCategoryName, p.ownerID, u.fullName, p.createDate, p.status, p.feature, p.thumbnail " +
        "FROM Post p " +
        "JOIN PostCategory pc ON p.postCategoryID = pc.postCategoryID " +
        "JOIN [User] u ON p.ownerID = u.userID " +
        "ORDER BY p.postID " +
        "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

    private static final String COUNT_TOTAL_POSTS = 
        "SELECT COUNT(*) FROM Post";

    private UserDAO userDAO;
    private PostCategoryDAO postCategoryDAO;
    
    public PostDAO() {
        super();
        this.userDAO = new UserDAO();
        this.postCategoryDAO = new PostCategoryDAO();
    }

    // Getters and setters for DAOs
    public UserDAO getUserDAO() {
        return userDAO;
    }

    public void setUserDAO(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    public PostCategoryDAO getPostCategoryDAO() {
        return postCategoryDAO;
    }

    public void setPostCategoryDAO(PostCategoryDAO postCategoryDAO) {
        this.postCategoryDAO = postCategoryDAO;
    }

    // Getter for all categories
    public List<PostCategory> getAllCategories() {
        return postCategoryDAO.getAllPostCategories();
    }

    // Getter for all authors
    public List<User> getAllAuthors() {
        return userDAO.getAllAuthors();
    }

    
    public List<Post> getFilteredPosts(String search, String sortBy, String category, 
            String author, String dateFilter, String status, String feature, 
            int page, int postsPerPage) {
        List<Post> posts = new ArrayList<>();
        int offset = (page - 1) * postsPerPage;
        
        StringBuilder sql = new StringBuilder(
            "SELECT p.postID, p.title, pc.postCategoryName, p.ownerID, u.fullName, " +
            "p.createDate, p.status, p.feature, p.thumbnail " +
            "FROM Post p " +
            "JOIN PostCategory pc ON p.postCategoryID = pc.postCategoryID " +
            "JOIN [User] u ON p.ownerID = u.userID " +
            "WHERE 1=1 ");
        
        List<Object> params = new ArrayList<>();
        
        // Add search condition
        if (search != null && !search.trim().isEmpty()) {
            sql.append("AND p.title LIKE ? ");
            params.add("%" + search + "%");
        }
        
        // Add category filter
        if (category != null && !category.isEmpty()) {
            sql.append("AND p.postCategoryID = ? ");
            params.add(Integer.parseInt(category));
        }
        
        // Add author filter
        if (author != null && !author.isEmpty()) {
            sql.append("AND p.ownerID = ? ");
            params.add(Integer.parseInt(author));
        }
        
        // Add date filter
        if (dateFilter != null && !dateFilter.isEmpty()) {
            switch (dateFilter) {
                case "today":
                    sql.append("AND CAST(p.createDate AS DATE) = CAST(GETDATE() AS DATE) ");
                    break;
                case "week":
                    sql.append("AND p.createDate >= DATEADD(day, -7, GETDATE()) ");
                    break;
                case "month":
                    sql.append("AND p.createDate >= DATEADD(month, -1, GETDATE()) ");
                    break;
            }
        }
        
        // Add status filter
        if (status != null && !status.isEmpty()) {
            sql.append("AND p.status = ? ");
            params.add(status);
        }
        
        // Add feature filter
        if (feature != null && !feature.isEmpty()) {
            sql.append("AND p.feature = ? ");
            params.add(Boolean.parseBoolean(feature));
        }
        
        // Add sorting
        if (sortBy != null && !sortBy.isEmpty()) {
            sql.append("ORDER BY ");
            switch (sortBy) {
                case "title":
                    sql.append("p.title ");
                    break;
                case "category":
                    sql.append("pc.postCategoryName ");
                    break;
                case "author":
                    sql.append("u.fullName ");
                    break;
                case "date":
                    sql.append("p.createDate ");
                    break;
                case "status":
                    sql.append("p.status ");
                    break;
                case "feature":
                    sql.append("p.feature ");
                    break;
                default:
                    sql.append("p.postID ");
            }
        } else {
            sql.append("ORDER BY p.postID ");
        }
        
        sql.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(postsPerPage);
        
        try (PreparedStatement st = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Post post = new Post();
                post.setPostID(rs.getInt("postID"));
                post.setTitle(rs.getString("title"));
                
                // Set category
                PostCategory postCategory = new PostCategory();
                postCategory.setPostCategoryName(rs.getString("postCategoryName"));
                post.setPostCategory(postCategory);
                
                // Set owner
                User owner = new User();
                owner.setUserID(rs.getInt("ownerID"));
                owner.setFullName(rs.getString("fullName"));
                post.setOwner(owner);
                
                post.setCreateDate(rs.getTimestamp("createDate"));
                post.setStatus(rs.getString("status"));
                post.setFeature(rs.getBoolean("feature"));
                post.setThumbnail(rs.getString("thumbnail"));
                posts.add(post);
            }
        } catch (SQLException e) {
            System.out.println("Error in getFilteredPosts: " + e.getMessage());
        }
        return posts;
    }

    // Trả về danh sách bài viết theo phân trang
    public List<Post> getPosts(int page, int postsPerPage) {
        List<Post> posts = new ArrayList<>();
        int offset = (page - 1) * postsPerPage;

        try (PreparedStatement preparedStatement = connection.prepareStatement(SELECT_POSTS_WITH_PAGINATION)) {
            preparedStatement.setInt(1, offset);
            preparedStatement.setInt(2, postsPerPage);
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                Post post = new Post();
                post.setPostID(rs.getInt("postID"));
                post.setTitle(rs.getString("title"));
                
                // Set category
                PostCategory category = new PostCategory();
                category.setPostCategoryName(rs.getString("postCategoryName"));
                post.setPostCategory(category);
                
                // Set owner
                User owner = new User();
                owner.setUserID(rs.getInt("ownerID"));
                owner.setFullName(rs.getString("fullName"));
                post.setOwner(owner);
                
                post.setCreateDate(rs.getTimestamp("createDate"));
                post.setStatus(rs.getString("status"));
                post.setFeature(rs.getBoolean("feature"));
                post.setThumbnail(rs.getString("thumbnail"));
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }
    
    // Trả về tổng số bài viết trong bảng Post
    public int getTotalPosts() {
        int total = 0;
        try (PreparedStatement preparedStatement = connection.prepareStatement(COUNT_TOTAL_POSTS);
             ResultSet rs = preparedStatement.executeQuery()) {

            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }
    //Tìm kiếm bài viết theo từ khóa, đồng thời có phân trang.
    public List<Post> searchPosts(String search, int page, int postsPerPage) {
        List<Post> posts = new ArrayList<>();
        int offset = (page - 1) * postsPerPage;
        
        String sql = "SELECT p.postID, p.title, pc.postCategoryName, p.ownerID, u.fullName, p.createDate, p.status, p.feature, p.thumbnail " +
                    "FROM Post p " +
                    "JOIN PostCategory pc ON p.postCategoryID = pc.postCategoryID " +
                    "JOIN [User] u ON p.ownerID = u.userID " +
                    "WHERE p.title LIKE ? " +
                    "ORDER BY p.postID " +
                    "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
                    
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, "%" + search + "%");
            st.setInt(2, offset);
            st.setInt(3, postsPerPage);
            ResultSet rs = st.executeQuery();
            
            while (rs.next()) {
                Post post = new Post();
                post.setPostID(rs.getInt("postID"));
                post.setTitle(rs.getString("title"));
                PostCategory category = postCategoryDAO.getCategoryByName(rs.getString("postCategoryName"));
                post.setPostCategory(category);
                User owner = userDAO.getUserByID(rs.getInt("ownerID"));
                post.setOwner(owner);
                post.setCreateDate(rs.getTimestamp("createDate"));
                post.setStatus(rs.getString("status"));
                post.setFeature(rs.getBoolean("feature"));
                post.setThumbnail(rs.getString("thumbnail"));
                posts.add(post);
            }
        } catch (SQLException e) {
            System.out.println("Error in searchPosts: " + e.getMessage());
        }
        return posts;
    }
    //Trả về tổng số bài viết có tiêu đề chứa từ khóa tìm kiếm.
    public int getTotalSearchPosts(String search) {
        String sql = "SELECT COUNT(*) FROM Post p " +
                    "WHERE p.title LIKE ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, "%" + search + "%");
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error in getTotalSearchPosts: " + e.getMessage());
        }
        return 0;
    }
    //Lấy danh sách bài viết có lọc theo tiêu chí (tìm kiếm, phân loại, tác giả, 
    //thời gian, trạng thái, nổi bật) và phân trang.
    public int getTotalFilteredPosts(String search, String category, 
            String author, String dateFilter, String status, String feature) {
        StringBuilder sql = new StringBuilder(
            "SELECT COUNT(*) FROM Post p " +
            "JOIN PostCategory pc ON p.postCategoryID = pc.postCategoryID " +
            "JOIN [User] u ON p.ownerID = u.userID " +
            "WHERE 1=1 ");
        
        List<Object> params = new ArrayList<>();
        
        // Add search condition
        if (search != null && !search.trim().isEmpty()) {
            sql.append("AND p.title LIKE ? ");
            params.add("%" + search + "%");
        }
        
        // Add category filter
        if (category != null && !category.isEmpty()) {
            sql.append("AND p.postCategoryID = ? ");
            params.add(Integer.parseInt(category));
        }
        
        // Add author filter
        if (author != null && !author.isEmpty()) {
            sql.append("AND p.ownerID = ? ");
            params.add(Integer.parseInt(author));
        }
        
        // Add date filter
        if (dateFilter != null && !dateFilter.isEmpty()) {
            switch (dateFilter) {
                case "today":
                    sql.append("AND CAST(p.createDate AS DATE) = CAST(GETDATE() AS DATE) ");
                    break;
                case "week":
                    sql.append("AND p.createDate >= DATEADD(day, -7, GETDATE()) ");
                    break;
                case "month":
                    sql.append("AND p.createDate >= DATEADD(month, -1, GETDATE()) ");
                    break;
            }
        }
        
        // Add status filter
        if (status != null && !status.isEmpty()) {
            sql.append("AND p.status = ? ");
            params.add(status);
        }
        
        // Add feature filter
        if (feature != null && !feature.isEmpty()) {
            sql.append("AND p.feature = ? ");
            params.add(Boolean.parseBoolean(feature));
        }
        
        try (PreparedStatement st = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error in getTotalFilteredPosts: " + e.getMessage());
        }
        return 0;
    }
    //Thêm mới bài viết vào database
    public boolean addPost(Post post) {
        String sql = "INSERT INTO Post (title, briefInfo, description, thumbnail, postCategoryID, ownerID, status, feature, createDate) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, GETDATE())";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, post.getTitle());
            st.setString(2, post.getBriefInfo());
            st.setString(3, post.getDescription());
            st.setString(4, post.getThumbnail());
            st.setInt(5, post.getPostCategory().getPostCategoryID());
            st.setInt(6, post.getOwner().getUserID());
            st.setString(7, post.getStatus());
            st.setBoolean(8, post.isFeature());
            
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error in addPost: " + e.getMessage());
            return false;
        }
    }
    //Lấy chi tiết 1 bài Post theo PostID
    public Post getPostByID(int postID) {
        String sql = "SELECT p.*, pc.postCategoryName, u.fullName, u.userID " +
                    "FROM Post p " +
                    "JOIN PostCategory pc ON p.postCategoryID = pc.postCategoryID " +
                    "JOIN [User] u ON p.ownerID = u.userID " +
                    "WHERE p.postID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, postID);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Post post = new Post();
                post.setPostID(rs.getInt("postID"));
                post.setTitle(rs.getString("title"));
                post.setBriefInfo(rs.getString("briefInfo"));
                post.setDescription(rs.getString("description"));
                post.setStatus(rs.getString("status"));
                post.setFeature(rs.getBoolean("feature"));
                post.setThumbnail(rs.getString("thumbnail"));
                post.setCreateDate(rs.getTimestamp("createDate"));
                post.setUpdateDate(rs.getTimestamp("updateDate"));
                
                // Set category
                PostCategory category = new PostCategory();
                category.setPostCategoryID(rs.getInt("postCategoryID"));
                category.setPostCategoryName(rs.getString("postCategoryName"));
                post.setPostCategory(category);
                
                // Set owner
                User owner = new User();
                owner.setUserID(rs.getInt("userID"));
                owner.setFullName(rs.getString("fullName"));
                post.setOwner(owner);
                
                return post;
            }
        } catch (SQLException e) {
            System.out.println("Error in getPostByID: " + e.getMessage());
        }
        return null;
    }
    //xóa 1 bài viết 
    public boolean deletePost(int postID) {
        String sql = "DELETE FROM Post WHERE postID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, postID);
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error in deletePost: " + e.getMessage());
            return false;
        }
    }
        public List<Post> getHotPost() {
        List<Post> list = new ArrayList<>();
        try {
            String sql = "Select * from Post WHERE status = 'Active' and feature = 1";

            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                int id = rs.getInt(1);

                //Lấy entity
                Post post = getPostByID(id);
                list.add(post);
            }

        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
       
    public void updatePost(Post post) {
        String sql = "UPDATE Post SET title = ?, briefInfo = ?, description = ?, thumbnail = ?, "
                + "postCategoryID = ?, status = ?, feature = ?, updateDate = GETDATE() WHERE postID = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, post.getTitle());
            st.setString(2, post.getBriefInfo());
            st.setString(3, post.getDescription());
            st.setString(4, post.getThumbnail());
            st.setInt(5, post.getPostCategory().getPostCategoryID());
            st.setString(6, post.getStatus());
            st.setBoolean(7, post.isFeature());
            st.setInt(8, post.getPostID());
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println("Error in updatePost: " + e.getMessage());
        }
    }
    
    //-----------------------------------------------------Của Thịnh----------------------------------------------------------------//
     private static PostDAO instance;

    public static PostDAO getInstance() {

        if (instance == null) {
            instance = new PostDAO();
        }

        return instance;
    }

    

    

    //Hàm getALL
    public List<Post> getAllPost(int page, int pageSize) {
        List<Post> list = new ArrayList<>();
        String sql = " SELECT * FROM Post"
                + " WHERE status = 'Active' "
                + " ORDER BY updateDate DESC "
                + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"; // Phân trang -- bỏ qua số dòng - lấy số dòng kế tiếp

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, (page - 1) * pageSize);
            ps.setInt(2, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                //Lấy post
                Post post = getPostByID(rs.getInt(1));
                //add vô list
                list.add(post);
            }

        } catch (SQLException ex) {
            Logger.getLogger(PostDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public int getTotalPost() {

        String sql = "SELECT COUNT(*)"
                + " FROM Post"
                + " WHERE status = 'Active'";

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
                   + " FROM Post"
                   + " where status = 'Active' AND LOWER(title) LIKE LOWER(?)"; //Biến toàn bộ chuỗi trong cột title và tham số truyền vào thành chữ thường, Dấu % được dùng để tìm chuỗi con

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

    //Lấy số bài viết có postCategory theo postCategoryID đã truyền để filter
    public int getTotalPostAfterFilterPostCategory(int postCategoryID) {
        String sql = "select COUNT(*) from Post where status = 'Active' AND postCategoryID = " + postCategoryID;

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




    //Lấy tất cả bài Post trong DB với status = Active
    public List<Post> getAllPost() {
        List<Post> list = new ArrayList<>();
        try {
            String sql = "Select * from Post WHERE status = 'Active'";

            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {  //Kiểm tra xem còn dữ liệu trong rs hay không
                int id = rs.getInt(1);

                //Lấy entity
                Post post = getPostByID(id);
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
            String sql = "Select TOP 5 * from Post where status = 'Active' Order By createDate DESC";

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
                java.util.Date createDate = rs.getDate(10);
                java.util.Date updateDate = rs.getDate(11);

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
            String sql =  " SELECT * FROM Post"
                        + " WHERE status = 'Active' AND postCategoryID =  " + postCategoryID
                        + " ORDER BY updateDate DESC "
                        + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, (page - 1) * pageSize);
            ps.setInt(2, pageSize);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                //Lấy postID sau mỗi lần
                int postID = rs.getInt(1);
                //Lấy Post
                Post post = getPostByID(postID);
                //Add Post vào list
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
            String sql = """
                        SELECT *
                        FROM Post
                        WHERE [status] = 'Active'
                        AND LOWER(title) LIKE LOWER(?)
                        ORDER BY updateDate DESC
                        OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;
                        """;

            PreparedStatement ps = connection.prepareStatement(sql);


            //Gán gía trị cho tham số
            ps.setString(1, "%" + titleSearch + "%");
            ps.setInt(2, (page - 1) * pageSize);
            ps.setInt(3, pageSize);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                //Lấy postID sau mỗi lần
                int postID = rs.getInt(1);
                //Lấy Post
                Post post = getPostByID(postID);
                //Add Post vào list
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
}