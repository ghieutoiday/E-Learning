/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Role;
import model.User;

/**
 *
 * @author ACER
 */
@WebServlet(name = "UserController", urlPatterns = {"/userDAO"})
public class UserController extends HttpServlet {

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
            out.println("<title>Servlet UserController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserController at " + request.getContextPath() + "</h1>");
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
    UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String gender = request.getParameter("gender");
        String roleIDStr = request.getParameter("roleID");
        String status = request.getParameter("status");
        String search = request.getParameter("search");
        
        // THÊM CÁC THAM SỐ SORT
        String sortBy = request.getParameter("sortBy");
        String sortOrder = request.getParameter("sortOrder");
        
        String pageStr = request.getParameter("page");
        int pageIndex = 1;
        int pageSize = 10;

        // Parse page number safely
        if (pageStr != null && !pageStr.trim().equals("") && !pageStr.equalsIgnoreCase("null")) {
            try {
                pageIndex = Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
                pageIndex = 1;
            }
        }

        // Parse roleID safely
        Integer roleID = null;
        if (roleIDStr != null && !roleIDStr.trim().equals("") && !roleIDStr.equalsIgnoreCase("null")) {
            try {
                roleID = Integer.parseInt(roleIDStr);
            } catch (NumberFormatException e) {
                roleID = null;
            }
        }

        List<User> userList = userDAO.getListUser(search, gender, roleID, status, pageIndex, pageSize);
        int totalUsers = userDAO.getTotalUsers(search, gender, roleID, status);
        int totalPage = (int) Math.ceil((double) totalUsers / pageSize);
        
        List<Role> rolesList = userDAO.getAllRoles();
        
        request.setAttribute("userList", userList);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("currentPage", pageIndex);

        request.setAttribute("genderFilter", gender);
        request.setAttribute("roleIDFilter", roleID);
        request.setAttribute("statusFilter", status);
        request.setAttribute("searchValue", search);   
        
        
        request.setAttribute("rolesList", rolesList);

        request.getRequestDispatcher("userList.jsp").forward(request, response);
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
