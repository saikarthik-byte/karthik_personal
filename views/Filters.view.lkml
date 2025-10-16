view: country_filter {
  derived_table: {
    sql:
      SELECT DISTINCT employee_dimension.Country
      FROM `looker-training-475011.Employee_Performance_K.Employee_fact`
      UNION ALL
      SELECT 'All' AS employee_dimension.Country ;;
  }

  dimension: country {
    primary_key: yes
    sql: ${TABLE}.Country ;;
  }
}
