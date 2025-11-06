looker.plugins.visualizations.add({
  id: "modern_kpi_card",
  label: "Modern KPI Card",
  options: {
    card_bg: {
      section: "Style",
      label: "Background Color",
      type: "string",
      default: "#fff"
    },
    main_font_size: {
      section: "Style",
      label: "Main Value Font Size",
      type: "number",
      default: 82,
      min: 10, max: 200
    },
    main_font_color: {
      section: "Style",
      label: "Main Value Font Color",
      type: "string",
      default: "#212121"
    },
    delta_font_size: {
      section: "Style",
      label: "Delta Font Size",
      type: "number",
      default: 28,
      min: 8, max: 80
    },
    delta_positive_color: {
      section: "Style",
      label: "Positive Delta Color",
      type: "string",
      default: "#43a047" // green
    },
    delta_negative_color: {
      section: "Style",
      label: "Negative Delta Color",
      type: "string",
      default: "#e53935" // red
    },
    label_font_size: {
      section: "Style",
      label: "Label Font Size",
      type: "number",
      default: 24,
      min: 8, max: 60
    },
    label_font_color: {
      section: "Style",
      label: "Label Font Color",
      type: "string",
      default: "#444"
    },
    change_label: {
      section: "Labels",
      label: "Change Description",
      type: "string",
      default: "change in sales"
    },
    show_label: {
      section: "Labels",
      label: "Show Label",
      type: "boolean",
      default: true
    },
    positive_values_are_bad: {
      section: "Comparison",
      label: "Positive Values Are Bad",
      type: "boolean",
      default: false
    }
  },
  create: function (element, config) {
    element.innerHTML = `
      <div id="modern-kpi-container" style="
        width: 100%; height: 100%; display: flex; flex-direction: column; align-items: center; justify-content: center;
      ">
        <div id="kpi-main-value"></div>
        <div id="kpi-delta"></div>
        <div id="kpi-label"></div>
      </div>
    `;
  },
  updateAsync: function (data, element, config, queryResponse, details, done) {
    // Main value (first measure)
    const fields = queryResponse.fields.measure_like;
    const mainValue = data[0][fields[0].name]?.rendered || data[0][fields[0].name]?.value || "";
    // Delta (second measure, should be change %, e.g., -17.32)
    const change = data[0][fields[1].name]?.value || "";
    const isNegative = !config.positive_values_are_bad ? change < 0 : change > 0;
    const changeColor = isNegative ? config.delta_negative_color : config.delta_positive_color;
    // Arrow
    const arrow = isNegative ? "▼" : "▲";
    const delta = `${arrow} ${(Math.abs(change)).toFixed(2)}%`;

    // Main value
    const mainDiv = element.querySelector("#kpi-main-value");
    mainDiv.innerHTML = mainValue;
    mainDiv.style.fontSize = config.main_font_size + "px";
    mainDiv.style.color = config.main_font_color;
    mainDiv.style.fontWeight = "400";
    mainDiv.style.letterSpacing = "1px";
    mainDiv.style.marginBottom = "20px";

    // Delta with color
    const deltaDiv = element.querySelector("#kpi-delta");
    deltaDiv.innerHTML = `<span style="color:${changeColor}; font-size:${config.delta_font_size}px; font-weight:bold;">${delta}</span>`;
    deltaDiv.style.marginBottom = "6px";

    // Subtitle label 
    const labelDiv = element.querySelector("#kpi-label");
    labelDiv.style.display = config.show_label ? "block" : "none";
    labelDiv.innerHTML = config.change_label;
    labelDiv.style.fontSize = config.label_font_size + "px";
    labelDiv.style.color = config.label_font_color;

    // Container background
    element.querySelector("#modern-kpi-container").style.background = config.card_bg;

    done();
  }
});
