view: employee_fact {
  sql_table_name: `looker-training-475011.Employee_Performance_K.Employee_fact` ;;

  dimension_group: date_key {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.DateKey ;;
  }
  dimension: Year {

    type: number
    sql: EXTRACT(YEAR FROM ${date_key_raw}) ;;
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
    {% if metric_selector._parameter_value == 'sales' %}
      SUM(${sales_amount})
    {% elsif metric_selector._parameter_value == 'hours' %}
      SUM(${hours_worked})
    {% elsif metric_selector._parameter_value == 'score' %}
      SUM(${performance_score})
    {% else %}
      NULL
    {% endif %}
    ;;
  }



  parameter: date_granularity {

    type: unquoted
    allowed_value: {
      label: "Day"
      value: "day"
    }
    allowed_value: {
      label: "Month"
      value: "month"
    }
    allowed_value: {
      label: "Year"
      value: "year"
    }
    default_value: "month"
  }

  dimension: dynamic_date_dim {
    type: string
    sql:
    {% if date_granularity._parameter_value == 'day' %}
      FORMAT_DATE('%Y-%m-%d', ${date_key_date})
    {% elsif date_granularity._parameter_value == 'month' %}
      FORMAT_DATE('%Y-%m', ${date_key_date})
    {% else %}
      FORMAT_DATE('%Y', ${date_key_date})
    {% endif %}
    ;;
    description: "Dynamic date dimension for Day/Month/Year granularity based on Employee Fact DateKey"
  }

  parameter: top_n {
    label: "Top N Value"
    type: number
    default_value: "10"
    description: "Select how many top records to display"
  }

  measure: top_n_sales {
    type: number
    sql:
    CASE WHEN RANK() OVER (ORDER BY SUM(${sales_amount}) DESC)
         <= {% parameter top_n %} THEN SUM(${sales_amount})
    END ;;
  }
  dimension: in_top_n {
    type: yesno
    sql: RANK() OVER (ORDER BY SUM(${sales_amount}) DESC) <= {% parameter top_n %} ;;
    group_label: "Top N"
    description: "True if the row is in the Top N by SUM(sales_amount)"
  }

  measure: Sum_Sales {
    type: sum
    sql: ${sales_amount} ;;
  }










  measure: count {
    type: count
  }
}
