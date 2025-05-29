// src/com/servlet/DeleteReservationServlet.java
package com.servlet;

import com.dao.ReservationDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet for handling the deletion of reservations.
 * It receives a reservation ID from a form and uses ReservationDAO to delete it from the database.
 */
@WebServlet("/deleteReservation")
public class DeleteReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReservationDAO reservationDAO;

    public void init() {
        reservationDAO = new ReservationDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve reservation ID from the form
        String reservationIDStr = request.getParameter("reservationID");

        if (reservationIDStr == null || reservationIDStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Reservation ID is required for deletion.");
            request.getRequestDispatcher("reservationdelete.jsp").forward(request, response);
            return;
        }

        try {
            int reservationID = Integer.parseInt(reservationIDStr);

            // Delete the reservation from the database
            boolean success = reservationDAO.deleteReservation(reservationID);

            if (success) {
                request.setAttribute("message", "Reservation ID " + reservationID + " deleted successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to delete reservation ID " + reservationID + ". It might not exist.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid Reservation ID format. Please enter a valid number.");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An unexpected error occurred: " + e.getMessage());
        }

        // Forward back to the delete page or a confirmation page
        request.getRequestDispatcher("reservationdelete.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // If someone tries to access this servlet via GET, redirect them to the delete form
        response.sendRedirect("reservationdelete.jsp");
    }
}
