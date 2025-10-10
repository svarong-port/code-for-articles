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


# Datset from
# URL: https://www.kaggle.com/datasets/meetnagadia/amazon-kindle-book-review-for-sentiment-analysis?resource=download&select=all_kindle_review+.csv
# Downloaded: 09 Oct 2025


# Load the dataset
reviews <- read_csv("all_kindle_review.csv",
                    col_select = c(rating, reviewText))

# View the result
head(reviews)


# Tokenise words
reviews_tokenised <- reviews |> 
  
  # Unnest
  unnest_tokens(
    
    # Set output
    output = "word",
    
    # Set input
    input = "reviewText"
  )

# View the result
head(reviews_tokenised)


# Remove stop words

# Load `stop_words`
data(stop_words)

# Remove stop words from reviews
reviews_no_stopwords <- reviews_tokenised |>
  
  # Anti join with `stop_words`
  anti_join(stop_words)

# View the result
head(reviews_no_stopwords)


# Create word cloud
reviews_freq <- reviews_no_stopwords |>
  
  # Count words
  count(word) |>
  
  # Sort descending
  arrange(desc(n))

# View the result
head(reviews_freq)


# Create word cloud
wordcloud(
  
  # Set words
  words = reviews_freq$word, 
  
  # Set frequency
  freq = reviews_freq$n,
  
  # Set minimum frequency
  min.freq = 400
)


# Get sentiments
reviews_sentiments <- reviews_no_stopwords |>
  
  # Inner join with sentiment dictionary
  inner_join(get_sentiments("afinn"))

# View the result
head(reviews_sentiments)


# Summarise sentiment by rating
reviews_sentiments |>
  
  # Group by rating
  group_by(rating) |>
  
  # Compute overall sentiment
  summarise(mean_sentiment = mean(value)) |>
  
  # Visualise the result
  ggplot(aes(
    x = factor(rating),
    y = mean_sentiment,
    fill = factor(rating)
  )
  ) +
  
  # Set geom
  geom_col(show.legend = FALSE) +
  
  # Flip axes
  coord_flip() +
  
  # Set theme
  theme_minimal() +
  
  # Add labels
  labs(
    title = "Sentiment by Product Rating",
    x = "Rating",
    y = "Average Sentiment"
  )


# Find top 20 positive words
reviews_sentiments |>
  
  # Group by word
  group_by(word) |>
  
  # Find mean sentiment
  summarise(mean_sentiment = mean(value)) |>
  
  # Get top 20 words
  slice_max(mean_sentiment, n = 20, with_ties = FALSE) |>
  
  # Visualise the result
  ggplot(aes(
    x = fct_reorder(word, mean_sentiment),
    y = mean_sentiment,
    fill = word
  )
  ) +
  
  # Set geom
  geom_col(show.legend = FALSE) +
  
  # Flip axes
  coord_flip() +
  
  # Set theme
  theme_minimal() +
  
  # Add labels
  labs(
    title = "Top 20 Positive Words",
    x = "Word",
    y = "Average Sentiment"
  )


# Find top 20 negative words
reviews_sentiments |>
  
  # Group by word
  group_by(word) |>
  
  # Find mean sentiment
  summarise(mean_sentiment = mean(value)) |>
  
  # Get top 20 words
  slice_min(mean_sentiment, n = 20, with_ties = FALSE) |>
  
  # Visualise the result
  ggplot(aes(
    x = fct_reorder(word, mean_sentiment),
    y = mean_sentiment,
    fill = word
  )
  ) +
  
  # Set geom
  geom_col(show.legend = FALSE) +
  
  # Flip axes
  coord_flip() +
  
  # Set theme
  theme_minimal() +
  
  # Add labels
  labs(
    title = "Top 20 Positive Words",
    x = "Word",
    y = "Average Sentiment"
  )