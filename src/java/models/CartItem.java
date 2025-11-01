package models;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class CartItem {

    private long cartItemId;
    private long cartId;
    private int productId;
    private int quantity;
    private Timestamp addedAt;
    private Product product; // 🔗 Liên kết tới sản phẩm (nếu có)

    // === Constructors ===
    public CartItem() {}

    public CartItem(Product product, int quantity) {
        this.product = product;
        this.productId = (product != null) ? product.getProductId() : 0;
        this.quantity = quantity;
    }

    // === Getters & Setters ===
    public long getCartItemId() {
        return cartItemId;
    }

    public void setCartItemId(long cartItemId) {
        this.cartItemId = cartItemId;
    }

    public long getCartId() {
        return cartId;
    }

    public void setCartId(long cartId) {
        this.cartId = cartId;
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

    public Timestamp getAddedAt() {
        return addedAt;
    }

    public void setAddedAt(Timestamp addedAt) {
        this.addedAt = addedAt;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    // === Tính tổng tiền ===
    public BigDecimal getTotalPrice() {
        if (product == null || product.getPrice() == null) {
            return BigDecimal.ZERO;
        }
        return product.getPrice().multiply(BigDecimal.valueOf(quantity));
    }

    // === Hỗ trợ hiển thị tiện lợi ===
    @Override
    public String toString() {
        return "CartItem{" +
                "cartItemId=" + cartItemId +
                ", productId=" + productId +
                ", quantity=" + quantity +
                ", total=" + getTotalPrice() +
                '}';
    }
}
