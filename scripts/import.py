import pymysql
import pandas as pd


#setup enviornment to interact with our database through SQL
db = pymysql.connect(host='localhost', user='root',passwd='', database = 'pollution')
cursor = db.cursor()
query = ("USE pollution")
cursor.execute(query)


#define column headers and table values for inserting data into the smaller tables
constituencyColumns = ['ConstituencyName', 'MPName']
sitelocationColumns = ['Latitude','Longitude','ConstituencyName']
siteColumns = ['SiteID','SiteName','Latitude','Longitude']
measurementColumns = ['MeasurementID','DateTime','SiteID','NOx','NO2','NO','PM10','O3','Temperature','ObjectID','ObjectID2','NVPM10','VPM10','NVPM2.5','PM2.5','VPM2.5','CO','RH','Pressure','SO2'] 

constituencyValues = [('Bristol East','Kerry McCarthy'), ('Bristol Northwest','Darren Jones'), ('Bristol South', 'Karin Smyth'), ('Bristol West', 'Thangam Debbonaire')]
sitelocationValues = [(51.4572041156, -2.58564914143, 'Bristol West'),(51.4417471802,-2.55995583224, 'Bristol East'),(51.4554331987,-2.59626237324, 'Bristol West'),(51.4752847609,-2.56207998299, 'Bristol East'),(51.4560189999,-2.58348949026, 'Bristol West'),(51.4326757070,-2.60495665673, 'Bristol South'),(51.4488837041,-2.58447776241, 'Bristol West'),(51.4278638883,-2.56374153315, 'Bristol South'),(51.4899934596,-2.68877856929, 'Bristol Northwest'),(51.4606738207,-2.58225341824, 'Bristol West'),(51.4577930324,-2.56271419977, 'Bristol East'),(51.4628294172,-2.58454081635, 'Bristol West'),(51.4425372726,-2.57137536073, 'Bristol East'),(51.4689385901,-2.59272416670, 'Bristol West'),(51.4780449714,-2.53523027459, 'Bristol East'),(51.4472134170,-2.62247405516, 'Bristol West'),(51.4579497132 ,-2.5839890903, 'Bristol West'),(51.4552693827,-2.59664882855, 'Bristol West'),(51.4591419717,-2.59543271836, 'Bristol West')]
siteValues = [(188, 'AURN Bristol Centre', 51.4572041156,-2.58564914143),(203, 'Brislington Depot', 51.4417471802,-2.55995583224),(206, 'Rupert Street', 51.4554331987,-2.59626237324),(209, 'IKEA M32', 51.4752847609,-2.56207998299),(213, 'Old Market', 51.4560189999,-2.58348949026),(215, 'Parson Street School', 51.432675707,-2.60495665673),(228, 'Temple Meads Station', 51.4488837041,-2.58447776241),(270, 'Wells Road', 51.4278638883,-2.56374153315),(271, 'Trailer Portway P&R', 51.4899934596,-2.68877856929),(375, 'Newfoundland Road Police Station', 51.4606738207,-2.58225341824),(395, "Shiner's Garage", 51.4577930324,-2.56271419977),(452, 'AURN St Pauls', 51.4628294172,-2.58454081635),(447, 'Bath Road', 51.4425372726,-2.57137536073),(459, 'Cheltenham Road \ Station Road', 51.4689385901,-2.5927241667),(463, 'Fishponds Road', 51.4780449714,-2.53523027459),(481, 'CREATE Centre Roof', 51.447213417,-2.62247405516),(500, 'Temple Way', 51.4579497132 ,-2.5839890903),(501, 'Colston Avenue', 51.4552693827,-2.59664882855),(672, 'Marlborough Street', 51.4591419717,-2.59543271836)]


#the function with which the SQL commands are going to be constructed and executed
def insertValues(tablename, columns, values):
    
    '''Takes a table name, a list of column headers and values to insert into 
    the respective table. Note that this function is not suitable for inserting
    individual records.'''
    
    if any(any(item == 'NULL' for item in row) for row in values):
        for row in values:
            inputString = ''
            for item in row:
                if item!='NULL':
                    inputString += "'"+item+"'" +','
                else:
                    inputString += item +','
            try:
                columnsString = '(`'+'`,`'.join(columns) + '`)'
                cursor.execute(f'''INSERT INTO `{tablename}` {columnsString} VALUES ({inputString[:-1]});''')
                db.commit()
            except Exception as errorMessage: 
                print('There has been an error:', errorMessage)                
    else:
        valuesString = '(' + '%s,' * (len(columns)-1) + '%s)'
        columnsString = '(`'+'`,`'.join(columns) + '`)'
        try:
            create_users = f"""
            INSERT INTO
              `{tablename}` {columnsString}
            VALUES
              {valuesString};
            """
            cursor.executemany(create_users, values)
            db.commit()
            
        except Exception as errorMessage: 
            print('There has been an error:', errorMessage)


#insert values into 3 of the 4 tables, the order here is important because of foreign key constraints
insertValues('constituency',constituencyColumns,constituencyValues)
insertValues('sitelocation',sitelocationColumns,sitelocationValues)
insertValues('site',siteColumns,siteValues)


#load cropped data, format for insertion and then load into table
measurementsDataFrame = pd.read_csv('cropped.zip',compression='zip')
measurementsDataFrame = measurementsDataFrame.fillna('NULL')
measurementsDataFrame['Date_Time'] = pd.to_datetime(measurementsDataFrame['Date_Time']).dt.strftime('%Y-%m-%d %H:%M:%S')

#the imported data file is used to build an array here for insertion with the function
measurementValues = []
for count in range(len(measurementsDataFrame)):
    rowRaw = list(measurementsDataFrame.iloc[count])
    rowRaw[0] = count+1
    rowValue = []
    for item in rowRaw:
        rowValue.append(str(item))
    measurementValues.append(tuple(rowValue))


#note that this is a big load statement and may take some time to complete
insertValues('measurement',measurementColumns,measurementValues)
