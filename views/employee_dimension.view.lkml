view: employee_dimension {
  sql_table_name: `looker-training-475011.Employee_Performance_K.employee dimension` ;;

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.Country ;;

  }

  dimension: state {
    type: string
    sql: ${TABLE}.State ;;

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
