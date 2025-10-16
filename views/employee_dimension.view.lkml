view: employee_dimension {
  sql_table_name: `looker-training-475011.Employee_Performance_K.employee dimension` ;;

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.Country ;;
    drill_fields: [state, city]

  }
  dimension: country_flag_image {
    label: "Flag"
    type: string
    # The SQL is just referencing the country dimension to pass its value to the HTML parameter
    sql: ${country} ;;

    # The html parameter uses Liquid to construct the <img> tag and image source URL.
    # It replaces spaces with underscores to match common file naming conventions (e.g., "United States" -> "United_States").
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
  dimension: country_filter {
    type: string
    sql: CASE
        WHEN {% parameter selected_country %} = 'All' THEN ${employee_dimension.country}
        ELSE ${employee_dimension.country}
      END ;;
  }
  filter: country_filter_dashboard {
    type: string
    sql:
    CASE
      WHEN {% parameter selected_country %} = 'All' THEN 1=1
      ELSE ${employee_dimension.country} = {% parameter selected_country %}
    END ;;
  }





  measure: count {
    type: count
    drill_fields: [employee_name]
  }
}
