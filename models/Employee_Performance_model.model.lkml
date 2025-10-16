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
  join: date_dimension {
    type: left_outer
    sql_on: ${employee_fact.date_key_raw}=${date_dimension.date_key_raw} ;;
    relationship: many_to_one
  }
  join: employee_dimension {
    type: left_outer
    sql_on: ${employee_fact.employee_id}=${employee_dimension.employee_id};;
    relationship: many_to_one
  }
  join: department_dimension {
    type: left_outer
    sql_on: ${employee_fact.department_id}=${department_dimension.department_id} ;;
    relationship: many_to_one
  }

}
