-- returns the listed select columns for max NOx value in 2020
SELECT `measurement`.`NOx`, `measurement`.`DateTime` AS 'Date/Time', `site`.`SiteName` AS 'Site'
FROM `measurement`

	-- use left join to not exclude any data readings
	LEFT JOIN `site` ON `measurement`.`SiteID` = `site`.`SiteID`
    
-- nested where clause for filtering year and finidng max NOx value
WHERE `measurement`.`NOx` = (SELECT MAX(`measurement`.`NOx`) 
                             FROM `measurement` 
                             WHERE  YEAR(`measurement`.`DateTime`) = '2020');