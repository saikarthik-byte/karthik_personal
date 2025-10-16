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

  dimension: country_flag {
    type: string
    sql: CASE
      WHEN ${country} = 'USA' THEN 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Flag_of_the_United_States.svg/64px-Flag_of_the_United_States.svg.png'
      WHEN ${country} = 'India' THEN 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Flag_of_India.svg/64px-Flag_of_India.svg.png'
      WHEN ${country} = 'UK' THEN 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Flag_of_the_United_Kingdom.svg/64px-Flag_of_the_United_Kingdom.svg.png'
      WHEN ${country} = 'Canada' THEN 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cf/Flag_of_Canada.svg/64px-Flag_of_Canada.svg.png'
      WHEN ${country} = 'Australia' THEN 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b9/Flag_of_Australia.svg/64px-Flag_of_Australia.svg.png'
      WHEN ${country} = 'Germany' THEN 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Flag_of_Germany.svg/64px-Flag_of_Germany.svg.png'
      WHEN ${country} = 'France' THEN 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Flag_of_France.svg/64px-Flag_of_France.svg.png'
      WHEN ${country} = 'Italy' THEN 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/03/Flag_of_Italy.svg/64px-Flag_of_Italy.svg.png'
      WHEN ${country} = 'Spain' THEN 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9a/Flag_of_Spain.svg/64px-Flag_of_Spain.svg.png'
      WHEN ${country} = 'Brazil' THEN 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Flag_of_Brazil.svg/64px-Flag_of_Brazil.svg.png'
      WHEN ${country} = 'China' THEN 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/29/Flag_of_China.svg/64px-Flag_of_China.svg.png'
      WHEN ${country} = 'Japan' THEN 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9e/Flag_of_Japan.svg/64px-Flag_of_Japan.svg.png'
      WHEN ${country} = 'South Korea' THEN 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/Flag_of_South_Korea.svg/64px-Flag_of_South_Korea.svg.png'
      WHEN ${country} = 'Mexico' THEN 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fc/Flag_of_Mexico.svg/64px-Flag_of_Mexico.svg.png'
      WHEN ${country} = 'Argentina' THEN 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/Flag_of_Argentina.svg/64px-Flag_of_Argentina.svg.png'
      WHEN ${country} = 'Russia' THEN 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f3/Flag_of_Russia.svg/64px-Flag_of_Russia.svg.png'
      WHEN ${country} = 'South Africa' THEN 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/af/Flag_of_South_Africa.svg/64px-Flag_of_South_Africa.svg.png'
      WHEN ${country} = 'Egypt' THEN 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_Egypt.svg/64px-Flag_of_Egypt.svg.png'
      WHEN ${country} = 'Nigeria' THEN 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/Flag_of_Nigeria.svg/64px-Flag_of_Nigeria.svg.png'
      WHEN ${country} = 'Kenya' THEN 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/Flag_of_Kenya.svg/64px-Flag_of_Kenya.svg.png'
      WHEN ${country} = 'Saudi Arabia' THEN 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/Flag_of_Saudi_Arabia.svg/64px-Flag_of_Saudi_Arabia.svg.png'
      WHEN ${country} = 'United Arab Emirates' THEN 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Flag_of_the_United_Arab_Emirates.svg/64px-Flag_of_the_United_Arab_Emirates.svg.png'
      ELSE ''
    END ;;
    html: "<img src='${country_flag}' width='255' height='170'>" ;;
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

  measure: count {
    type: count
    drill_fields: [employee_name]
  }
}
