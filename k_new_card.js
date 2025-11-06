looker.plugins.visualizations.add({
  id: "error_percent_kpi_card",
  label: "Error % KPI Card",
  options: {
    card_color: {
      section: "Style",
      label: "Card Background",
      type: "string",
      default: "#FF6F56" // Your sample's red-orange
    },
    score_font_size: {
      section: "Style",
      label: "Score Font Size (px)",
      type: "number",
      default: 36
    },
    subtitle_font_size: {
      section: "Style",
      label: "Subtitle Font Size (px)",
      type: "number",
      default: 18
    },
    percent_font_size: {
      section: "Style",
      label: "Change Font Size (px)",
      type: "number",
      default: 18
    }
  },
  create: function(element, config) {
    element.innerHTML = `
      <div id="error-kpi-card" style="
        display: flex; flex-direction: column; align-items: center; justify-content: center;
        height: 100%; width: 100vw; background: ${config.card_color}; font-family: sans-serif;
      ">
        <div id="kpi-title" style="font-size:${config.subtitle_font_size}px; font-weight:bold;text-align:center;">
          Error %
        </div>
        <div id="kpi-value" style="font-size:${config.score_font_size}px; font-weight:bold;text-align:center;">
          &nbsp;
        </div>
        <div id="kpi-py"
          style="font-size:${config.percent_font_size}px;text-align:center;margin-top:6px;">
          &nbsp;
        </div>
      </div>
    `;
  },
  updateAsync: function(data, element, config, queryResponse, details, done) {
    // Clear errors
    this.clearErrors();

    // Replace with your actual field names
    // e.g., data[0]["error_percent_cy"].value
    const fields = queryResponse.fields.measure_like;
    if (fields.length < 3) {
      this.addError({title: "Missing Data", message: "At least 3 measures required: CY, Arrow, YoY%."});
      done();
      return;
    }
    const kpiValue = data[0][fields[0].name].rendered || data[0][fields[0].name].value; // Error % CY
    const kpiArrow = data[0][fields[1].name].rendered || data[0][fields[1].name].value; // Arrow UP/DOWN
    const kpiChange = data[0][fields[2].name].rendered || data[0][fields[2].name].value; // CY vs PY %

    const kpiValueDiv = element.querySelector("#kpi-value");
    const kpiPYDiv = element.querySelector("#kpi-py");
    const kpiTitle = element.querySelector("#kpi-title");

    kpiValueDiv.innerText = kpiValue;
    kpiPYDiv.innerHTML = `vs PY: ${kpiArrow} ${kpiChange}`;

    // Apply styles
    kpiValueDiv.style.fontSize = config.score_font_size + "px";
    kpiTitle.style.fontSize = config.subtitle_font_size + "px";
    kpiPYDiv.style.fontSize = config.percent_font_size + "px";
    element.querySelector("#error-kpi-card").style.background = config.card_color;

    done();
  }
});
