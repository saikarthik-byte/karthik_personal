view: department_list_with_al{
  derived_table: {
    sql:
    SELECT DepartmentName AS department_name FROM `looker-training-475011.Employee_Performance_K.Department_dimension`
    UNION ALL
    SELECT 'All Departments' AS department_name
    ;;
  }

  dimension: department_Mmm {
    sql: ${TABLE}.department_name ;;
    type: string
  }
}
