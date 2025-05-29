// src/com/servlet/ReportCriteriaServlet.java
package com.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet for displaying the report criteria form.
 * This servlet simply forwards the request to the report_form.jsp page,
 * where users can select criteria for various reports.
 */
@WebServlet("/reportCriteria")
public class ReportCriteriaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Forward to the JSP page that contains the report criteria form
        request.getRequestDispatcher("report_form.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Typically, displaying a form is a GET request.
        // If a POST request comes here, just redirect to GET.
        doGet(request, response);
    }
}
