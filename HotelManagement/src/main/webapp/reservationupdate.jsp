<%-- WebContent/reservationupdate.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Reservation" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Reservation</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f3f4f6;
        }
        .container {
            max-width: 700px;
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
        }
        .btn-primary {
            background: linear-gradient(135deg, #0f172a, #1e293b);
            color: #ffffff;
        }
        .btn-primary:hover {
            transform: translateY(-2px);
            opacity: 0.9;
        }
        .btn-secondary {
            background-color: #6b7280;
            color: #ffffff;
        }
        .btn-secondary:hover {
            background-color: #4b5563;
            transform: translateY(-2px);
        }
        .form-input {
            padding: 0.75rem 1rem;
            border: 1px solid #d1d5db;
            border-radius: 0.5rem;
            width: 100%;
            box-sizing: border-box;
        }
        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: #374151;
        }
        .alert {
            padding: 1rem;
            border-radius: 0.5rem;
            margin-bottom: 1rem;
            font-weight: 500;
        }
        .alert-success {
            background-color: #d1fae5;
            color: #065f46;
            border: 1px solid #34d399;
        }
        .alert-error {
            background-color: #fee2e2;
            color: #991b1b;
            border: 1px solid #ef4444;
        }
    </style>
</head>
<body class="flex items-center justify-center min-h-screen">
    <div class="container mx-auto p-4 md:p-8">
        <div class="card p-6 md:p-10">
            <h1 class="text-2xl md:text-3xl font-bold text-center bg-gradient-to-r from-gray-900 to-gray-700 bg-clip-text text-transparent mb-8">Update Reservation</h1>

            <% if (request.getAttribute("message") != null) { %>
                <div class="alert alert-success">
                    <%= request.getAttribute("message") %>
                </div>
            <% } %>
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="alert alert-error">
                    <%= request.getAttribute("errorMessage") %>
                </div>
            <% } %>

            <form action="updateReservation" method="get" class="mb-8 space-y-4">
                <p class="text-gray-700 text-lg font-semibold">First, search for a reservation by ID:</p>
                <div class="flex flex-col sm:flex-row items-center gap-4">
                    <input type="number" id="searchReservationID" name="reservationID"
                           placeholder="Enter Reservation ID" class="form-input flex-grow" required
                           value="<%= request.getParameter("reservationID") != null ? request.getParameter("reservationID") : "" %>">
                    <button type="submit" class="btn btn-secondary w-full sm:w-auto">Search</button>
                </div>
            </form>

            <%
                Reservation reservation = (Reservation) request.getAttribute("reservation");
                if (reservation != null) {
            %>
                <hr class="my-8 border-gray-300">
                <h2 class="text-xl md:text-2xl font-bold text-center text-indigo-600 mb-6">Edit Reservation Details</h2>
                <form action="updateReservation" method="post" class="space-y-6">
                    <div>
                        <label for="reservationID" class="form-label">Reservation ID:</label>
                        <input type="text" id="reservationID" name="reservationID" class="form-input bg-gray-100 cursor-not-allowed"
                               value="<%= reservation.getReservationID() %>" readonly>
                    </div>
                    <div>
                        <label for="customerName" class="form-label">Customer Name:</label>
                        <input type="text" id="customerName" name="customerName" class="form-input"
                               value="<%= reservation.getCustomerName() %>" required>
                    </div>
                    <div>
                        <label for="roomNumber" class="form-label">Room Number:</label>
                        <input type="text" id="roomNumber" name="roomNumber" class="form-input"
                               value="<%= reservation.getRoomNumber() %>" required>
                    </div>
                    <div>
                        <label for="checkIn" class="form-label">Check-in Date:</label>
                        <input type="date" id="checkIn" name="checkIn" class="form-input"
                               value="<%= reservation.getCheckIn() %>" required>
                    </div>
                    <div>
                        <label for="checkOut" class="form-label">Check-out Date:</label>
                        <input type="date" id="checkOut" name="checkOut" class="form-input"
                               value="<%= reservation.getCheckOut() %>" required>
                    </div>
                    <div>
                        <label for="totalAmount" class="form-label">Total Amount:</label>
                        <input type="number" step="0.01" id="totalAmount" name="totalAmount" class="form-input"
                               value="<%= reservation.getTotalAmount() %>" required>
                    </div>
                    <div class="flex flex-col sm:flex-row justify-between space-y-4 sm:space-y-0 sm:space-x-4">
                        <button type="submit" class="btn btn-primary w-full sm:w-auto">Update Reservation</button>
                        <a href="index.jsp" class="btn btn-secondary w-full sm:w-auto">Back to Home</a>
                    </div>
                </form>
            <%
                } else if (request.getParameter("reservationID") != null && !request.getParameter("reservationID").trim().isEmpty()) {
            %>
                <p class="text-center text-red-600 font-semibold">No reservation found with ID: <%= request.getParameter("reservationID") %></p>
            <%
                }
            %>
            <div class="mt-8 text-center">
                <a href="index.jsp" class="btn btn-secondary">Back to Home</a>
            </div>
        </div>
    </div>
</body>
</html>
