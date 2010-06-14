jQuery(function($){
  
  $("#view_grid").click(function(){
    $this = $(this);
    if($this.text().match(/view/)) {
      $.fn.fontGrid(18, "rgba(255, 255, 255, 0.35)");
      $(this).text("Ah, that's nice! Click again to turn it off.")
    } else {
      $("#grid").remove();
      $this.text("Click here to view the baseline grid for this page.")
    }
    return false;
  })
  
  $.fn.fontGrid = function(leading, color) {
    $("body").append('<div id="grid">');
    var $grid = $("#grid");
    for(var i = 1; i < $(document).height() / leading; i++) {
      $grid.append('<div class="baseline_grid_row">')
    }
    $grid.css({
      position: "absolute",
      top: 0,
      zIndex: -1
    })
    .find(".baseline_grid_row")
      .css({
        height: leading - 1,
        borderBottom: "1px solid "+color,
      })
  }
  
});