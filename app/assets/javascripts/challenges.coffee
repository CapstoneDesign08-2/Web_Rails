# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ cnt=1
$(document).ready(->
  $('.gradeTest').click(->Waitime());
);

$(document).on('turbolinks:load', ->
  ShowScores();
);

Showlog =->
  $.ajax(
    type : 'GET',
    url: '/applicants/logging/' + $('#current_id').val(),
    dataType: 'html',
    success: (json) ->(
      $('.result').html(json)
      if(json==""&&cnt<4)
        $('.result').html("don't touch button. retry - "+ cnt)
        $ cnt=cnt+1
        setTimeout(Showlog,25000)
      else if(cnt>=4)
        $('.result').html("Time Over. Please, Restart.")
    )
    error: (request, status, error) ->(
      alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
      $('.result').html("TEST error")
    )
  );

ShowScore =->
  $.ajax(
    type:'GET',
    url:'/applicants/score/'+ $('#current_id').val(),
    dataType:'html'
    success: (json)->(
      $('.resultPoint').html(json+'/100 point')
    )
  );

ShowScores =->
  $.ajax(
    type:'GET',
    url:'/applicants/score/'+ $('#current_id').val(),
    dataType:'html'
    success: (json)->(
      $('.scorePoint').html(json+'/100 point')
    )
  );


RunAjax = ->
  Showlog();
  ShowScore();
  cnt=1
  $('.gradeTest').click(->Waitime());

Waitime =->
  $('.result').html('Ready');
  $('.resultPoint').html('??/100 point');
  $('.gradeTest').unbind("click");
  $ dt = new Date()
  $ dt.setSeconds(dt.getSeconds()+60);
  $('.result').html("Prediction Time - "+dt.toTimeString())
  setTimeout(RunAjax, 60000);
