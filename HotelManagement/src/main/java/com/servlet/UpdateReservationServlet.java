// src/com/servlet/UpdateReservationServlet.java
package com.servlet;

import com.dao.ReservationDAO;
import com.model.Reservation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;

/**
 * Servlet for handling the update of existing reservations.
 * It retrieves updated reservation details from a form, creates/updates a Reservation object,
 * and uses ReservationDAO to update it in the database.
 */
@WebServlet("/updateReservation")
public class UpdateReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReservationDAO reservationDAO;

    public void init() {
        reservationDAO = new ReservationDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve parameters from the form
        String reservationIDStr = request.getParameter("reservationID");
        String customerName = request.getParameter("customerName");
        String roomNumber = request.getParameter("roomNumber");
        String checkInStr = request.getParameter("checkIn");
        String checkOutStr = request.getParameter("checkOut");
        String totalAmountStr = request.getParameter("totalAmount");

        // Validate and parse parameters
        if (reservationIDStr == null || reservationIDStr.trim().isEmpty() ||
            customerName == null || customerName.trim().isEmpty() ||
            roomNumber == null || roomNumber.trim().isEmpty() ||
            checkInStr == null || checkInStr.trim().isEmpty() ||
            checkOutStr == null || checkOutStr.trim().isEmpty() ||
            totalAmountStr == null || totalAmountStr.trim().isEmpty()) {
            request.setAttribute("errorMessage", "All fields are required for update.");
            request.getRequestDispatcher("reservationupdate.jsp").forward(request, response);
            return;
        }

        try {
            int reservationID = Integer.parseInt(reservationIDStr);
            Date checkIn = Date.valueOf(checkInStr);
            Date checkOut = Date.valueOf(checkOutStr);
            BigDecimal totalAmount = new BigDecimal(totalAmountStr);

            // Create a Reservation object with updated details
            Reservation reservationToUpdate = new Reservation(reservationID, customerName, roomNumber, checkIn, checkOut, totalAmount);

            // Update the reservation in the database
            boolean success = reservationDAO.updateReservation(reservationToUpdate);

            if (success) {
                request.setAttribute("message", "Reservation ID " + reservationID + " updated successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to update reservation ID " + reservationID + ". It might not exist.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("errorMessage", "Invalid Reservation ID. Please enter a valid number.");
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", "Invalid date or amount format. Please use YYYY-MM-DD for dates and a valid number for amount.");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An unexpected error occurred: " + e.getMessage());
        }

        // Forward back to the update page or a confirmation page
        request.getRequestDispatcher("reservationupdate.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // This GET method is used when the user wants to pre-fill the update form
        // with existing reservation data, typically by passing a reservationID.
        String reservationIDStr = request.getParameter("reservationID");
        if (reservationIDStr != null && !reservationIDStr.trim().isEmpty()) {
            try {
                int reservationID = Integer.parseInt(reservationIDStr);
                Reservation reservation = reservationDAO.getReservationById(reservationID);
                if (reservation != null) {
                    request.setAttribute("reservation", reservation);
                } else {
                    request.setAttribute("errorMessage", "Reservation with ID " + reservationID + " not found.");
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Invalid Reservation ID format.");
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("errorMessage", "An error occurred while fetching reservation details: " + e.getMessage());
            }
        }
        // Forward to the JSP page, which will display the form (with pre-filled data if available)
        request.getRequestDispatcher("reservationupdate.jsp").forward(request, response);
    }
}
