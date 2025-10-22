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

  dimension: department_name_with_all {
    type: string
    sql:
      -- Union of all departments + 'All Departments'
      (SELECT DepartmentName FROM `looker-training-475011.Employee_Performance_K.Department_dimension`)
      UNION ALL
      (SELECT 'All Departments')
    ;;
  }

  measure: count {
    type: count
    drill_fields: [department_name]
  }
}
