view: employee_dimension {
  sql_table_name: `looker-training-475011.Employee_Performance_K.employee dimension` ;;

  parameter: country_param {
    type: string
    allowed_value: { label: "All" value: "all" }
    allowed_value: { label: "India" value: "India" }
    allowed_value: { label: "USA" value: "USA" }
    allowed_value: { label: "China" value: "China" }
    allowed_value: { label: "UK" value: "UK" }
    allowed_value: { label: "Brazil" value: "Brazil" }
  }

  dimension: country_filtered {
    type: string
    sql: CASE
           WHEN {% parameter country_param %} IS NULL OR {% parameter country_param %} = 'all'
             THEN ${TABLE}.Country
           ELSE {% parameter country_param %}
         END ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.Country ;;
    drill_fields: [state, city]
  }

  dimension: country_flag_image {
    label: "Flag"
    type: string
    sql: ${country} ;;
    html: |
      <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/Flag_of_{{ value | replace: " ", "_" }}.svg/60px-Flag_of_{{ value | replace: " ", "_" }}.svg.png"
           style="height: 25px; border: 1px solid #ccc; vertical-align: middle;"
           alt="{{ rendered_value }} Flag">
      ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.State ;;
    drill_fields: [city]
  }

  dimension: city {
    type: string
    sql: ${TABLE}.City ;;
  }

  dimension: employee_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.EmployeeID ;;
  }

  dimension: employee_name {
    type: string
    sql: ${TABLE}.EmployeeName ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.Gender ;;
  }

  dimension_group: hire {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.HireDate ;;
  }

  dimension: position {
    type: string
    sql: ${TABLE}.Position ;;
  }

  measure: count {
    type: count
    drill_fields: [employee_name]
  }
}
