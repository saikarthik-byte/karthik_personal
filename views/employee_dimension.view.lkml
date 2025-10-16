view: employee_dimension {
  sql_table_name: `looker-training-475011.Employee_Performance_K.employee dimension` ;;

  dimension: city {
    type: string
    sql: ${TABLE}.City ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.Country ;;
  }

  dimension: country_flag_image {

    type: string
    sql: ${country} ;;
    html:
    {% if country._value == "Brazil" %}
    <img src="https://upload.wikimedia.org/wikipedia/commons/0/05/Flag_of_Brazil.svg" height="170" width="255">
    {% elsif country._value == "China" %}
    <img src="https://upload.wikimedia.org/wikipedia/commons/f/fa/Flag_of_the_People%27s_Republic_of_China.svg" height="170" width="255">
    {% elsif country._value == "India" %}
    <img src="https://upload.wikimedia.org/wikipedia/commons/4/41/Flag_of_India.svg" height="170" width="255">
    {% elsif country._value == "UK" %}
    <img src="https://upload.wikimedia.org/wikipedia/commons/a/ae/Flag_of_the_United_Kingdom.svg" height="170" width="255">
    {% elsif country._value == "USA" %}
    <img src="https://upload.wikimedia.org/wikipedia/commons/a/a4/Flag_of_the_United_States.svg" height="170" width="255">
    {% else %}
    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png" height="170" width="170">
    {% endif %}
    ;;
  }

  dimension: employee_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.EmployeeID ;;
  }

  dimension: employee_name {
    type: string
    sql: ${TABLE}.EmployeeName ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.Gender ;;
  }

  dimension_group: hire {
    type: time
    timeframes: [raw, date, week, month, quarter, year]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.HireDate ;;
  }

  dimension: position {
    type: string
    sql: ${TABLE}.Position ;;
  }

  dimension: state {
    type: string
    sql: ${TABLE}.State ;;
  }

  dimension: region_filter {
    sql:
    CASE
      WHEN ${country} IS NULL THEN 'Unknown'
      ELSE ${country}
    END ;;
  }

  parameter: region_param {

    type: string
    suggest_explore: employee_dimension
    suggest_dimension: country
    bypass_suggest_restrictions: yes
    full_suggestions: yes
    allowed_value: {
      label: "All"
      value: "All"
    }
    default_value: "All"
  }

  dimension: region_with_all {
    type: string
    sql:
      CASE
        WHEN {% parameter region_param %} = "All" THEN ${country}
        ELSE {% parameter region_param %}
      END ;;
  }



  measure: count {
    type: count
    drill_fields: [employee_name]
  }
}
