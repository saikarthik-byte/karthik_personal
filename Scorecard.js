looker.plugins.visualizations.add({
  id: "custom_kpi",
  label: "Custom KPI Card",
  options: {
    color: {
      section: "Style",
      label: "Card Color",
      type: "string",
      default: "#0072b1"
    },
    score_font_size: {
      section: "Style",
      label: "Score Font Size (px)",
      type: "number",
      default: 48,
      min: 10,
      max: 200
    },
    subtitle_font_size: {
      section: "Style",
      label: "Subtitle Font Size (px)",
      type: "number",
      default: 16,
      min: 8,
      max: 100
    }
  },
  create: function (element, config) {
    element.innerHTML = `
      <div id="kpi-card" style="
        display:flex;
        flex-direction:column;
        align-items:center;
        justify-content:center;
        height:100%;
        font-family:sans-serif;
      ">
        <h1 id="kpi-value" style="margin:0;"></h1>
        <p id="kpi-label" style="color:#666; margin:0;"></p>
      </div>
    `;
  },
  updateAsync: function (data, element, config, queryResponse, details, done) {
    const field = queryResponse.fields.measure_like[0];
    const value = data[0][field.name].value;

    const kpiValue = element.querySelector('#kpi-value');
    const kpiLabel = element.querySelector('#kpi-label');

    kpiValue.innerText = value;
    kpiLabel.innerText = field.label;

    kpiValue.style.color = config.color;
    kpiValue.style.fontSize = config.score_font_size + "px";
    kpiLabel.style.fontSize = config.subtitle_font_size + "px";

    done();
  }
});
