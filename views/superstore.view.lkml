view: superstore {
  sql_table_name: "PUBLIC"."SUPERSTORE" ;;

  dimension: category {
    type: string
    sql: ${TABLE}."CATEGORY" ;;
  }
  dimension: city {
    type: string
    sql: ${TABLE}."CITY" ;;
  }
  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}."COUNTRY" ;;
  }
  dimension: customer_id {
    type: string
    sql: ${TABLE}."CUSTOMER_ID" ;;
  }
  dimension: customer_name {
    type: string
    sql: ${TABLE}."CUSTOMER_NAME" ;;
  }
  dimension: discount {
    type: number
    sql: ${TABLE}."DISCOUNT" ;;
  }
  dimension: order_date {
    type: string
    sql: ${TABLE}."ORDER_DATE" ;;
  }
  dimension: order_id {
    type: string
    sql: ${TABLE}."ORDER_ID" ;;
  }
  dimension: postal_code {
    type: number
    sql: ${TABLE}."POSTAL_CODE" ;;
  }
  dimension: product_id {
    type: string
    sql: ${TABLE}."PRODUCT_ID" ;;
  }
  dimension: product_name {
    type: string
    sql: ${TABLE}."PRODUCT_NAME" ;;
  }
  dimension: profit {
    type: number
    sql: ${TABLE}."PROFIT" ;;
  }
  dimension: quantity {
    type: number
    sql: ${TABLE}."QUANTITY" ;;
  }
  dimension: region {
    type: string
    sql: ${TABLE}."REGION" ;;
  }
  dimension: row_id {
    type: number
    sql: ${TABLE}."ROW_ID" ;;
  }
  dimension: sales {
    type: number
    sql: ${TABLE}."SALES" ;;
  }
  dimension: segment {
    type: string
    sql: ${TABLE}."SEGMENT" ;;
  }
  dimension: ship_date {
    type: string
    sql: ${TABLE}."SHIP_DATE" ;;
  }
  dimension: ship_mode {
    type: string
    sql: ${TABLE}."SHIP_MODE" ;;
  }
  dimension: state {
    type: string
    sql: ${TABLE}."STATE" ;;
  }
  dimension: sub_category {
    type: string
    sql: ${TABLE}."SUB_CATEGORY" ;;
  }
  measure: count {
    type: count
    drill_fields: [product_name, customer_name]
  }
}
