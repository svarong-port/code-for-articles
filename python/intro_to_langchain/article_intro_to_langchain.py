# Introduction to LangChain


## 1. API Key

# Load API key

# Import packages
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


## 2. LLM

# Import package
from langchain_google_genai import ChatGoogleGenerativeAI

# Create model instance
llm = ChatGoogleGenerativeAI(
    model="gemini-2.5-flash",
    temperature=0.5,
    api_key=gemini_api_key
)


## 3. Prompt Template

# Import package
from langchain_core.prompts import ChatPromptTemplate

# Define system prompt
system_prompt = """
You are an expert curator of mental models across science, philosophy, and applied reasoning.

Your task is to explain mental models clearly and accurately using a fixed schema.

If the origin of a model is unclear or debated, state that explicitly.

Do not invent historical sources. Be concise and concrete.
"""

# Define user prompt
user_prompt = "Explain the following mental model: {model_query}"

# Create prompt template
prompt = ChatPromptTemplate.from_messages(
    [
        # System prompt
        ("system", system_prompt.strip()),

        # User prompt
        ("human", user_prompt)
    ]
)

# Inspect prompt
prompt.format_messages(model_query="Pareto Pricinple")


## 4. Output Format

# Import package
from pydantic import BaseModel, Field
from typing import List, Literal

# Define output structure
class MentalModel(BaseModel):

    # Mental model name
    model_name: str = Field(description="The commonly accepted name of the mental model")

    # Source/origin
    origin: str = Field(
        description="Where the model comes from (person, book, field, or cultural origin)"
    )

    # Brief description
    description: str = Field(
        description="A brief explanation of what the mental model is and why it matters"
    )

    # Examples
    examples: List[str] = Field(
        description="Concrete real-world examples illustrating the mental model"
    )

    # Cognitive load required to learn this model
    cognitive_load: Literal["low", "medium", "high"] = Field(
        description="How mentally demanding this model is to learn and apply"
    )

    # Tags
    tags: List[str] = Field(
        description="Short tags such as decision-making, systems thinking, learning, philosophy"
    )

# Add output structure to LLM
llm_with_structured_output = llm.with_structured_output(MentalModel)


## 5. Chain

# Build chain
chain = prompt | llm_with_structured_output


## 6. Single Run

# Run query
result = chain.invoke({"model_query": "Compound Interest"})

# Import package
import json

# Load result
result_dict = result.model_dump()

# Print
print(json.dumps(result_dict, indent=4))


## 7. Batch run

# Create list of mental models
mental_model_queries = [
    "First Principles Thinking",
    "Occam's Razor",
    "Confirmation Bias",
    "Map is Not the Territory",
    "42"
]

# Create batch inputs
batch_inputs = [{"model_query": query} for query in mental_model_queries]

# Run queries
results = chain.batch(batch_inputs)

# Instantiate collector
query_collector = [result.model_dump() for result in results]

# Instantiate counter
i = 1

# Loop through elements in collector
for result in query_collector:

    # Print result
    print(f"👉 Query {i}:")
    print(json.dumps(result, indent=4))
    print("\n")

    # Add 1 to counter
    i += 1