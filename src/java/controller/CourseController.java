/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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
import jakarta.websocket.Session;
import java.util.List;
import model.Course;
import model.CourseCategory;

/**
 *
 * @author gtrun
 */
@WebServlet(name = "CourseController", urlPatterns = {"/coursecontroller"})
public class CourseController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        CourseDAO courseDao = new CourseDAO();
        CourseCategoryDAO courseCategoryDao = new CourseCategoryDAO();
        HttpSession session = request.getSession();

        String action = request.getParameter("action");

        if (action != null && action.equals("filter")) {
            // Lấy category và status từ form
            String category = request.getParameter("category");
            String status = request.getParameter("status");
            if (category.equals("allCategory")) {
                List<Course> courseList = courseDao.getAllCourse();
                session.setAttribute("courseList", courseList);
            }else{
                CourseCategory courseCategory = courseCategoryDao.getCategoryByName(category);
                int id = courseCategory.getCourseCategory();
                if( status.equals("allStatus")){
                    List<Course> courseList = courseDao.getAllCoureByCategory(id);
                session.setAttribute("courseList", courseList);
                }else{
                    List<Course> courseList = courseDao.getAllCoureByCategoryAndStatus(id, status);
                    session.setAttribute("courseList", courseList);
                }
                
            }
            
            

        } else {

            List<Course> courseList = courseDao.getAllCourse();
            session.setAttribute("courseList", courseList);
        }

        List<CourseCategory> courseCategoryList = courseCategoryDao.getAllCategory();
        session.setAttribute("courseCategoryList", courseCategoryList);

        request.getRequestDispatcher("subject-list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
