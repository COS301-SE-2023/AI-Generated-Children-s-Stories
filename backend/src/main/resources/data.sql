-- Drop the view if it already exists (optional, to handle changes in the view definition)
DROP VIEW IF EXISTS user_story_info;
-- Create the view
CREATE VIEW user_story_info AS
SELECT
    ROW_NUMBER() OVER () AS id,
    u.id AS user_id,
    s.id AS story_id,
    s.title,
    s.trailer,
    CASE WHEN l.story_id IS NOT NULL THEN true ELSE false END AS liked,
    CASE WHEN pr.page_number IS NOT NULL THEN pr.page_number ELSE 0 END AS page_no,
    COUNT(DISTINCT p.id) AS total_pages
FROM
    user u
CROSS JOIN
    story s
LEFT JOIN
    liked l ON s.id = l.story_id AND u.id = l.user_id
LEFT JOIN
    progress pr ON s.id = pr.story_id AND u.id = pr.user_id
LEFT JOIN
    page p ON s.id = p.story_id
GROUP BY
    u.id, s.id;