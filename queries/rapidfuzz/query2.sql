WITH scored AS (
    SELECT
        id,
        title,
        content,
        rapidfuzz_token_set_ratio(title, 'duckdb analytics') AS title_score,
        rapidfuzz_partial_ratio(content, 'duckdb analytics') AS content_score
    FROM articles
)
SELECT
    id,
    title,
    content,
    title_score,
    content_score,
    (0.7 * title_score + 0.3 * content_score) AS final_score
FROM scored
WHERE (0.7 * title_score + 0.3 * content_score) > 60
ORDER BY final_score DESC;
