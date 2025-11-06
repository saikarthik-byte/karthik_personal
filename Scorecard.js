looker.plugins.visualizations.add({
  id: "custom_kpi",
  label: "Custom KPI Card",
  options: {
    color: {
      section: "Style",
      label: "Card Color",
      type: "string",
      default: "#0072b1"
    }
  },
  create: function (element, config) {
    // Called once when the visualization is first loaded
    element.innerHTML = `
      <div id="kpi-card" style="
        display:flex;
        flex-direction:column;
        align-items:center;
        justify-content:center;
        height:100%;
        font-family:sans-serif;
      ">
        <h1 id="kpi-value" style="font-size:48px; margin:0;"></h1>
        <p id="kpi-label" style="font-size:16px; color:#666; margin:0;"></p>
      </div>
    `;
  },
  updateAsync: function (data, element, config, queryResponse, details, done) {
    // Called each time data or config changes
    const field = queryResponse.fields.measure_like[0];
    const value = data[0][field.name].value;

    const kpiValue = element.querySelector('#kpi-value');
    const kpiLabel = element.querySelector('#kpi-label');

    kpiValue.innerText = value;
    kpiLabel.innerText = field.label;
    kpiValue.style.color = config.color;

    done();
  }
});
