import pandas as pd
import os
from IPython.display import display

#Defining file paths
data_path = "Data/Raw"

confirmed_file = os.path.join(data_path, "time_series_covid19_confirmed_global copy.csv")
death_file = os.path.join(data_path, "time_series_covid19_deaths_global copy.csv")

confirmed_df = pd.read_csv(confirmed_file)
deaths_df = pd.read_csv(death_file)


#Creating a function to convert datasets from column format to long format
def transform_data_long(df, value_name):
    df = df.melt(id_vars=["Province/State", "Country/Region", "Lat", "Long"],
                 var_name="Date", value_name=value_name)
    df["Date"] = pd.to_datetime(df["Date"])  # Convert date column
    return df


#Transforming datasets using function created
confirmed_df_long = transform_data_long(confirmed_df, "Confirmed")
deaths_df_long = transform_data_long(deaths_df, "Death")


#Merging Datasets
covid_data = confirmed_df_long.merge(deaths_df_long, on=["Province/State", "Country/Region", "Lat", "Long", "Date"])


# Save cleaned data
processed_path = "Data/Processed"
os.makedirs(processed_path, exist_ok=True)
covid_data.to_csv(os.path.join(processed_path, "COVID-19-data.csv"), index=False)



#Display processed data
processed_file = os.path.join(processed_path, "COVID-19-data.csv")
print(processed_file)

processed_df = pd.read_csv(processed_file)
 
display(processed_df)