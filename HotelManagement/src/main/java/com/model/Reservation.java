// src/com/model/Reservation.java
package com.model;

import java.math.BigDecimal;
import java.sql.Date;

/**
 * Represents a Reservation entity in the Hotel Management System.
 * This is a simple POJO (Plain Old Java Object) to hold reservation data.
 */
public class Reservation {
    private int reservationID;
    private String customerName;
    private String roomNumber;
    private Date checkIn;
    private Date checkOut;
    private BigDecimal totalAmount;

    // Default constructor
    public Reservation() {
    }

    // Parameterized constructor
    public Reservation(int reservationID, String customerName, String roomNumber, Date checkIn, Date checkOut, BigDecimal totalAmount) {
        this.reservationID = reservationID;
        this.customerName = customerName;
        this.roomNumber = roomNumber;
        this.checkIn = checkIn;
        this.checkOut = checkOut;
        this.totalAmount = totalAmount;
    }

    // Getters and Setters for all properties

    public int getReservationID() {
        return reservationID;
    }

    public void setReservationID(int reservationID) {
        this.reservationID = reservationID;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public Date getCheckIn() {
        return checkIn;
    }

    public void setCheckIn(Date checkIn) {
        this.checkIn = checkIn;
    }

    public Date getCheckOut() {
        return checkOut;
    }

    public void setCheckOut(Date checkOut) {
        this.checkOut = checkOut;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    @Override
    public String toString() {
        return "Reservation{" +
               "reservationID=" + reservationID +
               ", customerName='" + customerName + '\'' +
               ", roomNumber='" + roomNumber + '\'' +
               ", checkIn=" + checkIn +
               ", checkOut=" + checkOut +
               ", totalAmount=" + totalAmount +
               '}';
    }
}
