//i can do it on assinging id and data attributes also
function doFollow(stock_id) {
  $.ajax({
    type: "POST",
    url: "/stocks/follow?id=" + stock_id,
    data: {},
    success: function(response, textStatus, jqXHR) {
      var recordId = response.stock.id;
      var followers_count = response.follow_count;
      $("#stock_" + recordId)
        .find(".follow_count")
        .text(followers_count);
      $("#stock_" + recordId)
        .find(".follow")
        .find('button')
        .attr("disabled", "disabled");
    },
    error: function(jqXHR, textStatus, errorThrown) {
      console.log("data " + jqXHR);
    }
  });
}
