<%-- WebContent/report_result.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="com.model.Reservation" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Report Results</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet" />
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
            margin: 0;
            min-height: 100vh;
        }

        /* Fullscreen flex wrapper for centering */
        .flex-center {
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1000px;
            width: 100%;
            background: white;
            border-radius: 1rem;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
            border: 1px solid #e2e8f0;
            padding: 32px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .card {
            background-color: #f9fafb;
            border-radius: 0.75rem;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.05);
            border: 1px solid #e5e7eb;
            padding: 24px;
        }

        /* Heading with dark blue gradient text */
        h1, h2 {
            background: linear-gradient(135deg, #0f172a, #1e293b);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        h1 {
            font-size: 2rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 2rem;
        }

        h2 {
            font-size: 1.5rem;
            font-weight: 600;
            text-align: center;
            margin-bottom: 1.5rem;
        }

        .btn {
            display: inline-block;
            padding: 0.75rem 1.5rem;
            border-radius: 0.5rem;
            font-weight: 600;
            text-align: center;
            transition: background-color 0.3s ease, transform 0.2s ease;
            cursor: pointer;
            text-decoration: none;
            user-select: none;
        }

        .btn-primary {
            background: linear-gradient(135deg, #0f172a, #1e293b);
            color: #ffffff;
        }

        .btn-primary:hover {
            opacity: 0.9;
            transform: translateY(-2px);
        }

        .btn-secondary {
            background: linear-gradient(135deg, #0f172a, #1e293b);
            color: #ffffff;
        }

        .btn-secondary:hover {
            opacity: 0.85;
            transform: translateY(-2px);
        }

        /* Table styles */
        .table-header {
            background: linear-gradient(135deg, #0f172a, #1e293b);
            color: #ffffff;
            padding: 0.75rem 1rem;
            text-align: left;
            font-weight: 600;
            border-bottom: 2px solid #1e293b;
        }

        .table-cell {
            padding: 0.75rem 1rem;
            border-bottom: 1px solid #e5e7eb;
            color: #0f172a;
        }

        .table-row:nth-child(even) {
            background-color: #f1f5f9;
        }

        .alert {
            padding: 1rem;
            border-radius: 0.5rem;
            margin-bottom: 1rem;
            font-weight: 500;
            color: #b91c1c;
            background-color: #fee2e2;
            border: 1px solid #f87171;
        }

        /* Text center for messages */
        .text-center {
            text-align: center;
            color: #0f172a;
        }

        /* Revenue text */
        .revenue-text {
            font-size: 1.5rem;
            font-weight: 700;
            color: #065f46; /* green-700 */
            margin-bottom: 2rem;
            text-align: center;
        }

        /* Buttons container */
        .btn-group {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 1rem;
            margin-top: 2rem;
        }

        .btn-group .btn {
            flex: 1 1 200px;
        }
    </style>
</head>
<body>
    <div class="flex-center">
        <div class="container">
            <div class="card">
                <h1>Report Results</h1>
                <h2><%= request.getAttribute("reportTitle") != null ? request.getAttribute("reportTitle") : "Report" %></h2>

                <%-- Display error messages --%>
                <% if (request.getAttribute("errorMessage") != null) { %>
                    <div class="alert">
                        <%= request.getAttribute("errorMessage") %>
                    </div>
                <% } %>

                <%
                    String reportType = (String) request.getAttribute("reportType");
                    if ("reservationsDateRange".equals(reportType) || "reservationsByCustomer".equals(reportType)) {
                        List<Reservation> reservations = (List<Reservation>) request.getAttribute("reportData");
                        if (reservations != null && !reservations.isEmpty()) {
                %>
                    <div class="overflow-x-auto mb-8">
                        <table class="min-w-full divide-y divide-gray-200 rounded-lg overflow-hidden">
                            <thead>
                                <tr>
                                    <th class="table-header rounded-tl-lg">ID</th>
                                    <th class="table-header">Customer Name</th>
                                    <th class="table-header">Room Number</th>
                                    <th class="table-header">Check-in</th>
                                    <th class="table-header">Check-out</th>
                                    <th class="table-header rounded-tr-lg">Total Amount</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <% for (Reservation res : reservations) { %>
                                    <tr class="table-row">
                                        <td class="table-cell"><%= res.getReservationID() %></td>
                                        <td class="table-cell"><%= res.getCustomerName() %></td>
                                        <td class="table-cell"><%= res.getRoomNumber() %></td>
                                        <td class="table-cell"><%= res.getCheckIn() %></td>
                                        <td class="table-cell"><%= res.getCheckOut() %></td>
                                        <td class="table-cell">$<%= String.format("%.2f", res.getTotalAmount()) %></td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                <%
                        } else {
                %>
                    <p class="text-center text-gray-600 text-lg mb-8">No reservations found for the given criteria.</p>
                <%
                        }
                    } else if ("roomsMostFrequently".equals(reportType)) {
                        List<String[]> frequentRooms = (List<String[]>) request.getAttribute("reportData");
                        if (frequentRooms != null && !frequentRooms.isEmpty()) {
                %>
                    <div class="overflow-x-auto mb-8">
                        <table class="min-w-full divide-y divide-gray-200 rounded-lg overflow-hidden">
                            <thead>
                                <tr>
                                    <th class="table-header rounded-tl-lg">Room Number</th>
                                    <th class="table-header rounded-tr-lg">Booking Count</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <% for (String[] roomData : frequentRooms) { %>
                                    <tr class="table-row">
                                        <td class="table-cell"><%= roomData[0] %></td>
                                        <td class="table-cell"><%= roomData[1] %></td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                <%
                        } else {
                %>
                    <p class="text-center text-gray-600 text-lg mb-8">No room booking data available.</p>
                <%
                        }
                    } else if ("totalRevenue".equals(reportType)) {
                        BigDecimal totalRevenue = (BigDecimal) request.getAttribute("reportData");
                %>
                    <div class="revenue-text">
                        Total Revenue: $<%= totalRevenue != null ? String.format("%.2f", totalRevenue) : "0.00" %>
                    </div>
                <%
                    } else {
                %>
                    <p class="text-center text-gray-600 text-lg mb-8">No report data to display or invalid report type.</p>
                <%
                    }
                %>

                <div class="btn-group">
                    <a href="reportCriteria" class="btn btn-secondary">Generate Another Report</a>
                    <a href="index.jsp" class="btn btn-secondary">Back to Home</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
