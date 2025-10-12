SELECT n.title, n.content, GROUP_CONCAT(t.name, ', ') AS tags
FROM notes n
LEFT JOIN note_tags nt ON n.id = nt.note_id
LEFT JOIN tags t ON nt.tag_id = t.id
WHERE t.name = 'work'
GROUP BY n.id, n.title, n.content
