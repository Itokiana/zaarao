import consumer from "./consumer"

consumer.subscriptions.create("RatingChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    $(`#ratings-${data.wyr}-${data.wyr_id}`).children(`[for="rating_positive"]`).children('span.numbers').html(`
      (${data.positive_ratings_length})
    `);
    $(`#ratings-${data.wyr}-${data.wyr_id}`).children(`[for="rating_negative"]`).children('span.numbers').html(`
      (${data.negative_ratings_length})
    `);
    
    rate();
  }
});
