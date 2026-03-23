-- returns the average values for the slected columns by site during rush hour in 2022
SELECT  `site`.`SiteName` AS 'Site', AVG(`measurement`.`PM2.5`) AS 'PM2.5', AVG(`measurement`.`VPM2.5`) AS 'VPM2.5'
FROM `measurement` 

	-- use left join to not exclude any data readings
	LEFT JOIN `site` ON `measurement`.`SiteID` = `site`.`SiteID`

-- where and groupby clause used to filter values to rush hour and present averages by site
WHERE HOUR(`measurement`.`DateTime`) BETWEEN 7 AND 9 AND YEAR(`measurement`.`DateTime`) = '2022'
GROUP BY `site`.`SiteName`