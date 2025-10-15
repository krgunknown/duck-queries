SELECT
    id,
    title,
    rapidfuzz_token_set_ratio(title, 'duckdb analytics') AS similarity
FROM articles
WHERE rapidfuzz_token_set_ratio(title, 'duckdb analytics') > 60
ORDER BY similarity DESC;
