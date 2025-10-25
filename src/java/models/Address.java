package models;

public class Address {

    private int addressId;
    private int userId;
    private String recipientName;
    private String recipientPhone;
    private String streetAddress;
    private String ward;
    private String district;
    private String city;
    private boolean isDefault;

    public int getAddressId() {
        return addressId;
    }

    public int getUserId() {
        return userId;
    }

    public String getRecipientName() {
        return recipientName;
    }

    public String getRecipientPhone() {
        return recipientPhone;
    }

    public String getStreetAddress() {
        return streetAddress;
    }

    public String getWard() {
        return ward;
    }

    public String getDistrict() {
        return district;
    }

    public String getCity() {
        return city;
    }

    public boolean getIsDefault() {
        return isDefault;
    }

    public void setAddressId(int addressId) {
        this.addressId = addressId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setRecipientName(String recipientName) {
        this.recipientName = recipientName;
    }

    public void setRecipientPhone(String recipientPhone) {
        this.recipientPhone = recipientPhone;
    }

    public void setStreetAddress(String streetAddress) {
        this.streetAddress = streetAddress;
    }

    public void setWard(String ward) {
        this.ward = ward;
    }

    public void setDistrict(String district) {
        this.district = district;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public void setIsDefault(boolean isDefault) {
        this.isDefault = isDefault;
    }

    
}
