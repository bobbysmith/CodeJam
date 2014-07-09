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
//= require turbolinks
//= require soundcloud-player
//= require_tree .

$(function(){ $(document).foundation(); });


$(document).ready(function(){
  $(".like").on("click", function (e){
    var $container = $(this).parent().parent();
    var $total = $container.find('.total');
    e.preventDefault();
    var url = e.target.href;
    // if(current_user)
      $.post(url, {}, function(data, status) {
        $total.html(data.votes + " likes");
        // code to change menu number
      });
    return false;
  });
  $(".dislike").on("click", function (e){
    var $container = $(this).parent().parent();
    var $total = $container.find('.total');
    e.preventDefault();
    var url = e.target.href;
      $.post(url, {}, function(data, status) {
        // debugger;
        $total.html(data.votes + " likes");
        // code to change menu number
      });
    return false;
  });

});

