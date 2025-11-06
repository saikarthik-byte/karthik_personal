looker.plugins.visualizations.add({
  id: "aster_plot",
  label: "Aster Plot",
  options: {
    score_font_size: {
      section: "Style",
      label: "Score Font Size (px)",
      type: "number",
      default: 40,
      min: 10,
      max: 100
    },
    subtitle_font_size: {
      section: "Style",
      label: "Subtitle Font Size (px)",
      type: "number",
      default: 10,
      min: 8,
      max: 50
    }
  },
  create: function(element, config) {
    this.container = document.createElement("div");
    element.appendChild(this.container);
  },
  updateAsync: function(data, element, config, queryResponse, details, done) {
    // Clear previous content
    this.container.innerHTML = "";

    // Assume you've built your SVG here
    const svg = d3.select(this.container).append("svg")
      .attr("width", "100%")
      .attr("height", "100%");
      
    // Add your aster plot drawing code here...
    // For example, after you've calculated the score and subtitle:
    const scoreText = svg.append("text")
      .text(/* your score value */)
      .attr("x", "50%")
      .attr("y", "50%")
      .attr("text-anchor", "middle")
      .style("font-size", config.score_font_size + "px");
      
    const subtitleText = svg.append("text")
      .text(/* your subtitle label */)
      .attr("x", "50%")
      .attr("y", "60%")
      .attr("text-anchor", "middle")
      .style("font-size", config.subtitle_font_size + "px");
      
    done();
  }
});
