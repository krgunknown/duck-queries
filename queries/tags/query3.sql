SELECT n.title, n.content, GROUP_CONCAT(t.name, ', ') AS tags
FROM notes n
LEFT JOIN note_tags nt ON n.id = nt.note_id
LEFT JOIN tags t ON nt.tag_id = t.id
WHERE n.id IN (
    SELECT nt1.note_id
    FROM note_tags nt1
    JOIN tags t1 ON nt1.tag_id = t1.id
    WHERE t1.name = 'work'
INTERSECT
    SELECT nt2.note_id
    FROM note_tags nt2
    JOIN tags t2 ON nt2.tag_id = t2.id
    WHERE t2.name = 'urgent'
)
GROUP BY n.id, n.title, n.content
