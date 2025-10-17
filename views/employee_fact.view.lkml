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

  parameter: selected_date {
    type: date
  }

  dimension: last_date_last {
    type: date
    sql: DATE({% parameter selected_date %}) ;;
  }

  dimension: start_date_3_months_back {
    type: date
    sql: DATE_SUB(DATE({% parameter selected_date %}), INTERVAL 3 MONTH) ;;
  }

  dimension: is_in_trailing_3_months {
    type: yesno
    sql: ${date_key_date} BETWEEN ${start_date_3_months_back} AND ${last_date_last} ;;
  }

  measure: total_sales_trailing_3_months {
    type: sum
    sql: ${sales_amount} ;;
    filters:
      {
      field: is_in_trailing_3_months
      value: "yes"
      }

  }

  measure: total_orders_trailing_3_months {
    type: count
    filters:
      {
      field: is_in_trailing_3_months
      value: "yes"
      }

  }

  measure: avg_sales_trailing_3_months {
    type: number
    sql: ${total_sales_trailing_3_months} / NULLIF(${total_orders_trailing_3_months}, 0) ;;
    description: "Average sale price for trailing 3 months based on selected date"
  }




  measure: count {
    type: count
  }
}
