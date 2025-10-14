view: employee_fact {
  sql_table_name: `looker-training-475011.Employee_Performance_K.Employee_fact` ;;

  dimension_group: date_key {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.DateKey ;;
  }
  dimension: department_id {
    type: number
    sql: ${TABLE}.DepartmentID ;;
  }
  dimension: employee_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.EmployeeID ;;
  }
  measure: hours_worked {
    type: number
    sql: ${TABLE}.HoursWorked ;;
  }
  measure: performance_score {
    type: number
    sql: ${TABLE}.PerformanceScore ;;
  }
  measure: sales_amount {
    type: number
    sql: ${TABLE}.SalesAmount ;;
  }
  measure: tasks_completed {
    type: number
    sql: ${TABLE}.TasksCompleted ;;
  }
  measure: count {
    type: count
  }
}
