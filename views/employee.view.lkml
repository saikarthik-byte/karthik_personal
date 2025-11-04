view: employee {
  sql_table_name: "PUBLIC"."EMPLOYEE" ;;

  dimension: c1 {
    type: string
    sql: ${TABLE}."C1" ;;
  }
  dimension: c2 {
    type: string
    sql: ${TABLE}."C2" ;;
  }
  dimension: c3 {
    type: string
    sql: ${TABLE}."C3" ;;
  }
  dimension: c4 {
    type: string
    sql: ${TABLE}."C4" ;;
  }
  dimension: c5 {
    type: string
    sql: ${TABLE}."C5" ;;
  }
  dimension: c6 {
    type: string
    sql: ${TABLE}."C6" ;;
  }
  dimension: c7 {
    type: string
    sql: ${TABLE}."C7" ;;
  }
  dimension: c8 {
    type: string
    sql: ${TABLE}."C8" ;;
  }
  measure: count {
    type: count
  }
}
