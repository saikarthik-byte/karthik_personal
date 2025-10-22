view: department_list_with_all {
  derived_table: {
    sql:
    SELECT DepartmentName AS department_name FROM `looker-training-475011.Employee_Performance_K.Department_dimension`
    UNION ALL
    SELECT 'All Departments' AS department_name
    ;;
  }

  dimension: department_name {
    sql: ${TABLE}.department_name ;;
    type: string
  }
}
