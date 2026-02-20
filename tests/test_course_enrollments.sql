  select
      count(*) as num_rows
  from
      {{ ref('enrollment_mode') }}
  group by
        org,
        course_key,
        enrollment_mode,
        course_name,
        course_run
  having num_rows > 1