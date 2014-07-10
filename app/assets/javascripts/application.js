// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
// require turbolinks
//= require soundcloud-player
//= require_tree .

$(function(){ $(document).foundation(); });

var tracks = [];

$(document).ready(function(){
  $(".track").each(function(index, elem) {
    var $elem = $(elem);
    var track = {
      id: $elem.data('track-id'),
      $el: $elem,
      $vote: $elem.find('.vote'),
      $total: $elem.find('.total')
    };
    track.$vote.on("click", function (e){
      e.preventDefault();
      var url = $(this).attr('href');
      $.ajax({
        url: url,
        data: {
          type: $(this).data('type')
        },
        method: 'POST',
        dataType: 'json',
        success: function(data, status) {
          track.$total.html(data.votes);
        }
      });
    });
    tracks.push(track);
  });
});

