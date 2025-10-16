view: employee_dimension {
  sql_table_name: `looker-training-475011.Employee_Performance_K.employee_dimension` ;;

  parameter: country_param {
    type: string
    allowed_value: { label: "All" value: "All" }
    allowed_value: { label: "India" value: "India" }
    allowed_value: { label: "USA" value: "USA" }
    allowed_value: { label: "China" value: "China" }
    allowed_value: { label: "UK" value: "UK" }
    allowed_value: { label: "Brazil" value: "Brazil" }
    default_value: "All"
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.Country ;;
    drill_fields: [state, city]
  }

  dimension: country_filtered {
    type: string
    sql: CASE
           WHEN {% parameter country_param %} = 'All' THEN ${TABLE}.Country
           ELSE {% parameter country_param %}
         END ;;
    map_layer_name: countries
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
