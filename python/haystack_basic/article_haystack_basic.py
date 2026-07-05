# Basic Haystack 2.0


# 1. Create a prompt builder

# 1.1 Define the system prompt
system_prompt = """
You are an expert curator of mental models across science, philosophy, and applied reasoning.

Your task is to explain mental models clearly and accurately using a fixed schema.

If the origin of a model is unclear or debated, state that explicitly.

Do not invent historical sources. Be concise and concrete.
"""


# 1.2 Define the user prompt
user_prompt = "Explain the following mental model: {{model_query}}"


# 1.3 Create a prompt builder instance

# Import required packages
from haystack.components.builders import ChatPromptBuilder
from haystack.dataclasses import ChatMessage

# Create an instance of ChatPromptBuilder
prompt_builder = ChatPromptBuilder(
    template=[
        ChatMessage.from_system(system_prompt.strip()),
        ChatMessage.from_user(user_prompt)
    ],
    required_variables=["model_query"]
)


# 2. Instantiate an LLM

# 2.1 Retrieve the Gemini API key

# Import required packages
import os
from pathlib import Path
from dotenv import load_dotenv

# Set the project root directory
ROOT_DIR = Path(__file__).resolve().parents[2]

# Define the path to the .env file
ENV_PATH = ROOT_DIR / ".env"

# Load environment variables from the .env file
load_dotenv(ENV_PATH)

# Retrieve the API key
GEMINI_API_KEY = os.getenv("GEMINI_API_KEY")


# 2.2 Define a structured-output class

# Import required packages
from pydantic import BaseModel, Field
from typing import List, Literal

# Define the output schema
class MentalModel(BaseModel):

    # Mental model name
    model_name: str = Field(
        description="The commonly accepted name of the mental model"
    )

    # Origin or source
    origin: str = Field(
        description="Where the model comes from (a person, book, field, or cultural origin)"
    )

    # Brief description
    description: str = Field(
        description="A brief explanation of what the mental model is and why it matters"
    )

    # Example
    example: str = Field(
        description="A concrete real-world example illustrating the mental model"
    )

    # Tags
    tags: List[str] = Field(
        description="Short tags such as decision-making, systems thinking, learning, and philosophy"
    )


# 2.3 Create an LLM instance

# Import required packages
from haystack.utils import Secret
from haystack_integrations.components.generators.google_genai import GoogleGenAIChatGenerator

# Create an LLM instance configured for structured output
llm_with_structured_output = GoogleGenAIChatGenerator(
    model="gemini-2.5-flash",
    api_key=Secret.from_token(GEMINI_API_KEY),
    generation_kwargs={
        "temperature": 0.5,
        "response_format": MentalModel
    }
)


# 3. Create an LLM pipeline

# Import the required package
from haystack import Pipeline

# Create a pipeline instance
chain = Pipeline()

# Add the components
chain.add_component(
    "prompt_builder", # Name
    prompt_builder # Instance
)
chain.add_component(
    "llm", # Name
    llm_with_structured_output # Instance
)

# Connect the prompt builder's output to Gemini's input
chain.connect(
    "prompt_builder.prompt", # Sender: prompt from prompt builder
    "llm.messages" # Receiver: message from LLM instance
)


# 4. Run the pipeline

# Run the pipeline with a mental-model query
raw_result = chain.run(
    data={
        "prompt_builder": {"model_query": "Compound Interest"}
    }
)

# Extract the structured-output text from the raw result
reply_json = raw_result["llm"]["replies"][0].text

# Validate the structured output against the MentalModel schema
result = MentalModel.model_validate_json(reply_json)

# Print the validated structured output
print(result.model_dump())