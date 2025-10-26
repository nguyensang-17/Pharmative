package models;

import java.sql.Timestamp;

public class UserStatistics {
    private int totalOrders;
    private double totalSpent;
    private Timestamp lastOrderDate;
    
    // Constructors
    public UserStatistics() {}
    
    public UserStatistics(int totalOrders, double totalSpent, Timestamp lastOrderDate) {
        this.totalOrders = totalOrders;
        this.totalSpent = totalSpent;
        this.lastOrderDate = lastOrderDate;
    }
    
    // Getters and Setters
    public int getTotalOrders() {
        return totalOrders;
    }
    
    public void setTotalOrders(int totalOrders) {
        this.totalOrders = totalOrders;
    }
    
    public double getTotalSpent() {
        return totalSpent;
    }
    
    public void setTotalSpent(double totalSpent) {
        this.totalSpent = totalSpent;
    }
    
    public Timestamp getLastOrderDate() {
        return lastOrderDate;
    }
    
    public void setLastOrderDate(Timestamp lastOrderDate) {
        this.lastOrderDate = lastOrderDate;
    }
}