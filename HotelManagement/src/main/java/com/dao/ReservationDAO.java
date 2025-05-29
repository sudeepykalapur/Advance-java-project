// src/com/dao/ReservationDAO.java
package com.dao;

import com.model.Reservation;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object (DAO) for the Reservation entity.
 * This class provides CRUD (Create, Read, Update, Delete) operations
 * and reporting functionalities for reservations in the database.
 */
public class ReservationDAO {

    // JDBC database connection details
    private static final String JDBC_URL = "jdbc:mysql://localhost:3307/structure"; // Replace with your DB URL
    private static final String JDBC_USERNAME = "root"; // Replace with your DB username
    private static final String JDBC_PASSWORD = ""; // Replace with your DB password

    // SQL queries
    private static final String INSERT_RESERVATION_SQL = "INSERT INTO Reservations (CustomerName, RoomNumber, CheckIn, CheckOut, TotalAmount) VALUES (?, ?, ?, ?, ?)";
    private static final String SELECT_RESERVATION_BY_ID_SQL = "SELECT ReservationID, CustomerName, RoomNumber, CheckIn, CheckOut, TotalAmount FROM Reservations WHERE ReservationID = ?";
    private static final String SELECT_ALL_RESERVATIONS_SQL = "SELECT ReservationID, CustomerName, RoomNumber, CheckIn, CheckOut, TotalAmount FROM Reservations";
    private static final String UPDATE_RESERVATION_SQL = "UPDATE Reservations SET CustomerName = ?, RoomNumber = ?, CheckIn = ?, CheckOut = ?, TotalAmount = ? WHERE ReservationID = ?";
    private static final String DELETE_RESERVATION_SQL = "DELETE FROM Reservations WHERE ReservationID = ?";
    private static final String SELECT_RESERVATIONS_IN_DATE_RANGE_SQL = "SELECT ReservationID, CustomerName, RoomNumber, CheckIn, CheckOut, TotalAmount FROM Reservations WHERE CheckIn <= ? AND CheckOut >= ?";
    private static final String SELECT_ROOMS_BOOKED_MOST_FREQUENTLY_SQL = "SELECT RoomNumber, COUNT(*) AS BookingCount FROM Reservations GROUP BY RoomNumber ORDER BY BookingCount DESC LIMIT 5";
    private static final String SELECT_TOTAL_REVENUE_OVER_PERIOD_SQL = "SELECT SUM(TotalAmount) AS TotalRevenue FROM Reservations WHERE CheckIn >= ? AND CheckOut <= ?";
    private static final String SELECT_RESERVATIONS_BY_CUSTOMER_SQL = "SELECT ReservationID, CustomerName, RoomNumber, CheckIn, CheckOut, TotalAmount FROM Reservations WHERE CustomerName LIKE ?";


    /**
     * Establishes a database connection.
     *
     * @return A Connection object.
     * @throws SQLException if a database access error occurs.
     */
    protected Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL JDBC Driver
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found. Make sure it's in your classpath.");
            throw new SQLException("JDBC Driver not found", e);
        }
        return DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
    }

    /**
     * Adds a new reservation to the database.
     *
     * @param reservation The Reservation object to add.
     * @return true if the reservation was added successfully, false otherwise.
     */
    public boolean addReservation(Reservation reservation) {
        boolean rowAffected = false;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_RESERVATION_SQL, Statement.RETURN_GENERATED_KEYS)) {

            preparedStatement.setString(1, reservation.getCustomerName());
            preparedStatement.setString(2, reservation.getRoomNumber());
            preparedStatement.setDate(3, reservation.getCheckIn());
            preparedStatement.setDate(4, reservation.getCheckOut());
            preparedStatement.setBigDecimal(5, reservation.getTotalAmount());

            rowAffected = preparedStatement.executeUpdate() > 0;

            // Retrieve the generated ReservationID
            if (rowAffected) {
                ResultSet rs = preparedStatement.getGeneratedKeys();
                if (rs.next()) {
                    reservation.setReservationID(rs.getInt(1));
                }
            }

        } catch (SQLException e) {
            printSQLException(e);
        }
        return rowAffected;
    }

    /**
     * Retrieves a reservation by its ID from the database.
     *
     * @param reservationID The ID of the reservation to retrieve.
     * @return The Reservation object if found, null otherwise.
     */
    public Reservation getReservationById(int reservationID) {
        Reservation reservation = null;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_RESERVATION_BY_ID_SQL)) {

            preparedStatement.setInt(1, reservationID);
            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                String customerName = rs.getString("CustomerName");
                String roomNumber = rs.getString("RoomNumber");
                Date checkIn = rs.getDate("CheckIn");
                Date checkOut = rs.getDate("CheckOut");
                BigDecimal totalAmount = rs.getBigDecimal("TotalAmount");
                reservation = new Reservation(reservationID, customerName, roomNumber, checkIn, checkOut, totalAmount);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return reservation;
    }

    /**
     * Retrieves all reservations from the database.
     *
     * @return A list of all Reservation objects.
     */
    public List<Reservation> getAllReservations() {
        List<Reservation> reservations = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_RESERVATIONS_SQL)) {

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                int reservationID = rs.getInt("ReservationID");
                String customerName = rs.getString("CustomerName");
                String roomNumber = rs.getString("RoomNumber");
                Date checkIn = rs.getDate("CheckIn");
                Date checkOut = rs.getDate("CheckOut");
                BigDecimal totalAmount = rs.getBigDecimal("TotalAmount");
                reservations.add(new Reservation(reservationID, customerName, roomNumber, checkIn, checkOut, totalAmount));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return reservations;
    }

    /**
     * Updates an existing reservation in the database.
     *
     * @param reservation The Reservation object with updated details.
     * @return true if the reservation was updated successfully, false otherwise.
     */
    public boolean updateReservation(Reservation reservation) {
        boolean rowAffected = false;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_RESERVATION_SQL)) {

            preparedStatement.setString(1, reservation.getCustomerName());
            preparedStatement.setString(2, reservation.getRoomNumber());
            preparedStatement.setDate(3, reservation.getCheckIn());
            preparedStatement.setDate(4, reservation.getCheckOut());
            preparedStatement.setBigDecimal(5, reservation.getTotalAmount());
            preparedStatement.setInt(6, reservation.getReservationID());

            rowAffected = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            printSQLException(e);
        }
        return rowAffected;
    }

    /**
     * Deletes a reservation from the database by its ID.
     *
     * @param reservationID The ID of the reservation to delete.
     * @return true if the reservation was deleted successfully, false otherwise.
     */
    public boolean deleteReservation(int reservationID) {
        boolean rowAffected = false;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_RESERVATION_SQL)) {

            preparedStatement.setInt(1, reservationID);
            rowAffected = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            printSQLException(e);
        }
        return rowAffected;
    }

    /**
     * Retrieves reservations within a specified date range.
     *
     * @param startDate The start date of the range.
     * @param endDate   The end date of the range.
     * @return A list of Reservation objects within the specified range.
     */
    public List<Reservation> getReservationsInDateRange(Date startDate, Date endDate) {
        List<Reservation> reservations = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_RESERVATIONS_IN_DATE_RANGE_SQL)) {

            preparedStatement.setDate(1, endDate); // CheckIn <= endDate
            preparedStatement.setDate(2, startDate); // CheckOut >= startDate (overlap logic)
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                int reservationID = rs.getInt("ReservationID");
                String customerName = rs.getString("CustomerName");
                String roomNumber = rs.getString("RoomNumber");
                Date checkIn = rs.getDate("CheckIn");
                Date checkOut = rs.getDate("CheckOut");
                BigDecimal totalAmount = rs.getBigDecimal("TotalAmount");
                reservations.add(new Reservation(reservationID, customerName, roomNumber, checkIn, checkOut, totalAmount));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return reservations;
    }

    /**
     * Retrieves the top rooms booked most frequently.
     *
     * @return A list of String arrays, where each array contains [RoomNumber, BookingCount].
     */
    public List<String[]> getRoomsBookedMostFrequently() {
        List<String[]> frequentRooms = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ROOMS_BOOKED_MOST_FREQUENTLY_SQL)) {

            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                String roomNumber = rs.getString("RoomNumber");
                int bookingCount = rs.getInt("BookingCount");
                frequentRooms.add(new String[]{roomNumber, String.valueOf(bookingCount)});
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return frequentRooms;
    }

    /**
     * Calculates the total revenue generated over a specified period.
     *
     * @param startDate The start date of the period.
     * @param endDate   The end date of the period.
     * @return The total revenue as a BigDecimal, or BigDecimal.ZERO if no revenue.
     */
    public BigDecimal getTotalRevenueOverPeriod(Date startDate, Date endDate) {
        BigDecimal totalRevenue = BigDecimal.ZERO;
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_TOTAL_REVENUE_OVER_PERIOD_SQL)) {

            preparedStatement.setDate(1, startDate);
            preparedStatement.setDate(2, endDate);
            ResultSet rs = preparedStatement.executeQuery();

            if (rs.next()) {
                totalRevenue = rs.getBigDecimal("TotalRevenue");
                if (totalRevenue == null) { // Handle case where SUM returns null (no records)
                    totalRevenue = BigDecimal.ZERO;
                }
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return totalRevenue;
    }

    /**
     * Retrieves reservations by customer name (partial match).
     *
     * @param customerName The customer name or partial name to search for.
     * @return A list of Reservation objects matching the customer name.
     */
    public List<Reservation> getReservationsByCustomer(String customerName) {
        List<Reservation> reservations = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_RESERVATIONS_BY_CUSTOMER_SQL)) {

            preparedStatement.setString(1, "%" + customerName + "%"); // Use LIKE for partial matching
            ResultSet rs = preparedStatement.executeQuery();

            while (rs.next()) {
                int reservationID = rs.getInt("ReservationID");
                String foundCustomerName = rs.getString("CustomerName");
                String roomNumber = rs.getString("RoomNumber");
                Date checkIn = rs.getDate("CheckIn");
                Date checkOut = rs.getDate("CheckOut");
                BigDecimal totalAmount = rs.getBigDecimal("TotalAmount");
                reservations.add(new Reservation(reservationID, foundCustomerName, roomNumber, checkIn, checkOut, totalAmount));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return reservations;
    }


    /**
     * Prints SQL exception information to the console.
     *
     * @param ex The SQLException object.
     */
    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                e.printStackTrace(System.err);
                System.err.println("SQL State: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.out.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
}
