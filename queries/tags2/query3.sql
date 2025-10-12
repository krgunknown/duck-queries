SELECT n.title, n.content, n.priority, GROUP_CONCAT(t.name, ', ') AS tags
FROM notes n
JOIN note_tags nt ON n.id = nt.note_id
JOIN tags t ON nt.tag_id = t.id
WHERE t.name IN $tagNames
GROUP BY n.id, n.title, n.content, n.priority, n.created_at
HAVING COUNT(DISTINCT t.name) = $tagCount
ORDER BY n.priority DESC, n.created_at DESC
