console.log("JavaScript file loaded");

// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "custom/menu"

import $ from 'jquery';
import 'datatables.net';

$(document).on('turbolinks:load', function(){
    $('#shifts-table').DataTable({
      processing: true,
      serverSide: true,
      ajax: '/shift_preferences/datatable.json'
    });
});



$(document).on('turbolinks:load', function() {
  $('#show-possible').on('click', function() {
    // 全てのシフトプリファレンスを一旦非表示にします
    $('.shift-preference').hide();

    // 「可能」なシフトプリファレンスだけを表示します
    $('.shift-preference[data-preference-level="可能"]').show();
  });
});

