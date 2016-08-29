var limitAreaPlugin = {
  afterDraw: function(chartInstance) {
    var yScale = chartInstance.scales["y-axis-0"];
    var xScale = chartInstance.scales["x-axis-0"];
    var canvas = chartInstance.chart;
    var ctx = canvas.ctx;

    var areas = chartInstance.options.levelAreas;
    if (areas) {
      for(var i=0; i < areas.length; i++){
        var area = areas[i];

        ctx.fillStyle = area.style || "rgba(169,169,169, .6)";

        var from = Math.max(area.from, yScale.min);
        var to = Math.min(area.to, yScale.max);

        var startX = xScale.margins.left
        var startY = yScale.getPixelForValue(from);
        var endY = yScale.getPixelForValue(to);

        var width = canvas.width - startX;
        var height = endY - startY;

        ctx.fillRect(startX, startY, width, height);

        if (area.text) {
          ctx.fillText(area.text, startX + 3, endY + 3);
        }
      }
    };
  }
};
Chart.pluginService.register(limitAreaPlugin);
