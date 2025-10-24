package models;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class ProductPrice {

    private int productId;
    private BigDecimal price;
    private BigDecimal compareAt; // nullable
    private Timestamp updatedAt;

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public BigDecimal getCompareAt() {
        return compareAt;
    }

    public void setCompareAt(BigDecimal compareAt) {
        this.compareAt = compareAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
}
