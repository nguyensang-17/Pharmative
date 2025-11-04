package models;

import java.math.BigDecimal;

public class OrderDetail {

    private int orderDetailId;
    private int orderId;
    private int productId;
    private int quantity;
    private BigDecimal pricePerUnit;
    private Product product; // THÊM THUỘC TÍNH NÀY

    public int getOrderDetailId() {
        return orderDetailId;
    }

    public void setOrderDetailId(int orderDetailId) {
        this.orderDetailId = orderDetailId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getPricePerUnit() {
        return pricePerUnit;
    }

    public void setPricePerUnit(BigDecimal pricePerUnit) {
        this.pricePerUnit = pricePerUnit;
    }

    // THÊM GETTER/SETTER CHO PRODUCT
    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    // THÊM PHƯƠNG THỨC TÍNH SUBTOTAL (TUỲ CHỌN)
    public BigDecimal getSubtotal() {
        if (pricePerUnit != null) {
            return pricePerUnit.multiply(BigDecimal.valueOf(quantity));
        }
        return BigDecimal.ZERO;
    }
}