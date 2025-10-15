SELECT *
FROM my_vector_table
ORDER BY array_distance(vec, [4, 2, 0]::FLOAT[3])
LIMIT 3;
