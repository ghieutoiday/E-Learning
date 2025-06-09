package controller;

import dal.CourseCategoryDAO;
import dal.CourseDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Course;
import model.CourseCategory;

@WebServlet(name = "CourseController", urlPatterns = {"/coursecontroller"})
public class CourseController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CourseDAO courseDao = new CourseDAO();
        CourseCategoryDAO courseCategoryDao = new CourseCategoryDAO();
        HttpSession session = request.getSession();

        String pageSubjectList = request.getParameter("pageSubjectList");
        if (pageSubjectList == null) {
            pageSubjectList = "1";
        }
        int indexPageSubjectList = Integer.parseInt(pageSubjectList);

        // Lấy các tham số filter từ request
        String categoryParam = request.getParameter("category");
        String statusParam = request.getParameter("status");
        String action = request.getParameter("action");

        // Nếu có tham số filter từ request, lưu vào session
        if (categoryParam != null) {
            session.setAttribute("currentCategory", categoryParam);
        }
        if (statusParam != null) {
            session.setAttribute("currentStatus", statusParam);
        }

        // Lấy category và status từ session hoặc mặc định
        String currentCategory = (String) session.getAttribute("currentCategory");
        if (currentCategory == null) {
            currentCategory = "allCategory"; // Giá trị mặc định
        }

        String currentStatus = (String) session.getAttribute("currentStatus");
        if (currentStatus == null) {
            currentStatus = "allStatus";
        }

        List<Course> courseList;
        int totalCourse;

        // lọc dựa trên currentCategory và currentStatus
        if (currentCategory.equals("allCategory") && currentStatus.equals("allStatus")) {
            totalCourse = courseDao.getAllCourse().size();
            courseList = courseDao.pagingCourse(indexPageSubjectList);
        } else if (currentCategory.equals("allCategory") && !currentStatus.equals("allStatus")) {
            totalCourse = courseDao.getAllCoureByStatus(currentStatus).size();
            courseList = courseDao.pagingCourseByStatus(indexPageSubjectList, currentStatus);
        } else if (!currentCategory.equals("allCategory") && currentStatus.equals("allStatus")) {
            CourseCategory courseCategory = courseCategoryDao.getCategoryByName(currentCategory);
            int id = courseCategory.getCourseCategory();
            totalCourse = courseDao.getAllCoureByCategory(id).size();
            courseList = courseDao.pagingCourseByCategory(indexPageSubjectList, id);
        } else {
            CourseCategory courseCategory = courseCategoryDao.getCategoryByName(currentCategory);
            int id = courseCategory.getCourseCategory();
            totalCourse = courseDao.getAllCoureByCategoryAndStatus(id, currentStatus).size();
            courseList = courseDao.pagingCourseByCategoryAndStatus(indexPageSubjectList, id, currentStatus);
        }

        int endPage = totalCourse / 5;
        if (totalCourse % 5 != 0) {
            endPage++;
        }

        session.setAttribute("endPage", endPage);
        session.setAttribute("courseList", courseList);

        List<CourseCategory> courseCategoryList = courseCategoryDao.getAllCategory();
        session.setAttribute("courseCategoryList", courseCategoryList); 

        request.getRequestDispatcher("subject-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String search = request.getParameter("search");
        CourseDAO courseDao = new CourseDAO();
        CourseCategoryDAO courseCategoryDao = new CourseCategoryDAO(); // Cần để lấy danh mục nếu muốn duy trì filter

        if (search != null && !search.trim().isEmpty()) {
            List<Course> courseList = courseDao.searchCourseByNameOrCategory(search);
            session.setAttribute("courseList", courseList);
            session.setAttribute("endPage", 0); // xóa phân trang
            session.removeAttribute("currentCategory");
            session.removeAttribute("currentStatus");
        } else { // Nếu từ khóa tìm kiếm rỗng hoặc chỉ toàn khoảng trắng
            // Xóa kết quả tìm kiếm cũ
            session.removeAttribute("courseList");
            session.removeAttribute("currentCategory");
            session.removeAttribute("currentStatus");

            // Gọi lại doGet để tải lại trang với phân trang như ban đầu
            doGet(request, response);
            return;
        }
        request.getRequestDispatcher("subject-list.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
