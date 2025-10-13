view: department_dimension {
  sql_table_name: `looker-training-475011.Employee_Performance_K.Department_dimension` ;;

  dimension: department_head {
    type: string
    sql: ${TABLE}.DepartmentHead ;;
  }
  dimension: department_id {
    type: number
    sql: ${TABLE}.DepartmentID ;;
  }
  dimension: department_name {
    type: string
    sql: ${TABLE}.DepartmentName ;;
  }
  measure: count {
    type: count
    drill_fields: [department_name]
  }
}
