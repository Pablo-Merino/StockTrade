$(function() {

	var data = $('#history_graph').data('history').split(",");

	var margin = {top: 20, right: 80, bottom: 60, left: 90}
  , width = 650 - margin.left - margin.right
  , height = 250 - margin.top - margin.bottom;

	var x = d3.scale.linear().domain([1,13]).range([0, width]);
	var y = d3.scale.linear().domain([Math.min.apply( Math, data ), Math.max.apply( Math, data )]).range([height, 0]);

	var area = d3.svg.area().interpolate("monotone").x(function(d) { return x(d); }).y0(height).y1(function(d) { return y(d); });

	var line = d3.svg.line().interpolate("basis").x(function(d,i) {return x(i);}).y(function(d) {return y(d);});

		
	var graph = d3.select("#history_graph svg").append("svg:g").attr("transform", "translate(" + margin.left + "," + margin.top + ")");


	var xAxis = d3.svg.axis().scale(x).tickSize(-height).tickSubdivide(true);

	graph.append("svg:g").attr("class", "x axis").attr("transform", "translate(0," + height + ")").call(xAxis);

	var yAxisLeft = d3.svg.axis().scale(y).ticks(4).orient("left");

	graph.append("svg:g").attr("class", "y axis").attr("transform", "translate(-25,0)").call(yAxisLeft);

	graph.append("svg:path").attr("class", "line").attr('transform', 'translate(25,0)').attr("clip-path", "url(#clip)").attr("d", line(data));
});



