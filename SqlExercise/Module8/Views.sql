SELECT * FROM sys.views;

SELECT * FROM sys.tables;

SELECT * FROM sys.objects

SELECT * FROM sys.objects WHERE type_desc = 'VIEW';

SELECT * FROM INFORMATION_SCHEMA.TABLES;

SELECT * FROM sys.dm_exec_connections;

SELECT * FROM sys.dm_exec_sessions;

SELECT * FROM sys.dm_exec_requests;

SELECT * FROM sys.dm_exec_query_stats;

SELECT TOP (20) qs.max_logical_reads,st.text  FROM sys.dm_exec_query_stats AS qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS st ORDER BY qs.max_logical_reads DESC;
