view: employee_dimension {
  sql_table_name: `looker-training-475011.Employee_Performance_K.employee dimension` ;;

  dimension: city {
    type: string
    sql: ${TABLE}.City ;;
  }
  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.Country ;;
  }

  dimension: country_flag_static {
    type: string
    html: CASE
      WHEN ${country_name} = "USA" THEN "<img src='https://www.countryflags.io/us/flat/64.png' width='30' height='20'>"
      WHEN ${country_name} = "India" THEN "<img src='https://www.countryflags.io/in/flat/64.png' width='30' height='20'>"
      WHEN ${country_name} = "UK" THEN "<img src='https://www.countryflags.io/gb/flat/64.png' width='30' height='20'>"
      WHEN ${country_name} = "China" THEN "<img src='https://www.countryflags.io/cn/flat/64.png' width='30' height='20'>"
      WHEN ${country_name} = "Brazil" THEN "<img src='https://www.countryflags.io/br/flat/64.png' width='30' height='20'>"
      ELSE ""
    END ;;
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
  dimension: state {
    type: string
    sql: ${TABLE}.State ;;
  }
  measure: count {
    type: count
    drill_fields: [employee_name]
  }
}
