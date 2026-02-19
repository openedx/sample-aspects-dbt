{{
    config(
        materialized="materialized_view",
        engine=aspects.get_engine("ReplacingMergeTree()"),
        primary_key="(org, course_key, actor_id, object_id)",
        order_by="(org, course_key, actor_id, object_id, approving_state)",
    )
}}

select
    status.org as org,
    status.course_key as course_key,
    status.actor_id as actor_id,
    last_response.object_id as object_id,
    case when last_response.success and last_response.attempts = 1 then 1 else 0 end as correct_first_attempt,
    status.course_grade as course_grade,
    status.approving_state as approving_state,
    last_response.responses as responses
from {{ ref('dim_student_status') }} as status
left join
    {{ ref('dim_learner_last_response') }} as last_response
    on status.org = last_response.org
    and status.course_key = last_response.course_key
    and status.actor_id = last_response.actor_id
