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

  parameter: selected_date {

    type: date
  }

  measure: sale_tailing_3m{
    type: number
    sql:
    AVG(CASE
          WHEN ${date_key_date} BETWEEN DATE_SUB(CAST({% parameter selected_date %} AS DATE), INTERVAL 3 MONTH)
                          AND CAST({% parameter selected_date %} AS DATE)
          THEN ${sales_amount}
          ELSE NULL
        END) ;;
  }


  parameter: selected_month {
    type: date
  }





  measure: count {
    type: count
  }
}
