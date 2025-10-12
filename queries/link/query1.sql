
SELECT
    n1.title AS source_note,
    GROUP_CONCAT(n2.title, ', ') AS linked_notes
FROM notes n1
LEFT JOIN links l ON n1.id = l.from_note
LEFT JOIN notes n2 ON l.to_note = n2.id
GROUP BY n1.id, n1.title
ORDER BY n1.id;
