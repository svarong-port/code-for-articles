# Working With Data Frames in R


# 1. Creating
friends_df <- data.frame(
  Name = c("Alice", "Ben", "Chloe", "David", "Ella",
           "Frank", "Grace", "Hugo", "Ivy", "Jack"),
  Age = c(25, 27, 24, 26, 28,
          29, 23, 30, 25, 27),
  City = c("Bangkok", "Chiang Mai", "Bangkok", "Phuket", "Chiang Mai",
           "Bangkok", "Phuket", "Bangkok", "Chiang Mai", "Phuket"),
  Coffee = c(450, 300, 600, 200, 500,
             550, 150, 400, 480, 250),
  Food = c(2500, 1800, 2700, 2200, 2400,
           2600, 1900, 3100, 2300, 2000),
  Entertainment = c(800, 1200, 500, 1000, 700,
                    900, 400, 1500, 600, 950)
)

friends_df


# 2. Previewing

# 2.1 head()
head(friends_df)

# 2.2 tail()
tail(friends_df)

# 2.3 summary()
summary(friends_df)

# 2.4 str()
str(friends_df)

# 2.5 dim()
dim(friends_df)

# 2.6 nrow()
nrow(friends_df)

# 2.7 ncol()
ncol(friends_df)



# 3. Indexing

# 3.1 $
friends_df$Name

# 3.2 [[]]
friends_df[["Name"]]



# 4. Subsetting

# 4.1 df[rows, cols]
friends_df[1:3, c("Name", "City")]

# 4.2 subset()
subset(friends_df[1:3, ], select = c("Name", "City"))



# 5. Filtering

# 5.1 df[rows, cols]
friends_df[friends_df$City == "Bangkok", ]

friends_df[friends_df$City == "Bangkok" & friends_df$Food > 2500, ]

# 5.2 subset()
subset(friends_df, City == "Bangkok")

subset(friends_df, City == "Bangkok" & friends_df$Food > 2500)



# 6. Sorting

# 6.1 Ascending
friends_df[order(friends_df$Age), ]

# 6.2 Descending
friends_df[order(friends_df$Age, decreasing = TRUE), ]

friends_df[order(-friends_df$Age), ]



# 7. Aggregating
mean(friends_df$Entertainment)



# 8. Adding columns
friends_df["Total"] <- friends_df$Coffee + friends_df$Food + friends_df$Entertainment



# 9. Removing columns
friends_df["Total"] <- NULL



# 10. Binding

# 10.1 rbind()
new_friend <- data.frame(
  Name = "Ken",
  Age = 29,
  City = "Bangkok",
  Coffee = 550,
  Food = 2600,
  Entertainment = 900
)

friends_df <- rbind(friends_df, new_friend)

# 10.2 cbind()
friends_df <- cbind(friends_df,
                    DrinksAlcohol = c(TRUE, TRUE, FALSE, FALSE, TRUE,
                                      TRUE, FALSE, FALSE, TRUE, TRUE, TRUE))

friends_df