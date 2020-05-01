import pandas as pd
import os

# setting working directory
directory = "C:\\Users\\15072\\Desktop\\Portfolio\\Senece Park Zoo\\Final Submissions"
os.chdir(directory)

# reading the files
file2014 = pd.read_csv("DataRecord_2_DLC_Animal_List_06Jun14.csv")
file2019 = pd.read_csv("DataRecord_2_DLC_Animal_List_05Feb2019.csv", encoding= 'unicode_escape')

# final result needed
columnNames = ["ID", "DLC_ID", "UpdateDate", "UpdateYear", "Taxon", "Hybrid",
                               "Sex", "DOB", "BirthMonth", "BirthType", "EstimatedConcep", 
                                "ConcepMonth", "Dead", "AgeAtDeath", "AgeOfLiving", 
                                "AgeMax_LiveOrDead","NumKnownOffspring", "DamID", "DamTaxon",
                                "SireID", "SireTaxon"]

clean2014 = pd.DataFrame(columns = columnNames)
clean2019 = pd.DataFrame(columns = columnNames)

orgFiles = [file2014,file2019]
cleanfiles = [clean2014, clean2019]
dates = ['06/06/2014', '05/02/2019']

## Data Cleaning Process
num = 0 # stepper to move through orgFiles
length = 0 # to maintain the sequence of "ID" column
for file in cleanfiles:
    file["DLC_ID"] = orgFiles[num]["DLC_ID"]
    file["UpdateDate"] = pd.to_datetime(dates[num]).strftime('%d/%m/%Y')
    file["UpdateYear"] = 2014
    file["Taxon"] = orgFiles[num]["Taxon"]
    file["Hybrid"] = orgFiles[num]["Hybrid"]
    file["Sex"] = orgFiles[num]["Sex"]
    file["DOB"] = orgFiles[num]["DOB"]
    file["BirthMonth"] = orgFiles[num]["Birth_Month"]
    file["BirthType"] = orgFiles[num]["Birth_Type"]
    file["EstimatedConcep"] = orgFiles[num]["Estimated_Concep"]
    file["ConcepMonth"] = orgFiles[num]["Concep_Month"]
    file["Dead"] = orgFiles[num]["AgeOfLiving_y"].isna()
    file["AgeAtDeath"] = orgFiles[num]["AgeAtDeath_y"]
    file["AgeOfLiving"] = orgFiles[num]["AgeOfLiving_y"]
    file["AgeMax_LiveOrDead"] = orgFiles[num]["AgeMax_LiveOrDead_y"]
    file["NumKnownOffspring"] = orgFiles[num]["N_known_offspring"]
    file["DamID"] = orgFiles[num]["Dam_ID"]
    file["DamTaxon"] = orgFiles[num]["Dam_Taxon"]
    file["SireID"] = orgFiles[num]["Sire_ID"]
    file["SireTaxon"] = orgFiles[num]["Sire_Taxon"]
    file["ID"] = range(length,length+len(file),1)
    length = length + len(file)
    num = num + 1

final = pd.concat(cleanfiles, axis=0)
final.to_csv("final.csv")