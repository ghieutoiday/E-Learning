/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.PostDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Post;
import model.PostCategory;

/**
 *
 * @author ASUS
 */
@WebServlet(name = "PostController", urlPatterns = {"/postcontroller"})
public class PostController extends HttpServlet {

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
            out.println("<title>Servlet PostController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PostController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    //compiler -- tạo biến static 1 lần
    //runtime -- tạo biến và gán trên bộ nhớ ram
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    public int searchPostByTitle(String title) {
        if (title == null || title.isBlank()) {
            return 0;
        } else {

            return 1;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //Lấy postID từ BlogDetail (ở chỗ Recent Post) or BlogList sau khi click vào bài viết
        String postID_raw = request.getParameter("postID");
        //Set postID ban đầu bằng -1 để lấy ngoại lệ
        int postID;
        if (postID_raw != null && !postID_raw.isBlank()) {
            try {
                postID = Integer.parseInt(postID_raw);
                //Lấy và tạo 1 attribute PostDetail cụ thể để hiện thị trong trang Blog Detail
                Post postDetail = PostDAO.getInstance().getPostByID(postID);
                request.setAttribute("postDetail", postDetail);

            } catch (NumberFormatException e) {
                System.out.println(e);
            }
        }

        //Chức năng SEARCH
        //Lấy title từ thanh search để search
        String titleSearch = request.getParameter("titleSearch");

        if (titleSearch != null && !titleSearch.isBlank()) {
            List<Post> listPostByTitle = PostDAO.getInstance().getAllPostByTitle(titleSearch);
            request.setAttribute("listPostByTitle", listPostByTitle);
            request.getRequestDispatcher("blog-classic-sidebar.jsp").forward(request, response);
            return;
        }

        //Chức năng lọc theo PostCategory
        String postCategoryID_raw = request.getParameter("postCategoryID");
        int postCategoryID;

        if (postCategoryID_raw != null && !postCategoryID_raw.isBlank()) {
            try {
                postCategoryID = Integer.parseInt(postCategoryID_raw);
                //Lấy ra List Post có postCategoryID = bằng postCategoryID đưa vô
                List<Post> listPostByCategory = PostDAO.getInstance().getAllPostByPostCategoryID(postCategoryID);
                request.setAttribute("listPostByCategory", listPostByCategory);
                request.getRequestDispatcher("blog-classic-sidebar.jsp").forward(request, response);
                return;

            } catch (NumberFormatException e) {
                System.out.println(e);
            }
        }

        //Lấy và tạo attribute Post List, này để Thịnh dùng
        List<Post> listPost = PostDAO.getInstance().getAllPost();
        request.setAttribute("listPost", listPost);

        //Lấy và tạo ra attribute PostCategory
        List<PostCategory> listPostCategory = PostDAO.getInstance().getAllPostCategory();
        request.setAttribute("listPostCategory", listPostCategory);

        //Lấy 5 bài Post có createDate mới nhất để hiển thị
        List<Post> listRecentPost = PostDAO.getInstance().getRecentPost();
        request.setAttribute("listRecentPost", listRecentPost);

        request.getRequestDispatcher("blog-details.jsp").forward(request, response);
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
