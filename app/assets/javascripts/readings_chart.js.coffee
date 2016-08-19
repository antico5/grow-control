$ ->
  set_handlers()

set_handlers = ->
  $('#periodicity a').on 'click', ->
    window.periodicity = this.id
    $.get('period_count', periodicity: window.periodicity, (period_count) ->
      $('#periods').empty()
      for i in [1 .. period_count]
        $('#periods').append "<a href='#' class='button'>#{i}</a>"
      set_handlers()
    )

  $('#periods a').on 'click', ->
    $.get('chart_data', periodicity: window.periodicity, index: this.text, (data) ->
      build_chart(data)
    )



build_chart = (data) ->
  ctx = document.getElementById("myChart").getContext("2d")
  myChart = new Chart(ctx,
    type: 'line'
    data:
      labels: data.timestamps
      datasets: [ {
        label: 'Temperature'
        data: data.temperatures
        fill: false
        borderColor: "lightblue"
      } ]
    options:
      maintainAspectRatio: false
      scales:
        xAxes: [
          display: false
        ]
        yAxes: [
          ticks:
            suggestedMin: 15
            suggestedMax: 40
        ]
      legend:
        display: false
  )
