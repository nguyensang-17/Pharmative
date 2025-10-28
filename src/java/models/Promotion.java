package models;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Promotion {

    private int promoId;
    private int productId;
    private String title;
    private Integer percentOff;
    private BigDecimal amountOff;
    private Timestamp startsAt;
    private Timestamp endsAt;

    public int getPromoId() {
        return promoId;
    }

    public void setPromoId(int promoId) {
        this.promoId = promoId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Integer getPercentOff() {
        return percentOff;
    }

    public void setPercentOff(Integer percentOff) {
        this.percentOff = percentOff;
    }

    public BigDecimal getAmountOff() {
        return amountOff;
    }

    public void setAmountOff(BigDecimal amountOff) {
        this.amountOff = amountOff;
    }

    public Timestamp getStartsAt() {
        return startsAt;
    }

    public void setStartsAt(Timestamp startsAt) {
        this.startsAt = startsAt;
    }

    public Timestamp getEndsAt() {
        return endsAt;
    }

    public void setEndsAt(Timestamp endsAt) {
        this.endsAt = endsAt;
    }
}
