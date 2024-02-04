/* 3.a.
UPDATE laptops
SET Ram = REPLACE(Ram,'GB',''),
	Weight = REPLACE(Weight, 'kg', '');
    
ALTER TABLE laptops
MODIFY COLUMN Ram INTEGER,
MODIFY COLUMN Weight DECIMAL(10, 2);
*/
/* 3.b.
ALTER TABLE laptops
ADD COLUMN gpu_brand VARCHAR(255) AFTER Gpu,
ADD COLUMN gpu_name VARCHAR(255) AFTER gpu_brand;

UPDATE laptops
SET gpu_brand = SUBSTRING_INDEX(Gpu,' ',1),
	gpu_name = 	REPLACE(Gpu,gpu_brand,'');
    
ALTER TABLE laptops DROP COLUMN Gpu
*/
/* 3.c.
SELECT * FROM campusx.laptops;
ALTER TABLE laptops
ADD COLUMN cpu_brand VARCHAR(255) AFTER Cpu,
ADD COLUMN cpu_name VARCHAR(255) AFTER cpu_brand,
ADD COLUMN cpu_speed DECIMAL(10,2) AFTER cpu_name;

-- first we will update the cpu_brand and cpu_speed
UPDATE laptops
SET cpu_brand = SUBSTRING_INDEX(Cpu, " ", 1),
	cpu_speed = CAST(REPLACE(SUBSTRING_INDEX(Cpu, " " , -1), "GHz", "") AS DECIMAL(10,2));
    
-- after that we will update cpu_name
UPDATE laptops
SET cpu_name = REPLACE(REPLACE(Cpu, cpu_brand, ""), SUBSTRING_INDEX(Cpu, " " , -1), "")

ALTER TABLE laptops DROP COLUMN Cpu
*/
/* 3.d.
ALTER TABLE laptops
ADD COLUMN resolution_width INTEGER AFTER ScreenResolution,
ADD COLUMN resolution_height INTEGER AFTER resolution_width,
ADD COLUMN touchscreen INTEGER AFTER resolution_height;

UPDATE laptops 
SET resolution_width = substring_index(substring_index(ScreenResolution, " ", -1),"x", 1),
	resolution_height = substring_index(substring_index(ScreenResolution, " ", -1),"x", -1),
	touchscreen = ScreenResolution LIKE '%Touchscreen%';

ALTER TABLE laptops DROP COLUMN ScreenResolution;
*/
/* 3.e.
ALTER TABLE laptops
ADD COLUMN memory_type VARCHAR(255) AFTER Memory,
ADD COLUMN primary_storage INTEGER AFTER memory_type,
ADD COLUMN secondary_storage INTEGER AFTER primary_storage;

UPDATE laptops
SET memory_type = CASE
	WHEN Memory LIKE '%+%' THEN 'Hybrid'
    WHEN Memory LIKE '%SSD%' THEN 'SSD'
    WHEN Memory LIKE '%HDD%' THEN 'HDD'
    WHEN Memory LIKE '%Flash Storage%' THEN 'Flash Storage'
    WHEN Memory LIKE '%Hybrid%' THEN 'Hybrid'
    ELSE NULL
END;

UPDATE laptops
SET primary_storage = REGEXP_SUBSTR(SUBSTRING_INDEX(Memory,'+',1),'[0-9]+'),
secondary_storage =
CASE 
	WHEN Memory LIKE '%+%' THEN REGEXP_SUBSTR(SUBSTRING_INDEX(Memory,'+',-1),'[0-9]+') 
    ELSE 0 
END;

UPDATE laptops
SET primary_storage = 
CASE 
	WHEN primary_storage <= 2 THEN primary_storage*1024 
    ELSE primary_storage 
END,
secondary_storage = 
CASE 
	WHEN secondary_storage <= 2 THEN secondary_storage*1024 
    ELSE secondary_storage 
END;

ALTER TABLE laptops DROP Memory
*/





	



    
