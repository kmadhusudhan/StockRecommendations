function changeRole() {
  $("#role_notice").text("");
  var role = $('#roles').val();
  $.ajax({
    type: "POST",
    url: "/roles/change_role?role=" + role,
    data: {},
    success: function(response, textStatus, jqXHR) {
      $("#role_notice").text("Role changed successfully.")
      console.log("current role", response);
    },
    error: function(jqXHR, textStatus, errorThrown) {
      console.log("data " + jqXHR);
    }
  });
}
