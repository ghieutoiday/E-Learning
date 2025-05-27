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
import model.User;

/**
 *
 * @author gtrun
 */
@WebServlet(name = "UserController", urlPatterns = {"/usercontroller"})
public class UserController extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("change-password.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if( action.equals("changePassword")){
            UserDAO userDao = new UserDAO();
            String mess = "";
            String email = request.getParameter("email");
            User user = userDao.getUserByEmail(email);
            String password = request.getParameter("password");
            String newPassword = request.getParameter("newPassword");
            String confirmPassword = request.getParameter("confirmPassword");
            if (user == null) {
                mess = "Email not exist!";
                request.setAttribute("mess", mess);
            } else {
                if (!password.equals(user.getPassword())) {
                    mess = "Password is fail!";
                    request.setAttribute("mess", mess);
                } else if (newPassword.equals(user.getPassword()) || newPassword.equals(password)) {
                    mess = "New password is same old password!";
                    request.setAttribute("mess", mess);
                } else if (!newPassword.equals(confirmPassword)) {
                    mess = "New password is different Confirm password!";
                    request.setAttribute("mess", mess);
                } else {
                    userDao.UpdatePassword(newPassword, email);
                    mess = "Change Password Succes";
                    request.setAttribute("mess", mess);
                }
            }
        }
        

        request.getRequestDispatcher("change-password.jsp").forward(request, response);

    }


    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
