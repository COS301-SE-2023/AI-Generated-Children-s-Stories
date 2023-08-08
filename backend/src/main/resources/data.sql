-- Drop the view if it already exists (optional, to handle changes in the view definition)
DROP VIEW IF EXISTS user_story_info;
-- Create the view
CREATE OR REPLACE VIEW user_story_info AS
SELECT
    ROW_NUMBER() OVER () AS auto_id,
        u.id AS user_id,
    s.id AS story_id,
    s.title,
    s.trailer,
    (CASE WHEN l.story_id IS NOT NULL THEN true ELSE false END) AS liked,
    (CASE WHEN pr.page_number IS NOT NULL THEN pr.page_number ELSE 0 END) AS page_no
FROM
    Story s
        CROSS JOIN User u
        LEFT JOIN Liked l ON s.id = l.story_id AND u.id = l.user_id
        LEFT JOIN Progress pr ON s.id = pr.story_id AND u.id = pr.user_id;