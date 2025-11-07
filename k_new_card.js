looker.plugins.visualizations.add({
  id: "modern_kpi_card",
  label: "Modern KPI Card",
  options: {
    main_value_format: {
      section: "Formatting",
      label: "Main Value Format",
      type: "string",
      display: "select",
      values: [
        {"Auto": "auto"},
        {"Thousands (K)": "k"},
        {"Millions (M)": "m"},
        {"Billions (B)": "b"},
        {"None": "none"}
      ],
      default: "auto"
    },
    card_bg: {
      section: "Style",
      label: "Background Color",
      type: "string",
      default: "#fff"
    },
    conditional_bg: {
      section: "Style",
      label: "Enable Conditional Background",
      type: "boolean",
      default: false
    },
    positive_bg_color: {
      section: "Style",
      label: "Background Color for Positive Change",
      type: "string",
      default: "#e0f2f1"
    },
    negative_bg_color: {
      section: "Style",
      label: "Background Color for Negative Change",
      type: "string",
      default: "#ffebee"
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
      default: "#43a047"
    },
    delta_negative_color: {
      section: "Style",
      label: "Negative Delta Color",
      type: "string",
      default: "#e53935"
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
    // Formatting Helper
    function formatValue(num, mode) {
      num = Number(num);
      if (isNaN(num)) return num;
      switch(mode) {
        case "k": return (num / 1e3).toFixed(2).replace(/\.00$/, '') + "K";
        case "m": return (num / 1e6).toFixed(2).replace(/\.00$/, '') + "M";
        case "b": return (num / 1e9).toFixed(2).replace(/\.00$/, '') + "B";
        case "none": return num.toLocaleString();
        case "auto":
        default:
          if (num >= 1e9) return (num / 1e9).toFixed(2).replace(/\.00$/, '') + "B";
          if (num >= 1e6) return (num / 1e6).toFixed(2).replace(/\.00$/, '') + "M";
          if (num >= 1e3) return (num / 1e3).toFixed(2).replace(/\.00$/, '') + "K";
          return num.toLocaleString();
      }
    }

    // Data
    const fields = queryResponse.fields.measure_like;
    const mainRawValue = data[0][fields[0].name]?.value || 0;
    const change = data[0][fields[1].name]?.value || 0;
    const isNegative = !config.positive_values_are_bad ? change < 0 : change > 0;
    const changeColor = isNegative ? config.delta_negative_color : config.delta_positive_color;
    const arrow = isNegative ? "▼" : "▲";
    const delta = `${arrow} ${(Math.abs(change)).toFixed(2)}%`;

    // Conditional background color
    const bgColor = config.conditional_bg
      ? (isNegative ? config.negative_bg_color : config.positive_bg_color)
      : config.card_bg;
    element.querySelector("#modern-kpi-container").style.background = bgColor;

    // Main value
    const mainDiv = element.querySelector("#kpi-main-value");
    mainDiv.innerHTML = formatValue(mainRawValue, config.main_value_format);
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

    done();
  }
});
