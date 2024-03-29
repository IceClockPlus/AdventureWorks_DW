DECLARE @StartDate DATE = '20110101', @NumberOfYears INT = 10;

-- prevent set or regional settings from interfering with 
-- interpretation of dates / literals

SET DATEFIRST 1;
SET DATEFORMAT dmy;
SET LANGUAGE Español;

DECLARE @CutoffDate DATE = DATEADD(YEAR, @NumberOfYears, @StartDate);

INSERT dbo.Dim_Tiempo(Fecha) 
SELECT d
FROM
(
  SELECT d = DATEADD(DAY, rn - 1, @StartDate)
  FROM 
  (
    SELECT TOP (DATEDIFF(DAY, @StartDate, @CutoffDate)) 
      rn = ROW_NUMBER() OVER (ORDER BY s1.[object_id])
    FROM sys.all_objects AS s1
    CROSS JOIN sys.all_objects AS s2
    -- on my system this would support > 5 million days
    ORDER BY s1.[object_id]
  ) AS x
) AS y;

