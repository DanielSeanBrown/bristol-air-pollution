import pandas as pd

df = pd.read_csv('Air_Quality_Continuous.csv')
df_cropped = df[(df['Date_Time'] < '2023/10/23 00:00:00+00') & (df['Date_Time'] >= '2015/01/01 00:00:00+00')]
df_cropped.to_csv('cropped.zip', compression={'method': 'zip', 'archive_name': 'cropped.csv'})