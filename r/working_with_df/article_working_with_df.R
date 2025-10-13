# Working With Data Frames in R


# 1. Creating a data frame
jjk_df <- data.frame(
  ID = 1:10,
  Name = c("Yuji Itadori", "Megumi Fushiguro", "Nobara Kugisaki", "Satoru Gojo",
           "Maki Zenin", "Toge Inumaki", "Panda", "Kento Nanami", "Yuta Okkotsu", "Suguru Geto"),
  Age = c(15, 16, 16, 28, 17, 17, 18, 27, 17, 27),
  Grade = c("1st Year", "1st Year", "1st Year", "Special", "2nd Year",
            "2nd Year", "2nd Year", "Special", "Special", "Special"),
  CursedEnergy = c(80, 95, 70, 999, 60, 85, 75, 200, 300, 400),
  Technique = c("Divergent Fist", "Ten Shadows", "Straw Doll", "Limitless",
                "Heavenly Restriction", "Cursed Speech", "Gorilla Mode",
                "Ratio Technique", "Rika", "Cursed Spirit Manipulation"),
  Missions = c(25, 30, 20, 120, 35, 28, 40, 90, 55, 80)
)

jjk_df

View(jjk_df)


# -----------------------------------------------------------------


# 2. Previewing

# 2.1 head()
head(jjk_df)

# 2.2 tail()
tail(jjk_df)

# 2.3 str()
str(jjk_df)

# 2.4 summary()
summary(jjk_df)

# 2.5 dim()
dim(jjk_df)

# 2.6 nrow()
nrow(jjk_df)

# 2.7 ncol()
ncol(jjk_df)


# -----------------------------------------------------------------


# 3. Indexing

# 3.1 $
jjk_df$Name

# 3.2 [[]]
jjk_df[["Name"]]


# -----------------------------------------------------------------


# 4. Subsetting

# 4.1 df[rows, cols]
jjk_df[1:5, ]

jjk_df[, "Name"]

jjk_df[1:5, c("Name", "Technique")]

# 4.2 subset()
subset(jjk_df, select = c("Name", "Technique"))

subset(jjk_df[1:5, ], select = c("Name", "Technique"))


# -----------------------------------------------------------------


# 5. Filtering

# 5.1 df[rows, cols]
jjk_df[jjk_df$Grade == "1st Year", ]

jjk_df[jjk_df$Grade == "1st Year" & jjk_df$Age == 15, ]

# 5.2 subset()
subset(jjk_df, Grade == "1st Year")

subset(jjk_df, Grade == "1st Year" & Age == 15)


# -----------------------------------------------------------------


# 6. Sorting

# 6.1 Ascending
jjk_df[order(jjk_df$Missions), ]

# 6.2 Descending
jjk_df[order(jjk_df$Missions, decreasing = TRUE), ]

jjk_df[order(-jjk_df$Missions), ]


# -----------------------------------------------------------------


# 7. Aggregating
mean(jjk_df$CursedEnergy)


# -----------------------------------------------------------------


# 8. Adding columns
jjk_df$Ranking <- ifelse(jjk_df$CursedEnergy > 100, "High", "Low")

jjk_df


# -----------------------------------------------------------------


# 9. Removing columns
jjk_df$Ranking <- NULL

jjk_df


# -----------------------------------------------------------------


# 10. Binding

# 10.1 rbind()
new_sorcerer <- data.frame(
  ID = 11,
  Name = "Hajime Kashimo",
  Age = 25,
  Grade = "Special",
  CursedEnergy = 500,
  Technique = "Lightning",
  Missions = 60
)

jjk_df <- rbind(jjk_df, new_sorcerer)

jjk_df

# 10.2 cbind()
jjk_df <- cbind(
  jjk_df,
  IsTeacher = c(FALSE, FALSE, FALSE, TRUE, FALSE,
                FALSE, FALSE, TRUE, FALSE, TRUE, TRUE)
)

jjk_df