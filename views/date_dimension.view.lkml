view: date_dimension {
  sql_table_name: `looker-training-475011.Employee_Performance_K.Date_dimension` ;;

  dimension_group: date_key {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.DateKey ;;
  }
  dimension: month {
    type: number
    sql: ${TABLE}.Month ;;
  }
  dimension: quarter {
    type: number
    sql: ${TABLE}.Quarter ;;
  }
  dimension: year {
    type: number
    sql: ${TABLE}.Year ;;
  }
  measure: count {
    type: count
  }
}
