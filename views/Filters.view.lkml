view: country_filter {
  derived_table: {
    sql:
      SELECT 'All' AS Country
      UNION ALL
      SELECT DISTINCT Country
      FROM `looker-training-475011.Employee_Performance_K`.`employee dimension` ;;
  }

  dimension: country {
    type: string
    sql: ${TABLE}.Country ;;
  }
}
