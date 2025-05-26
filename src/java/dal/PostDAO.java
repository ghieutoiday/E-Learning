package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
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

    public PostDAO() {
        // Connection is initialized in DBContext constructor
    }
      UserDAO userDAO = new UserDAO();
    PostCategoryDAO postCategoryDAO = new PostCategoryDAO();

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
            e.printStackTrace();
        }
        return posts;
    }

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

    public List<PostCategory> getAllCategories() {
        List<PostCategory> categories = new ArrayList<>();
        String sql = "SELECT * FROM PostCategory ORDER BY postCategoryName";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                PostCategory category = new PostCategory();
                category.setPostCategoryID(rs.getInt("postCategoryID"));
                category.setPostCategoryName(rs.getString("postCategoryName"));
                categories.add(category);
            }
        } catch (SQLException e) {
            System.out.println("Error in getAllCategories: " + e.getMessage());
        }
        return categories;
    }
    
    public List<User> getAllAuthors() {
        List<User> authors = new ArrayList<>();
        String sql = "SELECT DISTINCT u.* FROM [User] u " +
                    "JOIN Post p ON u.userID = p.ownerID " +
                    "ORDER BY u.fullName";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
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
                PostCategory postCategory = postCategoryDAO.getCategoryByName(rs.getString("postCategoryName"));
                post.setPostCategory(postCategory);
                User owner = userDAO.getUserByID(rs.getInt("ownerID"));
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

    public boolean addPost(Post post) {
        String sql = "INSERT INTO Post (title, postCategoryID, ownerID, thumbnail, briefInfo, description, status, feature, createDate, updateDate) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, post.getTitle());
            st.setInt(2, post.getPostCategory().getPostCategoryID());
            st.setInt(3, post.getOwner().getUserID());
            st.setString(4, post.getThumbnail());
            st.setString(5, post.getBriefInfo());
            st.setString(6, post.getDescription());
            st.setString(7, post.getStatus());
            st.setBoolean(8, post.isFeature());
            st.setTimestamp(9, new java.sql.Timestamp(post.getCreateDate().getTime()));
            st.setTimestamp(10, new java.sql.Timestamp(post.getUpdateDate().getTime()));
            
            return st.executeUpdate() > 0;
        } catch (SQLException e) {
            System.out.println("Error in addPost: " + e.getMessage());
            return false;
        }
    }

    public Post getPostByID(int postID) {
        String sql = "SELECT p.*, pc.postCategoryName, u.fullName " +
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
                owner.setUserID(rs.getInt("ownerID"));
                owner.setFullName(rs.getString("fullName"));
                post.setOwner(owner);
                
                return post;
            }
        } catch (SQLException e) {
            System.out.println("Error in getPostByID: " + e.getMessage());
        }
        return null;
    }

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
}