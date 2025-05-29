<%-- WebContent/reservationdelete.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cancel Reservation</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f3f4f6;
        }
        .container {
            max-width: 600px;
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
        .btn-danger {
            background-color: #ef4444; /* red-500 */
            color: #ffffff;
        }
        .btn-danger:hover {
            background-color: #dc2626; /* red-600 */
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
            <h1 class="text-2xl md:text-3xl font-bold text-center text-red-700 mb-8">Cancel Reservation</h1>

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

            <form action="deleteReservation" method="post" class="space-y-6">
                <div>
                    <label for="reservationID" class="form-label">Reservation ID to Cancel:</label>
                    <input type="number" id="reservationID" name="reservationID" class="form-input" required>
                </div>
                <div class="flex flex-col sm:flex-row justify-between space-y-4 sm:space-y-0 sm:space-x-4">
                    <button type="submit" class="btn btn-danger w-full sm:w-auto">Confirm Cancellation</button>
                    <a href="index.jsp" class="btn btn-secondary w-full sm:w-auto">Back to Home</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
