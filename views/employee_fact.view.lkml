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

  measure: avg_in_trailing_3_months_of_selected_date {
    label: "Avg sales Trailing 3 months"
    type: average
    sql:
    CASE
      WHEN DATE(${date_key_date}) BETWEEN DATE_SUB(DATE({% parameter selected_date %}), INTERVAL 3 MONTH) AND DATE({% parameter selected_date %})
      THEN ${sales_amount}
      ELSE 0
    END ;;
    description: "Sum of sales_amount if sale_date falls within the last 3 months of the selected date"
  }

  parameter: metric_selector {
    type: unquoted
    allowed_value: {
      label: "Sales Amount"
      value: "sales"
    }
    allowed_value: {
      label: "Hours Worked"
      value: "hours"
    }
    allowed_value: {
      label: "Performance Score"
      value: "score"
    }
    default_value: "sales"
  }

  measure: dynamic_metric {
    type: number
    sql:
    CASE
      WHEN {% parameter metric_selector %} = "sales" THEN ${sales_amount}
      WHEN {% parameter metric_selector %} = "hours" THEN ${hours_worked}
      WHEN {% parameter metric_selector %} = "score" THEN ${performance_score}
      ELSE NULL
    END ;;
    value_format_name: "decimal_2"
    description: "Dynamically switch between Sales Amount, Hours Worked, and Performance Score based on selection."
  }






  measure: count {
    type: count
  }
}
