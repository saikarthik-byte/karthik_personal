
view: sql_runner_query {
  derived_table: {
    sql: SELECT
        *
      FROM (
        SELECT
          employee_dimension.EmployeeID AS employee_dimension_employee_id,
          COALESCE(SUM(employee_fact.SalesAmount), 0) AS employee_fact_sum_sales_1,
          RANK() OVER (ORDER BY COALESCE(SUM(employee_fact.SalesAmount), 0) DESC) AS employee_fact_rank_sales
        FROM `looker-training-475011.Employee_Performance_K.Employee_fact` AS employee_fact
        LEFT JOIN `looker-training-475011.Employee_Performance_K.employee dimension` AS employee_dimension
          ON employee_fact.EmployeeID = employee_dimension.EmployeeID
        GROUP BY employee_dimension.EmployeeID
      ) AS ranked_data

      ORDER BY employee_fact_sum_sales_1 DESC
      LIMIT 500 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: employee_dimension_employee_id {
    type: number
    sql: ${TABLE}.employee_dimension_employee_id ;;
  }

  measure: employee_fact_sum_sales_1 {
    type: sum
    sql: ${TABLE}.employee_fact_sum_sales_1 ;;
  }

  dimension: employee_fact_rank_sales {
    type: number
    sql: ${TABLE}.employee_fact_rank_sales ;;
  }

  set: detail {
    fields: [
        employee_dimension_employee_id,
  employee_fact_sum_sales_1,
  employee_fact_rank_sales
    ]
  }
}
