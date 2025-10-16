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

  measure: sales_amount_colored {
    type: number
    sql: ${sales_amount} ;;
    html:
    {% if value > 10000 %}
      <span style="color:green;font-weight:bold;">${value}</span>
    {% elsif value > 5000 %}
      <span style="color:orange;">${value}</span>
    {% else %}
      <span style="color:red;">${value}</span>
    {% endif %} ;;
  }



  measure: count {
    type: count
  }
}
