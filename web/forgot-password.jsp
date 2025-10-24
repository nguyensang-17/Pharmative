<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/common/header.jsp" />

<div class="site-section">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-md-6">
        <form action="${pageContext.request.contextPath}/forgot-password" method="post">
          <div class="p-3 p-lg-5 border text-center">
            <h2 class="h3 mb-3 text-black">Reset Password</h2>
            <p>Enter your email address and we will send you a link to reset your password.</p>
            <c:if test="${not empty message}">
              <div class="alert alert-success">${message}</div>
            </c:if>
            <div class="form-group row justify-content-center">
              <div class="col-md-10">
                <label for="email" class="text-black">Email Address</label>
                <input type="email" class="form-control" id="email" name="email" required>
              </div>
            </div>
            <div class="form-group row justify-content-center mt-4">
              <div class="col-md-10">
                <input type="submit" class="btn btn-primary btn-lg btn-block" value="Send Reset Link">
              </div>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/common/footer.jsp" />