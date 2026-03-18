# Embedding With Gemini

# References:
# - Gemini Embedding: https://ai.google.dev/gemini-api/docs/embeddings
# - Gemini token counts: https://ai.google.dev/gemini-api/docs/tokens
# - How to Calculate Cosine Similarity in Python?: https://www.geeksforgeeks.org/python/how-to-calculate-cosine-similarity-in-python/
# - News Category Dataset (HuffPost News Articles): https://www.kaggle.com/datasets/zubairdhuddi/news-category-dataset

# --------------------------------------------------------

# Import packages to get API key
from pathlib import Path
from dotenv import load_dotenv
import os

# Get .env file path
PROJECT_ROOT = Path.cwd().parents[2]
env_path = PROJECT_ROOT / ".env"

# Load variables from .env
load_dotenv(env_path, override=True)

# Get Gemini API key
gemini_api_key = os.getenv("GEMINI_API_KEY_01")

# --------------------------------------------------------

# Import packages for embedding
from google import genai

# Create client
client = genai.Client(api_key=gemini_api_key)

# Define embedding model
embedding_model = "gemini-embedding-001"

# Define content to embed
prompt = "What is the Pareto Principle?"

# Check tokens used for embedding
total_tokens = client.models.count_tokens(
    model=embedding_model,
    contents=prompt
)

# Print total tokens used for embedding
print(f"👉 Total tokens used for embedding: \n{total_tokens}")

# Get embedding for a query
embedding_response = client.models.embed_content(
    model=embedding_model,
    contents=prompt
)

# Print embedding response
print(f"👉 Embedding response:\n{embedding_response}")

# Print embedding vector
print(f"👉 Embedding vector:\n{embedding_response.embeddings}")

# --------------------------------------------------------

