<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/common/header.jsp" />

<div class="site-section">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-md-6">
        <form action="${pageContext.request.contextPath}/reset-password" method="post">
          <div class="p-3 p-lg-5 border">
            <h2 class="h3 mb-3 text-black">Create New Password</h2>
            <c:if test="${not empty error}">
              <div class="alert alert-danger">${error}</div>
            </c:if>

            <input type="hidden" name="token" value="${param.token}">

            <div class="form-group row">
              <div class="col-md-12">
                <label for="password">New Password</label>
                <input type="password" class="form-control" name="password" required>
              </div>
            </div>

            <div class="form-group row">
              <div class="col-md-12">
                <label for="confirm_password">Confirm New Password</label>
                <input type="password" class="form-control" name="confirm_password" required>
              </div>
            </div>

            <div class="form-group row mt-4">
              <div class="col-lg-12">
                <input type="submit" class="btn btn-primary btn-lg btn-block" value="Reset Password">
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/common/footer.jsp" />