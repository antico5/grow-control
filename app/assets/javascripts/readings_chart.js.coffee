$ ->
  #periodicity buttons handler
  $('#periodicity a').on 'click', ->
    set_periodicity(this.id)
  #set default periodicity as daily
  set_periodicity('daily')

set_periodicity = (periodicity) ->
  window.periodicity = periodicity
  $.get('period_count', periodicity: periodicity, (period_count) ->
    create_period_buttons(period_count)
    set_period(period_count) # show last period by default
  )

create_period_buttons = (period_count) ->
  $('#periods').empty()
  for i in [1 .. period_count]
    $('#periods').append "<a href='#' class='button'>#{i}</a>"
  $('#periods a').on 'click', ->
    set_period(this.text)

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
        borderColor: "#aac"
      } ]
    options:
      maintainAspectRatio: false
      levelAreas: [{
        from: 0
        to: 18
        style: "rgba(210, 150, 150, 0.6)"
        text: "Cold"
      },{
        from: 30
        to: 50
        style: "rgba(210, 150, 150, 0.6)"
        text: "Hot"
      }]
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
        borderColor: "#aca"
      } ]
    options:
      maintainAspectRatio: false
      levelAreas: [{
        from: 0
        to: 35
        style: "rgba(210, 150, 150, 0.6)"
        text: "Dry"
      },{
        from: 80
        to: 100
        style: "rgba(210, 150, 150, 0.6)"
        text: "Wet"
      }]
      scales:
        xAxes: [
          display: false
        ]
        yAxes: [
          ticks:
            suggestedMin: 30
            suggestedMax: 90
            stepSize: 10
        ]
      legend:
        display: true
  )


