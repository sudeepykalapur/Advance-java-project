// src/com/servlet/DisplayReservationsServlet.java
package com.servlet;

import com.dao.ReservationDAO;
import com.model.Reservation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Servlet for displaying all existing reservations.
 * It fetches all reservations from the database using ReservationDAO
 * and forwards them to a JSP page for rendering.
 */
@WebServlet("/displayReservations")
public class DisplayReservationsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReservationDAO reservationDAO;

    public void init() {
        reservationDAO = new ReservationDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Fetch all reservations from the database
            List<Reservation> reservations = reservationDAO.getAllReservations();

            // Set the list of reservations as an attribute in the request scope
            request.setAttribute("reservations", reservations);

            // Forward the request to the JSP page for display
            request.getRequestDispatcher("reservationdisplay.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while fetching reservations: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response); // Forward to an error page
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Typically, display operations are handled by GET requests.
        // If a POST request comes, just redirect to the GET handler.
        doGet(request, response);
    }
}
