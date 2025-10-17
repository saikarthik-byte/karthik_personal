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


  parameter: selected_month {
    type: date
  }

  measure: prev_year_month_cost {
    type: sum
    sql: CASE
        WHEN EXTRACT(MONTH FROM ${date_key_date}) = EXTRACT(MONTH FROM {% parameter selected_month %}) -1

        THEN ${sales_amount}
        ELSE NULL
      END ;;
  }

  measure: total_price_colored {

    type: sum
    sql: ${sales_amount} ;;

    html:
    {% if value <= 6880356.2 %}
      <p style="color: black; background-color: red; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% elsif value <= 10125146.17 %}
      <p style="color: black; background-color: orange; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% else %}
      <p style="color: black; background-color: green; font-size:100%; text-align:center">{{ rendered_value }}</p>
    {% endif %}
  ;;
  }

  measure: avg_trailing_3_month_sales {
    type: number
    value_format_name: "usd"
    sql:
      (SELECT AVG(f.sales_amount)
       FROM `looker-training-475011.Employee_Performance_K.Employee_fact` f
       WHERE f.DateKey BETWEEN DATE_SUB({% parameter selected_month %}, INTERVAL 3 MONTH)
       AND {% parameter selected_month %}) ;;
    description: "Average Sales Amount for the trailing 3 months based on the selected date."
  }



  measure: count {
    type: count
  }
}
