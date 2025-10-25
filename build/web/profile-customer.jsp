<%@page contentType="text/html; charset=UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<h2>Hồ sơ khách hàng</h2>

<c:if test="${not empty msg}">
  <div class="alert alert-success">${msg}</div>
</c:if>

<c:set var="p" value="${profile}" />

<!-- Cập nhật hồ sơ: chỉ họ tên + SĐT -->
<form action="profile" method="post" class="box mb-4">
  <input type="hidden" name="action" value="update-profile"/>
  <div>
    <label>Họ tên</label>
    <input name="full_name" value="${p.full_name}" required/>
  </div>
  <div>
    <label>Email</label>
    <input value="${p.email}" disabled/>
  </div>
  <div>
    <label>Điện thoại</label>
    <input name="phone" value="${p.phone}"/>
  </div>
  <button type="submit">Lưu hồ sơ</button>
</form>

<h3>Địa chỉ nhận hàng</h3>

<!-- Thêm địa chỉ mới: tên tham số khớp DAO/Controller -->
<form action="profile" method="post" class="box mb-3">
  <input type="hidden" name="action" value="add-address"/>
  <div><label>Người nhận</label><input name="recipient_name" required/></div>
  <div><label>SĐT người nhận</label><input name="recipient_phone" required/></div>
  <div><label>Địa chỉ</label><input name="street_address" required/></div>
  <div><label>Phường/Xã</label><input name="ward"/></div>
  <div><label>Quận/Huyện</label><input name="district"/></div>
  <div><label>Tỉnh/Thành phố</label><input name="city" required/></div>
  <div><label>Mặc định</label><input type="checkbox" name="is_default"/></div>
  <button type="submit">Thêm địa chỉ</button>
</form>

<table class="table table-bordered">
  <thead>
    <tr>
      <th>Người nhận</th>
      <th>Địa chỉ</th>
      <th>SĐT</th>
      <th>Mặc định</th>
      <th>Thao tác</th>
    </tr>
  </thead>
  <tbody>
  <c:forEach var="a" items="${addresses}">
    <tr>
      <td>${a.recipientName}</td>
      <td>${a.streetAddress}, ${a.ward}, ${a.district}, ${a.city}</td>
      <td>${a.recipientPhone}</td>
      <td><c:if test="${a.default}">✔</c:if></td>
      <td>
        <c:if test="${!a.default}">
          <form action="profile" method="post" style="display:inline">
            <input type="hidden" name="action" value="set-default"/>
            <input type="hidden" name="address_id" value="${a.addressId}"/>
            <button type="submit">Mặc định</button>
          </form>
        </c:if>
        <form action="profile" method="post" style="display:inline" onsubmit="return confirm('Xóa địa chỉ?')">
          <input type="hidden" name="action" value="delete-address"/>
          <input type="hidden" name="address_id" value="${a.addressId}"/>
          <button type="submit">Xóa</button>
        </form>
      </td>
    </tr>
  </c:forEach>
  </tbody>
</table>

<!-- Nếu bạn đã tạo footer include dùng chung thì giữ dòng dưới; không có thì bỏ -->
