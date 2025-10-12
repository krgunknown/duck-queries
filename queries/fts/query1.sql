-- 5. Perform a full-text search using MATCH_BM25
SELECT
    fts_main_articles.match_bm25(id, 'DuckDB') AS score,
    title,
    content
FROM articles
WHERE score IS NOT NULL
ORDER BY score DESC;

-- 6. You can also search for phrases or use operators (e.g., AND, OR)
-- SELECT
--     fts_main_articles.match_bm25(id, 'data AND analytics') AS score,
--     title,
--     content
-- FROM articles
-- WHERE score IS NOT NULL
-- ORDER BY score DESC;
