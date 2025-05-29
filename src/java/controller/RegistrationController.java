/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CourseCategoryDAO;
import dal.CourseDAO;
import dal.RegistrationDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Course;
import model.CourseCategory;
import model.Registration;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "RegistrationController", urlPatterns = {"/registrationcontroller"})
public class RegistrationController extends HttpServlet {

    CourseCategoryDAO courseCategoryDAO = new CourseCategoryDAO();
    CourseDAO courseDAO = new CourseDAO();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegistrationController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegistrationController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Đáng lẽ phải lấy userID từ session nhưng vì chưa có tính năng login
        //nên ở đây tôi hard code giá trị userID;
        int userID = 5;

        //Lấy ra course Category để hiển thị ở thanh sider bar bên trái giúp fitler
        List<CourseCategory> listCourseCategory = courseCategoryDAO.getAllCategory();
        request.setAttribute("listCourseCategory", listCourseCategory);

        String action = request.getParameter("action");

        if (action != null && action.equals("filter")) {
            //Lấy ra Course Category từ trang my-registration.jsp để lọc
            //Nếu không có courseCategoryID truyền vô thì hiển thị toàn bộ
            //còn nếu có thì lọc và hiển thị danh sách đó ra
            String courseCategoryID_raw = request.getParameter("courseCategoryID");
            int courseCategoryID;
            try {
                courseCategoryID = Integer.parseInt(courseCategoryID_raw);
                List<Registration> listAllRegistrationByCourseCategoryOfUser = RegistrationDAO.getInstance().getAllRegistrationByCourseCategoryOfUser(userID, courseCategoryID);
                request.setAttribute("listRegistration", listAllRegistrationByCourseCategoryOfUser);
            } catch (NumberFormatException e) {
                System.out.println(e);
            }
        } else if (action != null && action.equals("search")) {
            //Lấy searchCourseName từ thẻ form bên my-registration.jsp
            String searchCourseName = request.getParameter("searchCourseName");

            List<Course> listAllRegistrationByCourseOfUserAfterSearch = courseDAO.getAllCoureByCourseName(searchCourseName);
            List<Registration> listRegistrationByListCourseOfUser = RegistrationDAO.getInstance().getAllRegistrationByListCourseOfUser(userID, listAllRegistrationByCourseOfUserAfterSearch);
            request.setAttribute("listRegistration", listRegistrationByListCourseOfUser);
        } else {
            List<Registration> listRegistrationOfUser = RegistrationDAO.getInstance().getAllRegistrationOfUserByUserID(userID);
            request.setAttribute("listRegistration", listRegistrationOfUser);
        }

        request.getRequestDispatcher("my-registrations.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
