view: sql_runner_query_main {

  derived_table: {
    sql: SELECT
        employee_dimension_employee_name,
        employee_fact_top_n_sales,
        rank_sales,
        employee_id
      FROM (
        SELECT
          employee_dimension.EmployeeName AS employee_dimension_employee_name,
          SUM(employee_fact.SalesAmount) AS employee_fact_top_n_sales,
          employee_dimension.EmployeeID AS employee_id,
          RANK() OVER (ORDER BY SUM(employee_fact.SalesAmount) DESC) AS rank_sales
        FROM `looker-training-475011.Employee_Performance_K.Employee_fact` AS employee_fact
        LEFT JOIN `looker-training-475011.Employee_Performance_K.employee_dimension` AS employee_dimension
          ON employee_fact.EmployeeID = employee_dimension.EmployeeID
        GROUP BY
          employee_dimension.EmployeeName,
          employee_dimension.EmployeeID
      )
      WHERE rank_sales <= 25
      ORDER BY employee_fact_top_n_sales DESC
      LIMIT 500 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: employee_id {
    type: number
    sql: ${TABLE}.employee_id ;;
  }


  dimension: employee_dimension_employee_name {
    type: string
    sql: ${TABLE}.employee_dimension_employee_name ;;
  }

  dimension: employee_fact_top_n_sales {
    type: number
    sql: ${TABLE}.employee_fact_top_n_sales ;;
  }

  dimension: rank_sales {
    type: number
    sql: ${TABLE}.rank_sales ;;
  }

  set: detail {
    fields: [
        employee_dimension_employee_name,
  employee_fact_top_n_sales,
  rank_sales
    ]
  }
}
