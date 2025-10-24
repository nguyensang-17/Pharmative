<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/common/header.jsp" />

<div class="bg-light py-3">
  <div class="container">
    <div class="row">
      <div class="col-md-12 mb-0">
        <a href="${pageContext.request.contextPath}/home">Home</a>
        <span class="mx-2 mb-0">/</span>
        <strong class="text-black">Register</strong>
      </div>
    </div>
  </div>
</div>

<div class="site-section">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-md-8">
        <form action="${pageContext.request.contextPath}/register" method="post">
          <div class="p-3 p-lg-5 border">
            <h2 class="h3 mb-3 text-black text-center">Register an Account</h2>

            <c:if test="${not empty error}">
              <div class="alert alert-danger" role="alert">${error}</div>
            </c:if>

            <div class="form-group row">
              <div class="col-md-12">
                <label for="fullname" class="text-black">Full Name <span class="text-danger">*</span></label>
                <input type="text" class="form-control" id="fullname" name="fullname" required>
              </div>
            </div>

            <div class="form-group row">
              <div class="col-md-12">
                <label for="email" class="text-black">Email <span class="text-danger">*</span></label>
                <input type="email" class="form-control" id="email" name="email" required>
              </div>
            </div>

            <div class="form-group row">
              <div class="col-md-12">
                <label for="phone" class="text-black">Phone Number</label>
                <input type="text" class="form-control" id="phone" name="phone">
              </div>
            </div>

            <div class="form-group row">
              <div class="col-md-6">
                <label for="password" class="text-black">Password <span class="text-danger">*</span></label>
                <input type="password" class="form-control" id="password" name="password" required>
              </div>
              <div class="col-md-6">
                <label for="confirm_password" class="text-black">Confirm Password <span class="text-danger">*</span></label>
                <input type="password" class="form-control" id="confirm_password" name="confirm_password" required>
              </div>
            </div>

            <div class="form-group row mt-4">
              <div class="col-lg-12">
                <input type="submit" class="btn btn-primary btn-lg btn-block" value="Register">
              </div>
            </div>

            <div class="text-center">
              Already have an account?
              <a href="${pageContext.request.contextPath}/login.jsp">Login here</a>
            </div>
          </div>
        </form>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/common/footer.jsp" />