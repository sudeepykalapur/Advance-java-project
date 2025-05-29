// src/com/servlet/ReportServlet.java
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
import java.util.List;

/**
 * Servlet for generating various reports based on user criteria.
 * It uses ReservationDAO to fetch data and forwards the results to report_result.jsp.
 */
@WebServlet("/generateReport")
public class ReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReservationDAO reservationDAO;

    public void init() {
        reservationDAO = new ReservationDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String reportType = request.getParameter("reportType");
        String startDateStr = request.getParameter("startDate");
        String endDateStr = request.getParameter("endDate");
        String customerName = request.getParameter("customerName");

        try {
            switch (reportType) {
                case "reservationsDateRange":
                    if (startDateStr == null || startDateStr.trim().isEmpty() ||
                        endDateStr == null || endDateStr.trim().isEmpty()) {
                        request.setAttribute("errorMessage", "Start and End dates are required for this report.");
                        request.getRequestDispatcher("report_form.jsp").forward(request, response);
                        return;
                    }
                    Date startDate = Date.valueOf(startDateStr);
                    Date endDate = Date.valueOf(endDateStr);
                    List<Reservation> reservationsInRange = reservationDAO.getReservationsInDateRange(startDate, endDate);
                    request.setAttribute("reportTitle", "Reservations in Date Range: " + startDate + " to " + endDate);
                    request.setAttribute("reportData", reservationsInRange);
                    request.setAttribute("reportType", "reservationsDateRange");
                    break;

                case "roomsMostFrequently":
                    List<String[]> frequentRooms = reservationDAO.getRoomsBookedMostFrequently();
                    request.setAttribute("reportTitle", "Rooms Booked Most Frequently (Top 5)");
                    request.setAttribute("reportData", frequentRooms);
                    request.setAttribute("reportType", "roomsMostFrequently");
                    break;

                case "totalRevenue":
                    if (startDateStr == null || startDateStr.trim().isEmpty() ||
                        endDateStr == null || endDateStr.trim().isEmpty()) {
                        request.setAttribute("errorMessage", "Start and End dates are required for this report.");
                        request.getRequestDispatcher("report_form.jsp").forward(request, response);
                        return;
                    }
                    startDate = Date.valueOf(startDateStr);
                    endDate = Date.valueOf(endDateStr);
                    BigDecimal totalRevenue = reservationDAO.getTotalRevenueOverPeriod(startDate, endDate);
                    request.setAttribute("reportTitle", "Total Revenue from " + startDate + " to " + endDate);
                    request.setAttribute("reportData", totalRevenue); // Single value
                    request.setAttribute("reportType", "totalRevenue");
                    break;

                case "reservationsByCustomer":
                    if (customerName == null || customerName.trim().isEmpty()) {
                        request.setAttribute("errorMessage", "Customer Name is required for this report.");
                        request.getRequestDispatcher("report_form.jsp").forward(request, response);
                        return;
                    }
                    List<Reservation> reservationsByCustomer = reservationDAO.getReservationsByCustomer(customerName);
                    request.setAttribute("reportTitle", "Reservations for Customer: " + customerName);
                    request.setAttribute("reportData", reservationsByCustomer);
                    request.setAttribute("reportType", "reservationsByCustomer");
                    break;

                default:
                    request.setAttribute("errorMessage", "Invalid report type selected.");
                    request.getRequestDispatcher("report_form.jsp").forward(request, response);
                    return;
            }
            request.getRequestDispatcher("report_result.jsp").forward(request, response);

        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", "Invalid date format. Please use YYYY-MM-DD.");
            request.getRequestDispatcher("report_form.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while generating the report: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response); // Forward to an error page
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // If someone tries to access this servlet via GET, redirect them to the report form
        response.sendRedirect("reportCriteria"); // Redirect to the servlet that displays the form
    }
}
