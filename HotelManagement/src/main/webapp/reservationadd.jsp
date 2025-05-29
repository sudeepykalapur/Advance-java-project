<%-- WebContent/reservationadd.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Reservation</title>
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
            filter: brightness(1.1);
            transform: translateY(-2px);
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
            border: 1px solid #d1d5db; /* gray-300 */
            border-radius: 0.5rem;
            width: 100%;
            box-sizing: border-box;
        }
        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: #374151; /* gray-700 */
        }
        .alert {
            padding: 1rem;
            border-radius: 0.5rem;
            margin-bottom: 1rem;
            font-weight: 500;
        }
        .alert-success {
            background-color: #d1fae5; /* green-100 */
            color: #065f46; /* green-800 */
            border: 1px solid #34d399; /* green-400 */
        }
        .alert-error {
            background-color: #fee2e2; /* red-100 */
            color: #991b1b; /* red-800 */
            border: 1px solid #ef4444; /* red-500 */
        }
        .gradient-text {
            background: linear-gradient(135deg, #0f172a, #1e293b);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
    </style>
</head>
<body class="flex items-center justify-center min-h-screen">
    <div class="container mx-auto p-4 md:p-8">
        <div class="card p-6 md:p-10">
            <h1 class="text-2xl md:text-3xl font-bold text-center gradient-text mb-8">Add New Reservation</h1>

            <%-- Display success or error messages --%>
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

            <form action="addReservation" method="post" class="space-y-6">
                <div>
                    <label for="customerName" class="form-label">Customer Name:</label>
                    <input type="text" id="customerName" name="customerName" class="form-input" required>
                </div>
                <div>
                    <label for="roomNumber" class="form-label">Room Number:</label>
                    <input type="text" id="roomNumber" name="roomNumber" class="form-input" required>
                </div>
                <div>
                    <label for="checkIn" class="form-label">Check-in Date:</label>
                    <input type="date" id="checkIn" name="checkIn" class="form-input" required>
                </div>
                <div>
                    <label for="checkOut" class="form-label">Check-out Date:</label>
                    <input type="date" id="checkOut" name="checkOut" class="form-input" required>
                </div>
                <div>
                    <label for="totalAmount" class="form-label">Total Amount:</label>
                    <input type="number" step="0.01" id="totalAmount" name="totalAmount" class="form-input" required>
                </div>
                <div class="flex flex-col sm:flex-row justify-between space-y-4 sm:space-y-0 sm:space-x-4">
                    <button type="submit" class="btn btn-primary w-full sm:w-auto">Add Reservation</button>
                    <a href="index.jsp" class="btn btn-secondary w-full sm:w-auto">Back to Home</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
