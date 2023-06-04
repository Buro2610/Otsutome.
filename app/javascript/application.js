console.log("JavaScript file loaded");

// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "custom/menu"

import $ from 'jquery';
import 'datatables.net';
import 'jquery-ui';


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


//並び替え関係



$(document).on('turbolinks:load', function() {
  // DataTableの初期化
  $('#shifts-table').DataTable({
    processing: true,
    serverSide: true,
    ajax: '/shift_preferences/datatable.json'
  });

  // クリックイベントの設定
  $('#show-possible').on('click', function() {
    $('.shift-preference').hide();
    $('.shift-preference[data-preference-level="可能"]').show();
  });

  // sortableの設定
  ["#sortable-tasks", "#sortable-preferencelevels", "#sortable-timeslots"].forEach(function(sortableId) {
    $(sortableId).sortable({
      update: function(e, ui) {
        $.ajax({
          url: $(ui.item[0]).data('url'),
          type: 'PATCH',
          data: { order: ui.item.index() },
          headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') }
        });
      }
    });
  });
});