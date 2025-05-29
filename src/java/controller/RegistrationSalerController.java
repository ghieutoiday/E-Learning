/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CourseDAO;
import dal.PostDAO;
import dal.PricePackageDAO;
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
import model.Post;
import model.PricePackage;
import model.Registration;

/**
 *
 * @author admin
 */
@WebServlet(name = "RegistrationSalerController", urlPatterns = {"/registrationsalercontroller"})
public class RegistrationSalerController extends HttpServlet {

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
            out.println("<title>Servlet RegistrationSalerController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegistrationSalerController at " + request.getContextPath() + "</h1>");
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
        response.setContentType("text/html;charset=UTF-8");

        // Lấy các tham số sắp xếp từ request
        String sortBy = request.getParameter("sortBy");
        String sortOrder = request.getParameter("sortOrder"); // Giá trị thường là 'asc' hoặc 'desc'

        // CUNG CẤP GIÁ TRỊ MẶC ĐỊNH CHO SORTBY VÀ SORTORDER NẾU CHÚNG LÀ NULL HOẶC RỖNG TỪ REQUEST
        if (sortBy == null || sortBy.trim().isEmpty()) {
            sortBy = "userID"; // Mặc định sắp xếp theo userID
        }
        if (sortOrder == null || sortOrder.trim().isEmpty()) {
            sortOrder = "asc"; // Mặc định sắp xếp tăng dần
        }

        String emailSearch = request.getParameter("emailSearch");
        String courseName = request.getParameter("courseName");
        String name = request.getParameter("name");
        String status = request.getParameter("status");

        // Gửi lại các tham số sang JSP để giữ input
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("sortOrder", sortOrder);
        request.setAttribute("emailSearch", emailSearch);
        request.setAttribute("courseName", courseName);
        request.setAttribute("name", name);
        request.setAttribute("status", status);
        
        List<Course> courseList = new CourseDAO().getAllCourse();
        List<PricePackage> packageList = new PricePackageDAO().getAllPricePackage();
        
        // Gọi DAO đã kết hợp để lấy danh sách đăng ký
        List<Registration> listRegistrationBySaler = RegistrationDAO.getInstance().getRegistrationsByAllFilters(emailSearch, courseName, name, status, sortBy, sortOrder);
        
        request.setAttribute("courseList", courseList);
        request.setAttribute("packageList", packageList);
        request.setAttribute("listRegistrationBySaler", listRegistrationBySaler);
        request.getRequestDispatcher("registration-list-saler.jsp").forward(request, response);
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
