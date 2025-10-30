# Define the database connection to be used for this model.
connection: "prateek_gcp_demo"

# Include all views
include: "/views/**/*.view.lkml"




# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

datagroup: Employee_Performance_model_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: Employee_Performance_model_default_datagroup
label: "Employee Performance karthik"

explore: employee_fact {


  join: employee_dimension {
    type: left_outer
    sql_on: ${employee_fact.employee_id} = ${employee_dimension.employee_id} ;;
    relationship: many_to_one
  }

  join: department_dimension {
    type: left_outer
    sql_on: ${employee_fact.department_id} = ${department_dimension.department_id} ;;
    relationship: many_to_one
  }

  join: productivity_index{
    type: left_outer
    sql_on: ${employee_fact.employee_id} =${productivity_index.employee_id} ;;
    relationship: many_to_one
  }

  join: sql_runner_query {
    type: left_outer
    sql_on: ${employee_fact.employee_id}=${sql_runner_query.employee_dimension_employee_id} ;;
    relationship: many_to_one
  }

  join: employee_sales_rank {
    type: left_outer
    sql_on:${employee_fact.employee_id}=${employee_sales_rank.employee_id}  ;;
    relationship: many_to_one
  }

  join: rank_country {
    type: left_outer
    sql_on: ${employee_dimension.country}=${rank_country.employee_dimension_country} ;;
    relationship: many_to_one
  }





  }
