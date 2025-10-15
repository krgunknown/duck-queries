SELECT id, content, array_cosine_similarity(embedding, $embedding) AS similarity
FROM notes
ORDER BY similarity DESC
LIMIT 10;
