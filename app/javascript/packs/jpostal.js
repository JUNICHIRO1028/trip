function jpostal() {
  $('#post_image_postcode').jpostal({
    postcode : ['#post_image_postcode'],
    address : {
      '#post_image_address': '%3%4%5'
    }
  });
}
$(document).on("turbolinks:load", jpostal);