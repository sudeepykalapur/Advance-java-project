<%-- WebContent/reservationdisplay.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Reservation" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View All Reservations</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f3f4f6;
        }
        .container {
            max-width: 1000px;
        }
        .card {
            background-color: #ffffff;
            border-radius: 0.75rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
        }
        .btn {
            display: inline-block;
            padding: 0.75rem 1.5rem;
            border-radius: 0.5rem;
            font-weight: 600;
            text-align: center;
            transition: background-color 0.3s ease, transform 0.2s ease;
            background: linear-gradient(135deg, #0f172a, #1e293b);
            color: #ffffff;
        }
        .btn:hover {
            transform: translateY(-2px);
            opacity: 0.9;
        }
        .gradient-text {
            background: linear-gradient(135deg, #0f172a, #1e293b);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .table-header {
            background: linear-gradient(135deg, #0f172a, #1e293b);
            color: #ffffff;
            padding: 0.75rem 1rem;
            text-align: left;
            font-weight: 600;
        }
        .table-cell {
            padding: 0.75rem 1rem;
            border-bottom: 1px solid #e5e7eb;
        }
        .table-row:nth-child(even) {
            background-color: #f9fafb;
        }
        .alert {
            padding: 1rem;
            border-radius: 0.5rem;
            margin-bottom: 1rem;
            font-weight: 500;
        }
        .alert-error {
            background-color: #fee2e2;
            color: #991b1b;
            border: 1px solid #ef4444;
        }
    </style>
</head>
<body class="flex items-center justify-center min-h-screen py-8">
    <div class="container mx-auto p-4 md:p-8">
        <div class="card p-6 md:p-10">
            <h1 class="text-2xl md:text-3xl font-bold text-center gradient-text mb-8">All Reservations</h1>

            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-error">
                    <%= request.getAttribute("errorMessage") %>
                </div>
            <% } %>

            <%
                List<Reservation> reservations = (List<Reservation>) request.getAttribute("reservations");
                if (reservations != null && !reservations.isEmpty()) {
            %>
                <div class="overflow-x-auto">
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
            <% } else { %>
                <p class="text-center text-gray-600 text-lg">No reservations found.</p>
            <% } %>

            <div class="mt-8 text-center">
                <a href="index.jsp" class="btn">Back to Home</a>
            </div>
        </div>
    </div>
</body>
</html>
