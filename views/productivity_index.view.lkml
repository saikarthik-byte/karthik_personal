view: productivity_index {
  sql_table_name: `looker-training-475011.Employee_Performance_K.Employee_fact` ;;
# Dimensions

  dimension: date_key {
    type: number
    sql: ${TABLE}.DateKey ;;
  }

  dimension: employee_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.EmployeeID ;;
  }

  dimension: department_id {
    type: number
    sql: ${TABLE}.DepartmentID ;;
  }

  # Measures
  measure: total_tasks_completed {
    type: sum
    sql: ${TABLE}.TasksCompleted ;;
    value_format_name: decimal_2
  }

  measure: total_hours_worked {
    type: sum
    sql: ${TABLE}.HoursWorked;;
    value_format_name: decimal_2
  }

  measure: productivity_index {
    label: "Productivity Index"
    type: number
    sql: CASE
            WHEN ${total_hours_worked} = 0 THEN NULL
            ELSE ${total_tasks_completed} / ${total_hours_worked}
         END ;;
    value_format_name: decimal_2
  }
}
