view: consistent_employee_performance {
  derived_table: {
    sql:
      SELECT
        e.EmployeeID,
        e.EmployeeName,
        d.DepartmentName,
        SUM(f.SalesAmount) AS Total_Sales,
        SUM(f.TasksCompleted) AS Total_Tasks,
        SUM(f.HoursWorked) AS Total_Hours,
        AVG(f.PerformanceScore) AS Avg_Score
      FROM `looker-training-475011.Employee_Performance_K.employee_fact` f
      JOIN `looker-training-475011.Employee_Performance_K.employee_dimension` e
        ON f.EmployeeID = e.EmployeeID
      JOIN `looker-training-475011.Employee_Performance_K.department_dimension` d
        ON f.DepartmentID = d.DepartmentID
      WHERE f.EmployeeID IN (
        SELECT EmployeeID
        FROM `looker-training-475011.Employee_Performance_K.employee_fact`
        GROUP BY EmployeeID
        HAVING COUNT(DISTINCT PerformanceScore) = 1
           AND COUNT(DISTINCT DepartmentID) > 1
      )
      GROUP BY e.EmployeeID, e.EmployeeName, d.DepartmentName
      ;;
  }

  dimension: employee_id { type: number sql: ${TABLE}.EmployeeID ;; }
  dimension: employee_name { type: string sql: ${TABLE}.EmployeeName ;; }


  measure: total_sales { type: sum sql: ${TABLE}.Total_Sales ;; }
  measure: total_tasks { type: sum sql: ${TABLE}.Total_Tasks ;; }
  measure: total_hours { type: sum sql: ${TABLE}.Total_Hours ;; }
  measure: avg_score { type: average sql: ${TABLE}.Avg_Score ;; }
}
