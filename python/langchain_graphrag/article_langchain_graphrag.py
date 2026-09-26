# Import the package
import pandas as pd

# Load the documents
df = pd.read_csv("test-set-12-articles.csv")
# Download from:
# https://www.kaggle.com/datasets/timilsinabimal/newsarticlecategories?utm_source=chatgpt.com

# Preview the first 5 articles
df.head()


# Import the package
from langchain_core.documents import Document

# Create a Document object
documents = [
    Document(
        page_content=row["body"],
        metadata={
            "title": row["title"],
            "category": row["category"]
        }
    )
    for _, row in df.iterrows()
]

# Print the number of documents loaded
print(f"Loaded {len(documents)} documents")

# Import the packages
from langchain_ollama import ChatOllama
from langchain_experimental.graph_transformers import LLMGraphTransformer

# Create an LLM for information extraction
llm = ChatOllama(
    model="gemma4:12b",
    temperature=0
)

# Create a graph transformer
graph_transformer = LLMGraphTransformer(
    llm=llm
)

# Convert documents into graph documents
graph_documents = graph_transformer.convert_to_graph_documents(
    documents
)

# Print the number of graph documents created
print(f"Created {len(graph_documents)} graph documents")


# Import the packages
from pathlib import Path
from dotenv import load_dotenv
import os

# Get the .env file path
PROJECT_ROOT = Path.cwd().parents[2]
env_path = PROJECT_ROOT / ".env"

# Load variables from .env
load_dotenv(env_path, override=True)

# Get Neo4j URI
NEO4J_URI = os.getenv("NEO4J_AURA_URI")
NEO4J_USERNAME = os.getenv("NEO4J_AURA_USERNAME")
NEO4J_PASSWORD = os.getenv("NEO4J_AURA_PASSWORD")

# Import the package
from langchain_neo4j import Neo4jGraph

# Create a graph
graph = Neo4jGraph(
    url=NEO4J_URI,
    username=NEO4J_USERNAME,
    password=NEO4J_PASSWORD
)

# Add graph documents to the graph
graph.add_documents(
    graph_documents,
    include_source=True
)


# Import the package
from langchain_neo4j import GraphCypherQAChain

# Create a GraphCypherQAChain
graph_qa = GraphCypherQAChain.from_llm(
    graph=graph,
    llm=llm,
    allow_dangerous_requests=True,
    verbose=True
)

# Define a user question
question = """
How did Google mark the start of the Winter Olympics,
and what other events happened around the same time?
"""

# Invoke the chain
result = graph_qa.invoke(
    {
        "query": question
    }
)

# Print the result
print(result["result"])