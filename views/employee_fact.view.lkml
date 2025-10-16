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
  dimension: hours_worked {
    type: number
    sql: ${TABLE}.HoursWorked ;;
  }
  dimension: performance_score {
    type: number
    sql: ${TABLE}.PerformanceScore ;;
  }
  dimension: sales_amount {
    type: number
    sql: ${TABLE}.SalesAmount ;;
  }
  dimension: tasks_completed {
    type: number
    sql: ${TABLE}.TasksCompleted ;;
  }

  parameter: selected_date{
    label: "select date"
    type: date
  }
  dimension: sale_date {
    type: date
    sql: ${date_key_date} ;;
  }

  measure: avg_sale_price_trailing_3m{
    label: "Avg Sale Price (trailing 3 months)"
    type: number
    sql: (SELECT
       SUM(s.sale_amount) / NULLIF(SUM(s.quantity_sold), 0)
     FROM ${TABLE} AS s
     WHERE s.sale_date BETWEEN DATE_SUB({% parameter selected_date %}, INTERVAL 3 MONTH)
                           AND {% parameter selected_date %});;
  }
  measure: count {
    type: count
  }
}
