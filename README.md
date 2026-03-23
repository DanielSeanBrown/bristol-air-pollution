# Bristol Air Pollution 
This repository holds part of my assessment for my data management module on my Data Science MSc.
The task saw me design, populate and query a relational database using data gathered by 19 air quality monitoring stations based throughout the city of Bristol, UK.

## Database Design
Conceptual, logical, and physical data models were developed before forward-engineering a MySQL schema to a PHPMyAdmin server hosted via Laragon. The respective ER diagram can be seen in the relational-database folder.

## Database Population and Cleaning
The raw CSV file of data points was cropped down to only include the last three years of data, reducing from 1.6M records to 500k.

## Data Queries
Sample SQL queries were produced with their outputs recorded, in accordance with the assessment questions.

## NoSQL Implementation
As part of the assessment’s extension, an alternative NoSQL implementation was also produced. MongoDB was used for storing records in a JSON format and basic aggregation pipelines were built.

## Documentation
All scripts used for the project are available in the repository as well as a report on the NoSQL implementation and a reflective report over the whole project.

