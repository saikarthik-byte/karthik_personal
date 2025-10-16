view: country_filter {
  derived_table: {
    sql:
      SELECT DISTINCT Country
      FROM `looker-training-475011.Employee_Performance_K.Employee_fact`
      UNION ALL
      SELECT 'All' AS Country ;;
  }

  dimension: country {
    primary_key: yes
    sql: ${TABLE}.Country ;;
  }
}
