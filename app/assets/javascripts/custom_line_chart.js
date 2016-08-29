var horizonalLinePlugin = {
  afterDraw: function(chartInstance) {
    var yScale = chartInstance.scales["y-axis-0"];
    var xScale = chartInstance.scales["x-axis-0"];
    var canvas = chartInstance.chart;
    var ctx = canvas.ctx;
    var index;
    var line;
    var style;

    if (chartInstance.options.horizontalLine) {
      for (index = 0; index < chartInstance.options.horizontalLine.length; index++) {
        line = chartInstance.options.horizontalLine[index];

        if (!line.style) {
          style = "rgba(169,169,169, .6)";
        } else {
          style = line.style;
        }

        if (line.y) {
          yValue = yScale.getPixelForValue(line.y);
        } else {
          yValue = 0;
        }

        ctx.lineWidth = 2;
        var startX = xScale.margins.left

        if (yValue) {
          var width = canvas.width - startX;
          var height = yValue;
          ctx.fillStyle = style;
          ctx.fillRect(startX,yValue, width, height);

          //ctx.beginPath();
          //ctx.moveTo(startX, yValue);
          //ctx.lineTo(canvas.width, yValue);
          //ctx.strokeStyle = style;
          //ctx.stroke();
        }

        if (line.text) {
          ctx.fillStyle = style;
          ctx.fillText(line.text, startX, yValue + ctx.lineWidth);
        }
      }
      return;
    };
  }
};
Chart.pluginService.register(horizonalLinePlugin);
