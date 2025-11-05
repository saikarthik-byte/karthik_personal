view: superstore_pdt {
  derived_table: {
    sql:
      SELECT
        ${TABLE}."COUNTRY" AS country,
        ${TABLE}."CITY" AS city,
        ${TABLE}."SALES" AS sales,
        ${TABLE}."SHIP_DATE" AS ship_date,
        ${TABLE}."ORDER_ID" AS order_id
      FROM ${superstore.SQL_TABLE_NAME} ;;

      #sql_trigger_value: SELECT MAX("SHIP_DATE") FROM ${superstore.SQL_TABLE_NAME} ;;

      #persist_for: "24 hours"
    }

    dimension: country {
      type: string
      sql: ${TABLE}.country ;;
    }

    dimension: city {
      type: string
      sql: ${TABLE}.city ;;
    }

    dimension: sales {
      type: number
      sql: ${TABLE}.sales ;;
    }

    dimension: ship_date {
      type: string
      sql: ${TABLE}.ship_date ;;
    }

    dimension: order_id {
      type: string
      sql: ${TABLE}.order_id ;;
    }
  }
