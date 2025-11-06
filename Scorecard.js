looker.plugins.visualizations.add({
  id: "simple_card",
  label: "Simple Card",
  options: {},

  create(element, config) {
    // Create container div for card
    this.container = document.createElement("div");
    this.container.style.display = "flex";
    this.container.style.justifyContent = "center";
    this.container.style.alignItems = "center";
    this.container.style.height = "100%";
    this.container.style.fontFamily = "Arial, sans-serif";
    this.container.style.background = "#f0f0f0";
    this.container.style.borderRadius = "8px";
    this.container.style.boxShadow = "0 2px 6px rgba(0,0,0,0.15)";
    this.container.style.color = "#333";
    this.container.style.fontSize = "48px";
    this.container.style.fontWeight = "bold";
    this.container.style.userSelect = "none";
    element.appendChild(this.container);
  },

  updateAsync(data, element, config, queryResponse, details, done) {
    this.clearErrors();

    if (!data || data.length === 0) {
      this.addError({ title: "No Data", message: "No data available for this visualization" });
      done();
      return;
    }

    // Assume single measure, take first row, first value
    const measureValue = data[0][Object.keys(data[0])[0]];

    // Format the value nicely
    const formattedValue = new Intl.NumberFormat().format(measureValue);

    // Update container text
    this.container.innerHTML = formattedValue;

    done();
  }
});
