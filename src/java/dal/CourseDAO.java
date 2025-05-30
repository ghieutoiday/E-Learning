/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
//Hieu
import java.util.List;
import model.Course;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.CourseCategory;
import model.User;

/**
 *
 * @author gtrun
 */
public class CourseDAO extends DBContext {

    public CourseDAO() {
        super();
    }
    
    // Hàm get course theo courseID
    public Course getCoureByCourseID(int courseID) {
        Course course = null;
        String sql = "SELECT [courseID]\n"
                + "      ,[courseName]\n"
                + "      ,[courseCategoryID]\n"
                + "      ,[thumbnail]\n"
                + "      ,[description]\n"
                + "      ,[ownerID]\n"
                + "      ,[status]\n"
                + "      ,[numberOfLesson]\n"
                + "      ,[createDate]\n"
                + " FROM [dbo].[Course]\n"
                + " where [courseID] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, courseID);
            ResultSet rs = ps.executeQuery();
            CourseCategoryDAO courseCategoryDAO = new CourseCategoryDAO();
            UserDAO userDao = new UserDAO();
            while (rs.next()) {
                CourseCategory courseCategory = courseCategoryDAO.getCategoryById(rs.getInt("courseCategoryID"));
                User user = userDao.getUserByID(rs.getInt("ownerID"));
                course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory,
                        rs.getString("thumbnail"), rs.getString("description"), user, rs.getString("status"), rs.getInt("numberOfLesson"), rs.getDate("createDate"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return course;
    }

    public List<Course> getAllCourse() {
        List<Course> list = new ArrayList<>();
        String sql = "SELECT [courseID]\n"
                + "      ,[courseName]\n"
                + "      ,[courseCategoryID]\n"
                + "      ,[thumbnail]\n"
                + "      ,[description]\n"
                + "      ,[ownerID]\n"
                + "      ,[status]\n"
                + "      ,[numberOfLesson]\n"
                + "      ,[createDate]\n"
                + "  FROM [CourseManagementDB].[dbo].[Course]";

        try {
            CourseCategoryDAO courseCategoryDao = new CourseCategoryDAO();
            UserDAO userDao = new UserDAO();
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CourseCategory courseCategory = courseCategoryDao.getCategoryById(rs.getInt("courseCategoryID"));
                User user = userDao.getUser(rs.getInt("ownerID"));
                Course course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory,
                        rs.getString("thumbnail"), rs.getString("description"), user, rs.getString("status"), rs.getInt("numberOfLesson"), rs.getDate("createDate"));
                list.add(course);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    //Hàm filter by categoryID
    public List<Course> getAllCoureByCategoryAndStatus(int categoryId, String status) {
        List<Course> list = new ArrayList<>();
        Course course = null;
        String sql = "SELECT [courseID]\n"
                + "      ,[courseName]\n"
                + "      ,[courseCategoryID]\n"
                + "      ,[thumbnail]\n"
                + "      ,[description]\n"
                + "      ,[ownerID]\n"
                + "      ,[status]\n"
                + "      ,[numberOfLesson]\n"
                + "      ,[createDate]\n"
                + " FROM [dbo].[Course]\n"
                + " where [courseCategoryID] = ? and [status] = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, categoryId);
            ps.setString(2, status);
            ResultSet rs = ps.executeQuery();
            CourseCategoryDAO courseCategoryDAO = new CourseCategoryDAO();
            UserDAO userDao = new UserDAO();
            while (rs.next()) {
                CourseCategory courseCategory = courseCategoryDAO.getCategoryById(rs.getInt("courseCategoryID"));
                User user = userDao.getUser(rs.getInt("ownerID"));
                course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory,
                        rs.getString("thumbnail"), rs.getString("description"), user, rs.getString("status"), rs.getInt("numberOfLesson"), rs.getDate("createDate"));
                list.add(course);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    //Hàm get all course theo status
    public List<Course> getAllCoureByStatus(String status) {
        List<Course> list = new ArrayList<>();
        Course course = null;
        String sql = "SELECT [courseID]\n"
                + "      ,[courseName]\n"
                + "      ,[courseCategoryID]\n"
                + "      ,[thumbnail]\n"
                + "      ,[description]\n"
                + "      ,[ownerID]\n"
                + "      ,[status]\n"
                + "      ,[numberOfLesson]\n"
                + "      ,[createDate]\n"
                + " FROM [dbo].[Course]\n"
                + " where[status] = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            CourseCategoryDAO courseCategoryDAO = new CourseCategoryDAO();
            UserDAO userDao = new UserDAO();
            while (rs.next()) {
                CourseCategory courseCategory = courseCategoryDAO.getCategoryById(rs.getInt("courseCategoryID"));
                User user = userDao.getUser(rs.getInt("ownerID"));
                course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory,
                        rs.getString("thumbnail"), rs.getString("description"), user, rs.getString("status"), rs.getInt("numberOfLesson"), rs.getDate("createDate"));
                list.add(course);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }
    
    //Hàm lấy tất cả các course có courseName ứng với 1 phần hoặc toàn bộ courseName sau khi search
    //hàm này lấy để dùng trong 
    public List<Course> getAllCoureByCourseName(String courseName) {
        List<Course> list = new ArrayList<>();
        Course course = null;
        String sql = "SELECT [courseID]\n"
                + "      ,[courseName]\n"
                + "      ,[courseCategoryID]\n"
                + "      ,[thumbnail]\n"
                + "      ,[description]\n"
                + "      ,[ownerID]\n"
                + "      ,[status]\n"
                + "      ,[numberOfLesson]\n"
                + "      ,[createDate]\n"
                + " FROM [dbo].[Course]\n"
                + " where LOWER(courseName) LIKE LOWER(?)";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + courseName + "%");
            ResultSet rs = ps.executeQuery();
            CourseCategoryDAO courseCategoryDAO = new CourseCategoryDAO();
            UserDAO userDao = new UserDAO();
            while (rs.next()) {
                CourseCategory courseCategory = courseCategoryDAO.getCategoryById(rs.getInt("courseCategoryID"));
                User user = userDao.getUserByID(rs.getInt("ownerID"));
                course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory,
                        rs.getString("thumbnail"), rs.getString("description"), user, rs.getString("status"), rs.getInt("numberOfLesson"), rs.getDate("createDate"));
                list.add(course);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    // Hàm get all course theo categoryID
    public List<Course> getAllCoureByCategory(int categoryId) {
        List<Course> list = new ArrayList<>();
        Course course = null;
        String sql = "SELECT [courseID]\n"
                + "      ,[courseName]\n"
                + "      ,[courseCategoryID]\n"
                + "      ,[thumbnail]\n"
                + "      ,[description]\n"
                + "      ,[ownerID]\n"
                + "      ,[status]\n"
                + "      ,[numberOfLesson]\n"
                + "      ,[createDate]\n"
                + " FROM [dbo].[Course]\n"
                + " where [courseCategoryID] = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            CourseCategoryDAO courseCategoryDAO = new CourseCategoryDAO();
            UserDAO userDao = new UserDAO();
            while (rs.next()) {
                CourseCategory courseCategory = courseCategoryDAO.getCategoryById(rs.getInt("courseCategoryID"));
                User user = userDao.getUser(rs.getInt("ownerID"));
                course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory,
                        rs.getString("thumbnail"), rs.getString("description"), user, rs.getString("status"), rs.getInt("numberOfLesson"), rs.getDate("createDate"));
                list.add(course);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    // Hàm get 5 courselist dùng để phân trang
    public List<Course> pagingCourse(int index) {
        List<Course> list = new ArrayList<>();
        String sql = "SELECT [courseID]\n"
                + "      ,[courseName]\n"
                + "      ,[courseCategoryID]\n"
                + "      ,[thumbnail]\n"
                + "      ,[description]\n"
                + "      ,[ownerID]\n"
                + "      ,[status]\n"
                + "      ,[numberOfLesson]\n"
                + "      ,[createDate]\n"
                + "  FROM [dbo].[Course]\n"
                + "  order by [courseID] \n"
                + "  offset ? rows fetch next 5 rows only;";

        try {
            CourseCategoryDAO courseCategoryDao = new CourseCategoryDAO();
            UserDAO userDao = new UserDAO();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, (index - 1) * 5);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CourseCategory courseCategory = courseCategoryDao.getCategoryById(rs.getInt("courseCategoryID"));
                User user = userDao.getUser(rs.getInt("ownerID"));
                Course course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory,
                        rs.getString("thumbnail"), rs.getString("description"), user, rs.getString("status"), rs.getInt("numberOfLesson"), rs.getDate("createDate"));
                list.add(course);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    //Hàm phân trang theo status
    public List<Course> pagingCourseByStatus(int index, String status) {
        List<Course> list = new ArrayList<>();
        String sql = "SELECT [courseID]\n"
                + "      ,[courseName]\n"
                + "      ,[courseCategoryID]\n"
                + "      ,[thumbnail]\n"
                + "      ,[description]\n"
                + "      ,[ownerID]\n"
                + "      ,[status]\n"
                + "      ,[numberOfLesson]\n"
                + "      ,[createDate]\n"
                + "  FROM [dbo].[Course]\n"
                + "  where status = ?\n"
                + "  order by [courseID] \n"
                + "  offset ? rows fetch next 5 rows only;";

        try {
            CourseCategoryDAO courseCategoryDao = new CourseCategoryDAO();
            UserDAO userDao = new UserDAO();
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, (index - 1) * 5);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                CourseCategory courseCategory = courseCategoryDao.getCategoryById(rs.getInt("courseCategoryID"));
                User user = userDao.getUser(rs.getInt("ownerID"));
                Course course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory,
                        rs.getString("thumbnail"), rs.getString("description"), user, rs.getString("status"), rs.getInt("numberOfLesson"), rs.getDate("createDate"));
                list.add(course);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return list;
    }

    //Hàm phân trang theo Category
    public List<Course> pagingCourseByCategory(int index, int categoryId) {
        List<Course> list = new ArrayList<>();
        Course course = null;
        String sql = "SELECT [courseID]\n"
                + "      ,[courseName]\n"
                + "      ,[courseCategoryID]\n"
                + "      ,[thumbnail]\n"
                + "      ,[description]\n"
                + "      ,[ownerID]\n"
                + "      ,[status]\n"
                + "      ,[numberOfLesson]\n"
                + "      ,[createDate]\n"
                + "  FROM [dbo].[Course]\n"
                + "  where courseCategoryID = ?\n"
                + "  order by [courseID] \n"
                + "  offset ? rows fetch next 5 rows only;";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, categoryId);
            ps.setInt(2, (index - 1) * 5);
            ResultSet rs = ps.executeQuery();
            CourseCategoryDAO courseCategoryDAO = new CourseCategoryDAO();
            UserDAO userDao = new UserDAO();
            while (rs.next()) {
                CourseCategory courseCategory = courseCategoryDAO.getCategoryById(rs.getInt("courseCategoryID"));
                User user = userDao.getUser(rs.getInt("ownerID"));
                course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory,
                        rs.getString("thumbnail"), rs.getString("description"), user, rs.getString("status"), rs.getInt("numberOfLesson"), rs.getDate("createDate"));
                list.add(course);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    //Hàm phân trang theo Category
    public List<Course> pagingCourseByCategoryAndStatus(int index, int categoryId, String status) {
        List<Course> list = new ArrayList<>();
        Course course = null;
        String sql = "SELECT [courseID]\n"
                + "      ,[courseName]\n"
                + "      ,[courseCategoryID]\n"
                + "      ,[thumbnail]\n"
                + "      ,[description]\n"
                + "      ,[ownerID]\n"
                + "      ,[status]\n"
                + "      ,[numberOfLesson]\n"
                + "      ,[createDate]\n"
                + "  FROM [dbo].[Course]\n"
                + "  where courseCategoryID = ? and status = ?\n"
                + "  order by [courseID] \n"
                + "  offset ? rows fetch next 5 rows only;";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, categoryId);
            ps.setString(2, status);
            ps.setInt(3, (index - 1) * 5);
            ResultSet rs = ps.executeQuery();
            CourseCategoryDAO courseCategoryDAO = new CourseCategoryDAO();
            UserDAO userDao = new UserDAO();
            while (rs.next()) {
                CourseCategory courseCategory = courseCategoryDAO.getCategoryById(rs.getInt("courseCategoryID"));
                User user = userDao.getUser(rs.getInt("ownerID"));
                course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory,
                        rs.getString("thumbnail"), rs.getString("description"), user, rs.getString("status"), rs.getInt("numberOfLesson"), rs.getDate("createDate"));
                list.add(course);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    //Hàm search By Part of Name of CategoryName
    public List<Course> searchCourseByNameOrCategory(String searchKey) {
        List<Course> list = new ArrayList<>();
        Course course = null;

        String sql = "SELECT c.[courseID], c.[courseName], c.[courseCategoryID], c.[thumbnail], " +
                     "c.[description], c.[ownerID], c.[status], c.[numberOfLesson], c.[createDate], " +
                     "cc.[courseCategoryName] " +
                     "FROM [dbo].[Course] c " +
                     "JOIN [dbo].[CourseCategory] cc ON c.[courseCategoryID] = cc.[courseCategoryID] " +
                     "WHERE c.[courseName] LIKE ? OR cc.[courseCategoryName] LIKE ?";
        
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            String searchKeyTerm = "%" + searchKey + "%"; // Sửa dấu grave accent
            ps.setString(1, searchKeyTerm);
            ps.setString(2, searchKeyTerm);
            ResultSet rs = ps.executeQuery();
            CourseCategoryDAO courseCategoryDAO = new CourseCategoryDAO();
            UserDAO userDao = new UserDAO();
            while (rs.next()) {                
                CourseCategory courseCategory = courseCategoryDAO.getCategoryById(rs.getInt("courseCategoryID"));
                User user = userDao.getUser(rs.getInt("ownerID"));
                course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory,
                        rs.getString("thumbnail"), rs.getString("description"), user, rs.getString("status"), 
                        rs.getInt("numberOfLesson"), rs.getDate("createDate"));
                list.add(course);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    public static void main(String[] args) {
        CourseDAO courseDao = new CourseDAO();

        System.out.println(courseDao.searchCourseByNameOrCategory("Web").size());
        

    }

}
