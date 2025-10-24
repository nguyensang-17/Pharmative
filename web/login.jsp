<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/common/header.jsp" />

<div class="site-section">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-md-6">
        <h2 class="h3 mb-3 text-black">Login</h2>
        <form action="${pageContext.request.contextPath}/login" method="post">
          <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
          </c:if>
          <c:if test="${param.success eq 'verified'}">
            <div class="alert alert-success">Xác thực thành công. Vui lòng đăng nhập.</div>
          </c:if>
          <c:if test="${param.success eq 'reset'}">
            <div class="alert alert-success">Đặt lại mật khẩu thành công. Vui lòng đăng nhập.</div>
          </c:if>

          <div class="p-3 p-lg-5 border">
            <div class="form-group row">
              <div class="col-md-12">
                <label for="email" class="text-black">Email <span class="text-danger">*</span></label>
                <input type="email" class="form-control" id="email" name="email" required>
              </div>
            </div>

            <div class="form-group row">
              <div class="col-md-12">
                <label for="password" class="text-black">Password <span class="text-danger">*</span></label>
                <input type="password" class="form-control" id="password" name="password" required>
              </div>
            </div>

            <div class="form-group row">
              <div class="col-lg-12">
                <input type="submit" class="btn btn-primary btn-lg btn-block" value="Log In">
              </div>
            </div>

            <div class="text-center">
              <p>Don't have an account?
                <a href="${pageContext.request.contextPath}/register.jsp">Register here</a></p>
              <a href="${pageContext.request.contextPath}/forgot-password.jsp">Forgot Password?</a>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/common/footer.jsp" />