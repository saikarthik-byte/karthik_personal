view: department_dimension {
  sql_table_name: `looker-training-475011.Employee_Performance_K.Department_dimension` ;;

  dimension: department_head {
    type: string
    sql: ${TABLE}.DepartmentHead ;;
  }
  dimension: department_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.DepartmentID ;;
  }
  dimension: department_name {
    type: string
    sql: ${TABLE}.DepartmentName ;;
  }

# Hardcoded parameter for department filter

  parameter: department_filter {
    type: string
    allowed_value: { label: "All Departments" value: "all" }
    allowed_value: { label: "Dept_1" value: "Dept_1" }
    allowed_value: { label: "Dept_2" value: "Dept_2" }
    allowed_value: { label: "Dept_3" value: "Dept_3" }
    allowed_value: { label: "Dept_4" value: "Dept_4" }
    allowed_value: { label: "Dept_5" value: "Dept_5" }
    allowed_value: { label: "Dept_6" value: "Dept_6" }
    allowed_value: { label: "Dept_7" value: "Dept_7" }
    allowed_value: { label: "Dept_8" value: "Dept_8" }
    allowed_value: { label: "Dept_9" value: "Dept_9" }
    allowed_value: { label: "Dept_10" value: "Dept_10" }
    default_value: "all"
  }

  # Dimension applies filter logic for 'All Departments' or specific department
  dimension: filtered_department_name {
    type: string
    sql: |
      CASE
        WHEN {% parameter department_filter %} = 'all' THEN ${department_name}
        WHEN {% parameter department_filter %} = ${department_name} THEN ${department_name}
        ELSE NULL
      END ;;
  }


  measure: count {
    type: count
    drill_fields: [department_name]
  }
}
