view: employee_sales_rank {
  derived_table: {
    sql:
      SELECT
        employee_id,
        SUM(sales_amount) AS sum_sales,
        RANK() OVER (ORDER BY SUM(sales_amount) DESC) AS rank_sales
      FROM employee_fact
      GROUP BY employee_id
    ;;
  }

  dimension: employee_id {
    primary_key: yes
    sql: ${TABLE}.employee_id ;;
  }

  measure: sum_sales {
    type: sum
    sql: ${TABLE}.sum_sales ;;
  }

  dimension: rank_sales {
    type: number
    sql: ${TABLE}.rank_sales ;;
  }

  # 🔽 Optional parameter for Top N filtering
  parameter: top_n {
    type: number
    default_value: "10"
  }

  filter: top_n_sales {
    type: number
    sql: ${rank_sales} <= {% parameter top_n %} ;;
  }
}
