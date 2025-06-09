/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.SliderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.Slider;

/**
 *
 * @author toans
 */
@WebServlet(name = "SliderController", urlPatterns = {"/slidercontroller"})
public class SliderController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private SliderDAO sliderDAO = new SliderDAO();
    private static final int SLIDERS_PER_PAGE = 5;

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
                    String deleteSliderId = request.getParameter("id");
                    if (deleteSliderId != null && !deleteSliderId.isEmpty()) {
                        sliderDAO.deleteSlider(Integer.parseInt(deleteSliderId));
                    }
                    response.sendRedirect("slidercontroller");
                    break;
                    
                case "list":
                    String search = request.getParameter("search"); 
                    String status = request.getParameter("status");
                    int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
                    int rowsPerPage = request.getParameter("rowsPerPage") != null ? Integer.parseInt(request.getParameter("rowsPerPage")) : SLIDERS_PER_PAGE;

                    // Column visibility parameters
                    boolean hideID = "true".equals(request.getParameter("hideID"));
                    boolean hideTitle = "true".equals(request.getParameter("hideTitle"));
                    boolean hideBacklink = "true".equals(request.getParameter("hideBacklink"));
                    boolean hideStatus = "true".equals(request.getParameter("hideStatus"));

                    List<Slider> sliders = sliderDAO.getFilteredSliders(search, status, page, rowsPerPage);
                    int totalSliders = sliderDAO.getTotalFilteredSliders(search, status);
                    int totalPages = (totalSliders + rowsPerPage - 1) / rowsPerPage;

                    request.setAttribute("sliders", sliders);
                    request.setAttribute("totalPages", totalPages);
                    request.setAttribute("currentPage", page);
                    request.setAttribute("search", search); 
                    request.setAttribute("status", status);
                    request.setAttribute("rowsPerPage", rowsPerPage);

                    request.setAttribute("hideID", hideID);
                    request.setAttribute("hideTitle", hideTitle);
                    request.setAttribute("hideBacklink", hideBacklink);
                    request.setAttribute("hideStatus", hideStatus);

                    request.getRequestDispatcher("/admin/sliderlist.jsp").forward(request, response);
                    break;

                case "view":
                    String sliderId = request.getParameter("id");
                    if (sliderId != null && !sliderId.isEmpty()) {
                        Slider slider = sliderDAO.getSliderById(Integer.parseInt(sliderId));
                        request.setAttribute("slider", slider);
                        request.getRequestDispatcher("/admin/sliderdetail.jsp").forward(request, response);
                    } else {
                        response.sendRedirect("slidercontroller");
                    }
                    break;

                case "showAddForm":
                    request.getRequestDispatcher("/admin/addslider.jsp").forward(request, response);
                    break;

                case "showEditForm":
                    String editSliderId = request.getParameter("id");
                    if (editSliderId != null && !editSliderId.isEmpty()) {
                        Slider slider = sliderDAO.getSliderById(Integer.parseInt(editSliderId));
                        request.setAttribute("slider", slider);
                        request.getRequestDispatcher("/admin/editslider.jsp").forward(request, response);
                    } else {
                        response.sendRedirect("slidercontroller");
                    }
                    break;

                case "toggleStatus":
                    String toggleSliderId = request.getParameter("id");
                    if (toggleSliderId != null && !toggleSliderId.isEmpty()) {
                        Slider slider = sliderDAO.getSliderById(Integer.parseInt(toggleSliderId));
                        slider.setStatus(slider.getStatus().equals("Active") ? "Inactive" : "Active");
                        sliderDAO.updateSlider(slider);
                    }
                    response.sendRedirect("slidercontroller" );
                    break;

                default:
                    response.sendRedirect("slidercontroller");
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
                    String title = request.getParameter("title");
                    String image = request.getParameter("image");
                    String backlink = request.getParameter("backlink");
                    String status = request.getParameter("status");
                    String notes = request.getParameter("notes");

                    Slider slider = new Slider();
                    slider.setTitle(title);
                    slider.setImage(image);
                    slider.setBacklink(backlink);
                    slider.setStatus(status);
                    slider.setNotes(notes);

                    sliderDAO.addSlider(slider);
                    response.sendRedirect("slidercontroller");
                    break;

                case "edit":
                    int editSliderId = Integer.parseInt(request.getParameter("sliderID"));
                    String editTitle = request.getParameter("title");
                    String editImage = request.getParameter("image");
                    String editBacklink = request.getParameter("backlink");
                    String editStatus = request.getParameter("status");
                    String editNotes = request.getParameter("notes");

                    Slider editSlider = sliderDAO.getSliderById(editSliderId);
                    if (editSlider != null) {
                        editSlider.setTitle(editTitle);
                        editSlider.setImage(editImage);
                        editSlider.setBacklink(editBacklink);
                        editSlider.setStatus(editStatus);
                        editSlider.setNotes(editNotes);

                        sliderDAO.updateSlider(editSlider);
                    }
                    response.sendRedirect("slidercontroller");
                    break;

                default:
                    response.sendRedirect("slidercontroller");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    public String getServletInfo() {
        return "Slider Controller";
    }
}
