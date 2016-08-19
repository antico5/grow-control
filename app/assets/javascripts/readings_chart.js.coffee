$ ->
  console.log 'asd'
  ctx = document.getElementById("myChart").getContext("2d")
  myChart = new Chart(ctx,
    type: 'line'
    data:
      labels: $('#chart_data').data('labels')
      datasets: [ {
        label: 'Temperature'
        data: $('#chart_data').data('values')
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
            min: 10
            max: 50
        ]
  )
