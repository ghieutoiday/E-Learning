/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.BlogDAO;
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
@WebServlet(name = "BlogController", urlPatterns = {"/blogcontroller"})
public class BlogController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final int BLOGS_PER_PAGE = 5; // Số blog mỗi trang

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

        //Lấy postID từ BlogDetail (ở chỗ Recent Post) or BlogList sau khi click vào bài viết
        String postID_raw = request.getParameter("postID");
        //Set postID ban đầu bằng -1 để lấy ngoại lệ
        int postID;
        if (postID_raw != null && !postID_raw.isBlank()) {
            try {
                postID = Integer.parseInt(postID_raw);
                //Lấy và tạo 1 attribute PostDetail cụ thể để hiện thị trong trang Blog Detail
                Post postDetail = BlogDAO.getInstance().getPostByID(postID);
                request.setAttribute("postDetail", postDetail);

            } catch (NumberFormatException e) {
                System.out.println(e);
            }
        }

        //Chức năng lọc theo PostCategory
        String postCategoryID_raw = request.getParameter("postCategoryID");
        int postCategoryID;

        //Lấy và tạo attribute Post List, này để Thịnh dùng
        // Get filter parameters
        String pageStr = request.getParameter("page");
        int page = 1;
        if (pageStr != null && !pageStr.isEmpty()) {
            page = Integer.parseInt(pageStr);
        }

        int totalBlogs = -1;

        //Chức năng SEARCH
        //Lấy title từ thanh search để search
        String titleSearch = request.getParameter("titleSearch");
        if (titleSearch != null && !titleSearch.isBlank()) {
            List<Post> listPostByTitle = BlogDAO.getInstance().getAllPostByTitle(titleSearch, page, BLOGS_PER_PAGE);
            //listPost này để truyền qua blog list để hiển thị
            //cả 3 trường hợp if đều dùng chung 1 cái attribute tên là listPost
            request.setAttribute("listPost", listPostByTitle);

            //Lấy tổng số bài post có title match với titleSearch 
            //để phục vụ cho việc phân trang
            totalBlogs = BlogDAO.getInstance().getTotalPostAfterSearch(titleSearch);
        } else if (postCategoryID_raw != null && !postCategoryID_raw.isBlank()) {
            try {
                postCategoryID = Integer.parseInt(postCategoryID_raw);
                //Lấy ra List Post có postCategoryID = bằng postCategoryID đưa vô
                List<Post> listPostByCategory = BlogDAO.getInstance().getAllPostByPostCategoryID(postCategoryID, page, BLOGS_PER_PAGE);
                request.setAttribute("listPost", listPostByCategory);
                //cần sửa
                totalBlogs = BlogDAO.getInstance().getTotalPostAfterFilterPostCategory(postCategoryID);

            } catch (NumberFormatException e) {
                System.out.println(e);
            }
        } else {
            List<Post> listPost = BlogDAO.getInstance().getAllPost(page, BLOGS_PER_PAGE);
            request.setAttribute("listPost", listPost);
            totalBlogs = BlogDAO.getInstance().getTotalPost();
        }

        int totalPages = (int) Math.ceil((double) totalBlogs / BLOGS_PER_PAGE);

        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalBlogs", totalBlogs);
        request.setAttribute("BLOGS_PER_PAGE", BLOGS_PER_PAGE);

        //Lấy và tạo ra attribute PostCategory
        List<PostCategory> listPostCategory = BlogDAO.getInstance().getAllPostCategory();
        request.setAttribute("listPostCategory", listPostCategory);

        //Lấy 5 bài Post có createDate mới nhất để hiển thị
        List<Post> listRecentPost = BlogDAO.getInstance().getRecentPost();
        request.setAttribute("listRecentPost", listRecentPost);

        //Lấy page để Chọn trang nào đc forward sang
        String pageforward = request.getParameter("pageforward");
        if (pageforward.equalsIgnoreCase("bloglist")) {
            request.getRequestDispatcher("blog-list-sidebar.jsp").forward(request, response);
        } else if (pageforward.equalsIgnoreCase("blogdetail")) {
            request.getRequestDispatcher("blog-details.jsp").forward(request, response);
        }

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
