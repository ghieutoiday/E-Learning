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
        String sql = "SELECT c.courseID, "
                + "       c.courseName, "
                + "       c.courseCategoryID, "
                + "       c.description, "
                + "       c.ownerID, "
                + "       c.status, "
                + "       c.numberOfLesson, "
                + "       c.feature, "
                + "       c.createDate, "
                + "       i.thumbnail "
                + "FROM Course c "
                + "JOIN Image i ON c.courseID = i.courseID "
                + "WHERE c.courseID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, courseID);
            ResultSet rs = ps.executeQuery();
            CourseCategoryDAO courseCategoryDAO = new CourseCategoryDAO();
            UserDAO userDao = new UserDAO();
            while (rs.next()) {
                CourseCategory courseCategory = courseCategoryDAO.getCategoryById(rs.getInt("courseCategoryID"));
                User user = userDao.getUserByID(rs.getInt("ownerID"));
                String courseThumbnailLink = rs.getString("thumbnail");
                course = new Course(rs.getInt("courseID"),
                        rs.getString("courseName"),
                        courseCategory,
                        courseThumbnailLink, //Truyền link ảnh vào đây
                        rs.getString("description"),
                        user,
                        rs.getString("status"),
                        rs.getInt("numberOfLesson"),
                        rs.getInt("feature"),
                        rs.getDate("createDate"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return course;
    }

//    public List<Course> getAllCourse() {
//        List<Course> list = new ArrayList<>();
//        String sql = "SELECT [courseID]\n"
//                + "      ,[courseName]\n"
//                + "      ,[courseCategoryID]\n"
//                //                + "      ,[thumbnail]\n"
//                + "      ,[description]\n"
//                + "      ,[ownerID]\n"
//                + "      ,[status]\n"
//                + "      ,[numberOfLesson]\n"
//                + "      ,[createDate]\n"
//                + "  FROM [CourseManagementDB].[dbo].[Course]";
//
//        try {
//            CourseCategoryDAO courseCategoryDao = new CourseCategoryDAO();
//            UserDAO userDao = new UserDAO();
//            PreparedStatement ps = connection.prepareStatement(sql);
//            ResultSet rs = ps.executeQuery();
//            while (rs.next()) {
//                CourseCategory courseCategory = courseCategoryDao.getCategoryById(rs.getInt("courseCategoryID"));
//                User user = userDao.getUser(rs.getInt("ownerID"));
//                Course course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory, rs.getString("description"), user, rs.getString("status"), rs.getInt("numberOfLesson"), rs.getDate("createDate"));
//                list.add(course);
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return list;
//    }
    
    public List<Course> getAllCourse() {
    List<Course> list = new ArrayList<>();
    String sql = "SELECT c.courseID, "
               + "       c.courseName, "
               + "       c.courseCategoryID, "
               + "       c.description, "
               + "       c.ownerID, "
               + "       c.status, "
               + "       c.numberOfLesson, "
               + "       c.feature, " // <-- Bao gồm cả feature
               + "       c.createDate, "
               + "       i.thumbnail " // <-- Bao gồm cả thumbnail từ bảng Image
               + "FROM [CourseManagementDB].[dbo].[Course] c "
               + "LEFT JOIN [CourseManagementDB].[dbo].[Image] i ON c.courseID = i.courseID";

    try {
        CourseCategoryDAO courseCategoryDao = new CourseCategoryDAO();
        UserDAO userDao = new UserDAO();
        PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            CourseCategory courseCategory = courseCategoryDao.getCategoryById(rs.getInt("courseCategoryID"));
            User user = userDao.getUser(rs.getInt("ownerID"));

            String thumbnail = rs.getString("thumbnail");
            int feature = rs.getInt("feature"); // <-- Lấy giá trị của feature

            // Tạo đối tượng Course với thumbnail và feature
            // Đảm bảo constructor của lớp Course có tham số String cho thumbnail và int cho feature
            Course course = new Course(rs.getInt("courseID"),
                                        rs.getString("courseName"),
                                        courseCategory,
                                        thumbnail, // Truyền thumbnail
                                        rs.getString("description"),
                                        user,
                                        rs.getString("status"),
                                        rs.getInt("numberOfLesson"),
                                        feature, // Truyền feature
                                        rs.getDate("createDate"));
            list.add(course);
        }
        // Đảm bảo đóng ResultSet và PreparedStatement để giải phóng tài nguyên
        rs.close();
        ps.close();
    } catch (SQLException ex) {
        Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, "Lỗi khi lấy tất cả khóa học", ex);
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
                //                + "      ,[thumbnail]\n"
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
                        rs.getString("description"), user, rs.getString("status"), rs.getInt("numberOfLesson"), rs.getDate("createDate"));
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
                //                + "      ,[thumbnail]\n"
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
                course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory, rs.getString("description"), user, rs.getString("status"), rs.getInt("numberOfLesson"), rs.getDate("createDate"));
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
                //                + "      ,[thumbnail]\n"
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
                course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory, rs.getString("description"), user, rs.getString("status"), rs.getInt("numberOfLesson"), rs.getDate("createDate"));
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
                //                + "      ,[thumbnail]\n"
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
                course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory, rs.getString("description"), user, rs.getString("status"), rs.getInt("numberOfLesson"), rs.getDate("createDate"));
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
                //                + "      ,[thumbnail]\n"
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
                Course course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory, rs.getString("description"), user, rs.getString("status"), rs.getInt("numberOfLesson"), rs.getDate("createDate"));
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
                //                + "      ,[thumbnail]\n"
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
                Course course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory, rs.getString("description"), user, rs.getString("status"), rs.getInt("numberOfLesson"), rs.getDate("createDate"));
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
                //                + "      ,[thumbnail]\n"
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
                course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory, rs.getString("description"), user, rs.getString("status"), rs.getInt("numberOfLesson"), rs.getDate("createDate"));
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
                //                + "      ,[thumbnail]\n"
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
                course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory, rs.getString("description"), user, rs.getString("status"), rs.getInt("numberOfLesson"), rs.getDate("createDate"));
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

        String sql = "SELECT c.[courseID], c.[courseName], c.[courseCategoryID], "
                + "c.[description], c.[ownerID], c.[status], c.[numberOfLesson], c.[createDate], "
                + "cc.[courseCategoryName] "
                + "FROM [dbo].[Course] c "
                + "JOIN [dbo].[CourseCategory] cc ON c.[courseCategoryID] = cc.[courseCategoryID] "
                + "WHERE c.[courseName] LIKE ? OR cc.[courseCategoryName] LIKE ?";

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
                course = new Course(rs.getInt("courseID"), rs.getString("courseName"), courseCategory, rs.getString("description"), user, rs.getString("status"),
                        rs.getInt("numberOfLesson"), rs.getDate("createDate"));
                list.add(course);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    //Hầm update course
    public int updateCourse(Course course) {
        int rowsAffected = 0;
        String sql = "UPDATE [dbo].[Course] SET "
                + "[courseName] = ?, "
                + "[courseCategoryID] = ?, "
//                + "[thumbnail] = ?, "
                + "[description] = ?, "
                + "[status] = ?, "
                + "[numberOfLesson] = ?, "
                + "[feature] = ? "
                + "WHERE [courseID] = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, course.getCourseName());
            //CourseCategoryDAO courseCategoryDao = new CourseCategoryDAO();
            ps.setInt(2, course.getCourseCategory().getCourseCategory());
//            ps.setString(3, course.getThumbnail());
            ps.setString(3, course.getDescription());
            ps.setString(4, course.getStatus());
            ps.setInt(5, course.getNumberOfLesson());
            ps.setInt(6, course.getFeature());
            ps.setInt(7, course.getCourseID());

            rowsAffected = ps.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(CourseDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rowsAffected;
    }

    public static void main(String[] args) {
        CourseDAO courseDao = new CourseDAO();
        Course course = courseDao.getCoureByCourseID(8);
        CourseCategoryDAO courseCategoryDAO = new CourseCategoryDAO();
        UserDAO userDao = new UserDAO();
        CourseCategory courseCategory = courseCategoryDAO.getCategoryByName(course.getCourseCategory().getCourseCategoryName());
        User user = userDao.getUser(course.getOwner().getUserID());
        Course u = new Course(course.getCourseID(), course.getCourseName(),courseCategory , course.getDescription(), user, course.getStatus(), 11, course.getFeature(), course.getCreateDate());
        int x = courseDao.updateCourse(u);
        //System.out.println(course.getCourseCategory().getCourseCategory());
        System.out.println(x);


    }

}
