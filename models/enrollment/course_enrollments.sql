select
    enrollment.org,
    enrollment.course_key,
    count(enrollment.actor_id) as actor_count,
    enrollment.enrollment_mode,
    names.course_name,
    names.course_run
from {{ ref('dim_most_recent_enrollment') }} enrollment
left join
    {{ ref('dim_course_names') }} names
    on enrollment.org = names.org
    and enrollment.course_key = names.course_key
group by
    org,
    course_key,
    enrollment_mode,
    emission_time,
    course_name,
    course_run