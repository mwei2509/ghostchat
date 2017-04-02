// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require cable

$(()=>{

  //create new group form
  $(document).on('submit','#new_group', function(e){
    e.preventDefault()
    let groupData=$(this).serialize()
    let url = '/'
    $.post(url,groupData)
      .then((data)=>{
        $('.group-new-right-top').html(data)
      })
      .catch((error)=>{
        $('.group-new-right-top').append(`<h1 style="color: #fff;">${error["responseText"]}</h1>`)
        $('#create-group').prop("disabled",false)
      })
  })

  //create new user form
  $(document).on('submit','#new_user', function(e){
    e.preventDefault()
    let slug=$(this).data("slug")
    let userData=$(this).serialize()
    let url="/" + slug + "/users"
    $.post(url,userData)
      .then((data)=>{
        $('.group-new-right-top').html('<h1>DAMN GURL</h1>')
      })
      .catch((error)=>{
        $('.group-new-right-top').append('<h1>fucked up</h1>')
        $('#create-user').prop("disabled",false)
      })
  })
})
