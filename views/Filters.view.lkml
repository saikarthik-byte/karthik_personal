view: country_filter {
  derived_table: {
    sql:
      SELECT DISTINCT country
      FROM `looker-training-475011.Employee_Performance_K.Employee_fact`
      UNION ALL
      SELECT 'All' AS country ;;
  }

  dimension: country {
    primary_key: yes
    sql: ${TABLE}.Country ;;
  }
}
