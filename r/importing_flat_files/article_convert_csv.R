# Code to convert CSV to TSV, TXT

# Load CSV
nutrition_csv <- read.csv("Nutrition_Value_Dataset.csv")

# Write CSV to TSV
write.table(nutrition_csv,
            "Nutrition_Value_Dataset.tsv",
            sep = "\t", 
            row.names = FALSE,
            quote = TRUE)


# Write CSV to TXT with "/" as separator
write.table(nutrition_csv,
            "Nutrition_Value_Dataset.txt",
            sep = "/", 
            row.names = FALSE,
            quote = TRUE)