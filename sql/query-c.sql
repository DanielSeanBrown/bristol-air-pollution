-- returns averages for all measurements taken by the detectors during rush hour
SELECT `site`.`SiteName` AS 'Site',
	AVG(`measurement`.`NOx`) AS 'NOx', AVG(`measurement`.`NO2`) AS 'NO2', AVG(`measurement`.`NO`) AS 'NO',
	AVG(`measurement`.`PM10`) AS 'PM10', AVG(`measurement`.`O3`) AS 'O3', AVG(`measurement`.`Temperature`) AS 'Temperature',
        AVG(`measurement`.`NVPM10`) AS 'NVPM10', AVG(`measurement`.`VPM10`) AS 'VPM10', AVG(`measurement`.`NVPM2.5`) AS 'NVPM2.5',
        AVG(`measurement`.`PM2.5`) AS 'PM2.5', AVG(`measurement`.`VPM2.5`) AS 'VPM2.5', AVG(`measurement`.`CO`) AS 'CO',
        AVG(`measurement`.`RH`) AS 'RH', AVG(`measurement`.`Pressure`) AS 'Pressure', AVG(`measurement`.`SO2`)  AS 'SO2'
FROM `measurement`

	-- use left join to not exclude any data readings
	LEFT JOIN `site` ON `measurement`.`SiteID` = `site`.`SiteID`

-- where and groupby clause used to filter values to rush hour and present averages by site
WHERE HOUR(`measurement`.`DateTime`) BETWEEN 7 AND 9
GROUP BY `site`.`SiteName`
