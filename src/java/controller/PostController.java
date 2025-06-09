/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.PostDAO;
import dal.PostCategoryDAO;
import dal.UserDAO;
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
import jakarta.servlet.annotation.WebServlet;
import model.PostCategory;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author toans
 */
@WebServlet(name = "PostController", urlPatterns = { "/postcontroller" })
public class PostController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private PostDAO postDAO = new PostDAO();
    private static final int POSTS_PER_PAGE = 5;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        if (action == null) {
            action = "list";
        }

        try {
            switch (action) {
                case "delete":
                    String deletePostId = request.getParameter("id");
                    if (deletePostId != null && !deletePostId.isEmpty()) {
                        postDAO.deletePost(Integer.parseInt(deletePostId));
                    }
                    response.sendRedirect("postcontroller");
                    break;

                case "list":
                    String search = request.getParameter("search");
                    String sortBy = request.getParameter("sortBy");
                    String category = request.getParameter("category");
                    String author = request.getParameter("author");
                    String dateFilter = request.getParameter("dateFilter");
                    String status = request.getParameter("status");
                    String feature = request.getParameter("feature");
                    int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page"))
                            : 1;

                    List<Post> posts = postDAO.getFilteredPosts(search, sortBy, category, author, dateFilter, status,
                            feature, page, POSTS_PER_PAGE);
                    int totalPosts = postDAO.getTotalFilteredPosts(search, category, author, dateFilter, status,
                            feature);
                    int totalPages = (totalPosts + POSTS_PER_PAGE - 1) / POSTS_PER_PAGE;

                    request.setAttribute("posts", posts);
                    request.setAttribute("totalPages", totalPages);
                    request.setAttribute("currentPage", page);
                    request.setAttribute("categories", postDAO.getAllCategories());
                    request.setAttribute("authors", postDAO.getAllAuthors());
                    request.setAttribute("search", search);
                    request.setAttribute("sortBy", sortBy);
                    request.setAttribute("category", category);
                    request.setAttribute("author", author);
                    request.setAttribute("dateFilter", dateFilter);
                    request.setAttribute("status", status);
                    request.setAttribute("feature", feature);

                    request.getRequestDispatcher("/admin/postslist.jsp").forward(request, response);
                    break;

                case "view":
                    String postId = request.getParameter("id");
                    if (postId != null && !postId.isEmpty()) {
                        Post post = postDAO.getPostByID(Integer.parseInt(postId));
                        request.setAttribute("post", post);
                        request.getRequestDispatcher("/admin/postdetail.jsp").forward(request, response);
                    } else {
                        response.sendRedirect("postcontroller");
                    }
                    break;
                case "viewdetail":
                    String idPost = request.getParameter("id");
                    if (idPost != null && !idPost.isEmpty()) {
                        Post post = postDAO.getPostByID(Integer.parseInt(idPost));
                        request.setAttribute("post", post);
                        request.getRequestDispatcher("/post-details.jsp").forward(request, response);
                    } else {
                        response.sendRedirect("postcontroller");
                    }
                    break;
                case "showAddForm":
                    request.setAttribute("categories", postDAO.getAllCategories());
                    request.getRequestDispatcher("/admin/addpost.jsp").forward(request, response);
                    break;

                case "showEditForm":
                    String editPostId = request.getParameter("id");
                    if (editPostId != null && !editPostId.isEmpty()) {
                        Post post = postDAO.getPostByID(Integer.parseInt(editPostId));
                        request.setAttribute("post", post);
                        request.setAttribute("categories", postDAO.getAllCategories());
                        request.getRequestDispatcher("/admin/editpost.jsp").forward(request, response);
                    } else {
                        response.sendRedirect("postcontroller");
                    }
                    break;

                default:
                    response.sendRedirect("postcontroller");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            switch (action) {
                case "add":
                    UserDAO userDAO = new UserDAO();
                    User owner = userDAO.getUserByEmail("tranthibich@gmail.com");

                    if (owner == null) {
                        request.setAttribute("error", "Default owner not found");
                        request.setAttribute("categories", postDAO.getAllCategories());
                        request.getRequestDispatcher("/admin/addpost.jsp").forward(request, response);
                        return;
                    }

                    String title = request.getParameter("title");
                    String categoryId = request.getParameter("category");
                    String briefInfo = request.getParameter("briefInfo");
                    String description = request.getParameter("description");
                    String status = request.getParameter("status");
                    boolean feature = request.getParameter("feature") != null;
                    String thumbnail = request.getParameter("thumbnail");

                    Post post = new Post();
                    post.setTitle(title);
                    post.setBriefInfo(briefInfo);
                    post.setDescription(description);
                    post.setStatus(status);
                    post.setFeature(feature);
                    post.setThumbnail(thumbnail);
                    post.setCreateDate(new Date());
                    post.setUpdateDate(new Date());
                    post.setOwner(owner);

                    PostCategoryDAO categoryDAO = new PostCategoryDAO();
                    PostCategory category = categoryDAO.getPostCategoryByID(Integer.parseInt(categoryId));
                    post.setPostCategory(category);

                    postDAO.addPost(post);
                    response.sendRedirect("postcontroller");
                    break;

                case "edit":
                    int editPostId = Integer.parseInt(request.getParameter("id"));
                    String editTitle = request.getParameter("title");
                    String editCategoryId = request.getParameter("category");
                    String editBriefInfo = request.getParameter("briefInfo");
                    String editDescription = request.getParameter("description");
                    String editStatus = request.getParameter("status");
                    boolean editFeature = request.getParameter("feature") != null;
                    String editThumbnail = request.getParameter("thumbnail");

                    Post editPost = postDAO.getPostByID(editPostId);
                    if (editPost != null) {
                        editPost.setTitle(editTitle);
                        editPost.setBriefInfo(editBriefInfo);
                        editPost.setDescription(editDescription);
                        editPost.setStatus(editStatus);
                        editPost.setFeature(editFeature);
                        editPost.setThumbnail(editThumbnail);
                        editPost.setUpdateDate(new Date());

                        PostCategoryDAO editCategoryDAO = new PostCategoryDAO();
                        PostCategory editCategory = editCategoryDAO
                                .getPostCategoryByID(Integer.parseInt(editCategoryId));
                        editPost.setPostCategory(editCategory);

                        postDAO.updatePost(editPost);
                    }
                    response.sendRedirect("postcontroller");
                    break;

                default:
                    response.sendRedirect("postcontroller");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Post Controller";
    }
}
