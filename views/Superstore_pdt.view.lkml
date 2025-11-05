view: superstore_pdt {
  derived_table: {
    sql:
      SELECT
        ${TABLE}."COUNTRY" AS country,
        ${TABLE}."CITY" AS city,
        ${TABLE}."SALES" AS sales,
        ${TABLE}."SHIP_DATE" AS ship_date
      FROM ${superstore.SQL_TABLE_NAME} ;;

    # SQL trigger rebuilds PDT when this value changes (latest ship_date)
      sql_trigger_value: SELECT MAX("SHIP_DATE") FROM ${superstore.SQL_TABLE_NAME} ;;

      # Optional: persist table for 24 hours maximum before dropping
      persist_for: "24 hours"
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
  }
