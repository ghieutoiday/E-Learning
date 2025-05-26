/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.PostDAO;
import java.io.IOException;
import java.io.PrintWriter; 
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Post;
import java.io.File;
import java.util.Date;
import jakarta.servlet.http.Part;
import dal.PostCategoryDAO;
import model.PostCategory;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author toans
 */
public class PostController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PostDAO postDAO= new PostDAO();
    private static final int POSTS_PER_PAGE = 5;
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
             
             String action = request.getParameter("action");
             
             if ("add".equals(action)) {
                 try {
                     // Handle add post
                     String title = request.getParameter("title");
                     String categoryId = request.getParameter("category");
                     String briefInfo = request.getParameter("briefInfo");
                     String description = request.getParameter("description");
                     String status = request.getParameter("status");
                     boolean feature = "true".equals(request.getParameter("feature"));
                     
                     // Handle file upload
                     Part thumbnailPart = request.getPart("thumbnail");
                     String thumbnailFileName = "";
                     if (thumbnailPart != null && thumbnailPart.getSize() > 0) {
                         String submittedFileName = thumbnailPart.getSubmittedFileName();
                         String extension = submittedFileName.substring(submittedFileName.lastIndexOf("."));
                         thumbnailFileName = System.currentTimeMillis() + extension;
                         
                         // Save file to server
                         String uploadPath = getServletContext().getRealPath("/uploads");
                         File uploadDir = new File(uploadPath);
                         if (!uploadDir.exists()) {
                             uploadDir.mkdir();
                         }
                         
                         thumbnailPart.write(uploadPath + File.separator + thumbnailFileName);
                         thumbnailFileName = "uploads/" + thumbnailFileName;
                     }
                     
                     // Create new post
                     Post post = new Post();
                     post.setTitle(title);
                     post.setBriefInfo(briefInfo);
                     post.setDescription(description);
                     post.setStatus(status);
                     post.setFeature(feature);
                     post.setThumbnail(thumbnailFileName);
                     post.setCreateDate(new Date());
                     post.setUpdateDate(new Date());
                     
                     // Set category
                     PostCategoryDAO categoryDAO = new PostCategoryDAO();
                     PostCategory category = categoryDAO.getCategoryByID(Integer.parseInt(categoryId));
                     post.setPostCategory(category);
                     
                     // Set owner (get from session)
                     HttpSession session = request.getSession();
                     User owner = (User) session.getAttribute("user");
                     post.setOwner(owner);
                     
                     // Save post
                     boolean success = postDAO.addPost(post);
                     
                     if (success) {
                         // Redirect to posts list on success
                         response.sendRedirect("PostController");
                         return;
                     } else {
                         // Handle error
                         request.setAttribute("error", "Failed to add post");
                         request.getRequestDispatcher("admin/addpost.jsp").forward(request, response);
                         return;
                     }
                 } catch (Exception e) {
                     // Log error and handle exception
                     e.printStackTrace();
                     request.setAttribute("error", "An error occurred: " + e.getMessage());
                     request.getRequestDispatcher("admin/addpost.jsp").forward(request, response);
                     return;
                 }
             }
             
             // Handle show add post page
             if ("showAddPost".equals(action)) {
                 // Get all categories for the dropdown
                 request.setAttribute("categories", postDAO.getAllCategories());
                 request.getRequestDispatcher("admin/addpost.jsp").forward(request, response);
                 return;
             }
             
             // Handle view post details
             if ("view".equals(action)) {
                 String postId = request.getParameter("id");
                 if (postId != null && !postId.isEmpty()) {
                     Post post = postDAO.getPostByID(Integer.parseInt(postId));
                     if (post != null) {
                         request.setAttribute("post", post);
                         request.getRequestDispatcher("admin/postdetail.jsp").forward(request, response);
                         return;
                     }
                 }
                 // If post not found or invalid ID, redirect to posts list
                 response.sendRedirect("PostController");
                 return;
             }
             
             // Handle delete post
             if ("delete".equals(action)) {
                 String postId = request.getParameter("id");
                 if (postId != null && !postId.isEmpty()) {
                     boolean success = postDAO.deletePost(Integer.parseInt(postId));
                     if (success) {
                         // Redirect to posts list on success
                         response.sendRedirect("PostController");
                         return;
                     } else {
                         // Handle error
                         request.setAttribute("error", "Failed to delete post");
                         request.getRequestDispatcher("admin/postslist.jsp").forward(request, response);
                         return;
                     }
                 }
                 // If no post ID provided, redirect to posts list
                 response.sendRedirect("PostController");
                 return;
             }
             
             // Original code for listing posts
             String search = request.getParameter("search");
             String sortBy = request.getParameter("sortBy");
             String category = request.getParameter("category");
             String author = request.getParameter("author");
             String dateFilter = request.getParameter("dateFilter");
             String status = request.getParameter("status");
             String feature = request.getParameter("feature");
             
             int page = 1;
             if (request.getParameter("page") != null) {
                 page = Integer.parseInt(request.getParameter("page"));
             }
             
             List<Post> posts;
             int totalPosts;
             
             // Get filter data
             request.setAttribute("categories", postDAO.getAllCategories());
             request.setAttribute("authors", postDAO.getAllAuthors());
             
             // Apply filters and get posts
             posts = postDAO.getFilteredPosts(search, sortBy, category, author, dateFilter, status, feature, page, POSTS_PER_PAGE);
             totalPosts = postDAO.getTotalFilteredPosts(search, category, author, dateFilter, status, feature);
             
             int totalPages = (int) Math.ceil((double) totalPosts / POSTS_PER_PAGE);
             
             request.setAttribute("posts", posts);
             request.setAttribute("currentPage", page);
             request.setAttribute("totalPages", totalPages);
             request.setAttribute("search", search);
             request.setAttribute("sortBy", sortBy);
             request.setAttribute("category", category);
             request.setAttribute("author", author);
             request.setAttribute("dateFilter", dateFilter);
             request.setAttribute("status", status);
             request.setAttribute("feature", feature);
             request.setAttribute("checkNull", totalPages);
             
             request.getRequestDispatcher("admin/postslist.jsp").forward(request, response);
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
        processRequest(request, response);
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
