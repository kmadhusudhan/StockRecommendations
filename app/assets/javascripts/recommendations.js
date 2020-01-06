//i can do it on assinging id and data attributes also
function doVote(recommendation_id) {
  $.ajax({
    type: "POST",
    url: "/recommendations/vote?id=" + recommendation_id,
    data: {},
    success: function(response, textStatus, jqXHR) {
      var recordId = response.recommendation.id;
      var noOfVotes = response.votes;
      console.log("noOfVotes", noOfVotes);
      $("#rec_" + recordId)
        .find(".vote")
        .text(noOfVotes);
    },
    error: function(jqXHR, textStatus, errorThrown) {
      console.log("data " + jqXHR);
    }
  });
}
