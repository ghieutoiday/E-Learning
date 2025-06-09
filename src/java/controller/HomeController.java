package controller;

import dal.CourseCategoryDAO;
import dal.CourseDAO;
import dal.PostDAO;
import dal.SliderDAO;
import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import model.Course;
import model.CourseCategory;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "HomeController", urlPatterns = {"/home"})
public class HomeController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            SliderDAO sliderDAO = new SliderDAO();
            PostDAO postDAO = new PostDAO();
            CourseDAO courseDao = new CourseDAO();
            request.setAttribute("sliders", sliderDAO.getActiveSliders());
            request.setAttribute("posts", postDAO.getHotPost());

            CourseCategoryDAO courseCategoryDao = new CourseCategoryDAO();
            List<Course> courseList;
            courseList = courseDao.getCoursePageHome();
     
            session.setAttribute("courseList", courseList); 
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
} 