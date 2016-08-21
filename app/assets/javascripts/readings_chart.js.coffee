$ ->
  set_periodicity('weekly')

set_handlers = ->
  $('#periodicity a').on 'click', ->
    set_periodicity(this.id)

  $('#periods a').on 'click', ->
    set_period(this.text)

set_periodicity = (periodicity) ->
  window.periodicity = periodicity
  $.get('period_count', periodicity: periodicity, (period_count) ->
    $('#periods').empty()
    for i in [1 .. period_count]
      $('#periods').append "<a href='#' class='button'>#{i}</a>"
    set_handlers()
    set_period(period_count) # show last period by default
  )

set_period = (period) ->
  $.get('chart_data', periodicity: window.periodicity, index: period, (data) ->
    build_temperature_chart(data)
    build_humidity_chart(data)
  )

build_temperature_chart = (data) ->
  ctx = document.getElementById("temperatureChart").getContext("2d")
  new Chart(ctx,
    type: 'line'
    data:
      labels: data.timestamps
      datasets: [ {
        label: 'Temperature'
        data: data.temperatures
        fill: false
        borderColor: "pink"
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
            suggestedMax: 35
            stepSize: 5
        ]
      legend:
        display: true
  )

build_humidity_chart = (data) ->
  ctx = document.getElementById("humidityChart").getContext("2d")
  new Chart(ctx,
    type: 'line'
    data:
      labels: data.timestamps
      datasets: [ {
        label: 'Humidity'
        data: data.humidities
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
            suggestedMin: 40
            suggestedMax: 90
            stepSize: 10
        ]
      legend:
        display: true
  )
