
view: rank_country {
  derived_table: {
    sql: WITH ranked_sales AS (
        SELECT
            employee_dimension.Country AS employee_dimension_country,
            COALESCE(SUM(employee_fact.SalesAmount), 0) AS employee_fact_sum_sales_1,
            RANK() OVER (ORDER BY COALESCE(SUM(employee_fact.SalesAmount), 0) DESC) AS employee_fact_rank_sales,*
        FROM `looker-training-475011.Employee_Performance_K.Employee_fact` AS employee_fact
        LEFT JOIN `looker-training-475011.Employee_Performance_K.employee dimension` AS employee_dimension
          ON employee_fact.EmployeeID = employee_dimension.EmployeeID
        GROUP BY
            employee_dimension.Country
      )
      SELECT *
      FROM ranked_sales
      WHERE employee_fact_rank_sales <= (
        SELECT COUNT(*) FROM ranked_sales
      )
      ORDER BY employee_fact_sum_sales_1 DESC ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: employee_dimension_country {
    type: string
    sql: ${TABLE}.employee_dimension_country ;;
  }



  dimension: employee_fact_sum_sales_1 {
    type: number
    sql: ${TABLE}.employee_fact_sum_sales_1 ;;
  }

  dimension: employee_fact_rank_sales {
    type: number
    sql: ${TABLE}.employee_fact_rank_sales ;;
  }

  set: detail {
    fields: [
      employee_dimension_country,
      employee_fact_sum_sales_1,
      employee_fact_rank_sales
    ]
  }
}
