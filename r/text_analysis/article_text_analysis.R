# Text Analysis in R


# Install packages
install.packages("tidyverse") # for data manipulation and viz
install.packages("tidytext") # for text analysis
install.packages("textdata") # for sentiment dict
install.packages("wordcloud") # for word cloud

# Load pacakages
library(tidyverse)
library(tidytext)
library(textdata)
library(wordcloud)


# Load the dataset
reviews <- read_csv("all_kindle_review.csv", # from: https://www.kaggle.com/datasets/meetnagadia/amazon-kindle-book-review-for-sentiment-analysis?resource=download&select=all_kindle_review+.csv
                    col_select = reviewText) # Load only `reviewText` column

# Preview the dataset
head(reviews)


# Tokenise words
reviews_unnested <- reviews |> 
  
  # Unnest
  unnest_tokens(
    
    # Set output
    output = "word",
    
    # Set input
    input = "reviewText"
  )


# Remove stop words

# Load `stop_words`
data(stop_words)

# Remove stop words from reviews
reviews_no_stopwords <- reviews_unnested |>
  
  # Anti join with `stop_words`
  anti_join(stop_words)


# Create word cloud
reviews_freq <- reviews_no_stopwords |>
  
  # Count words
  count(word) |>
  
  # Sort descending
  arrange(desc(n))


# Create word cloud
wordcloud(
  
  # Set words
  words = reviews_freq$word, 
  
  # Set frequency
  freq = reviews_freq$n,
  
  # Set minimum frequency
  min.freq = 500
)


# Get sentiments
reviews_sentiments <- reviews_no_stopwords |>
  
  # Inner join with sentiment dictionary
  inner_join(get_sentiments("bing"))

# View the result
head(reviews_sentiments)


# Count words by sentiment
reviews_counts <- reviews_sentiments |>
  
  # Count by words and sentiment
  count(word, sentiment)

# View the result
head(reviews_counts)


# Pivot wider
reviews_wider <- reviews_counts |>
  
  # Pivot
  pivot_wider(
    names_from = sentiment,
    values_from = n
  )

# View the result
head(reviews_wider)


# Replace NA
reviews_no_na <- reviews_wider |>
  
  # Replace NA
  replace_na(list(negative = 0, 
                  positive = 0))


# Compute overall sentiment
reviews_no_na |> 
  
  # Compute overall sentiment
  mutate(overall_sentiment = positive - negative) |>
  
  # Get top 20
  slice_max(overall_sentiment, n = 20) |>
  
  # Visualise
  ggplot(aes(x = fct_reorder(word, overall_sentiment),
             y = overall_sentiment,
             fill = word)
  ) +
  
  # Set bar plot
  geom_col(show.legend = FALSE) +
  
  # Flip axis
  coord_flip() +
  
  # Set theme as minimal
  theme_minimal() +
  
  # Add labels
  labs(
    title = "Top 20 Sentiment Words",
    x = "Words",
    y = "Overall Sentiment"
  )