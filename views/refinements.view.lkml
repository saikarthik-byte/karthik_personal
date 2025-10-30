view: +employee_fact {
  parameter: top_n {
    label: "Top N Employees"
    type: number
    default_value: "10"
    description: "Show only top N employees based on total sales"
  }

  dimension: rank_sales_dim {
    label: "Sales Rank"
    type: number
    sql: RANK() OVER (ORDER BY SUM(${sales_amount}) DESC) ;;
    description: "Rank based on total sales amount"
  }

  dimension: in_top_n {
    label: "Is in Top N"
    type: yesno
    sql: ${rank_sales_dim} <= {% parameter top_n %} ;;
    description: "True if the employee is within Top N by sales"
    group_label: "Top N"
  }

  measure: top_n_sales {
    label: "Top N Sales"
    type: sum
    sql:
      CASE
        WHEN ${rank_sales_dim} <= {% parameter top_n %}
        THEN ${sales_amount}
      END ;;
    description: "Sum of sales for only the top N ranked employees"
  }
}
