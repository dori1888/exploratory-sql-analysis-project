import os
from dotenv import load_dotenv
from sqlalchemy import create_engine
import pandas as pd
import re
# Load environment variables
load_dotenv()
# Read DB path from environment variable
DB_PATH = os.getenv('DB_PATH', './data/database.db')  # fallback to default
DB_URL = f'sqlite:///{DB_PATH}'
# Connect to the existing SQLite database
def connect():
    try:
        engine = create_engine(DB_URL)
        engine.connect()
        print(":marca_de_verificación_blanca: Connected to existing SQLite database.")
        return engine
    except Exception as e:
        print(f":x: Error connecting to database: {e}")
        return None
# Run student-defined queries from queries.sql
def run_queries_from_file(engine, filepath):
    try:
        with open(filepath, 'r') as file:
            content = file.read()
            queries = [re.sub(r"--.*?\n", "\n", q).strip() for q in content.split(';') if q.strip()]
            print(queries)
            for i, query in enumerate(queries, start=0):
                try:
                    df = pd.read_sql(query, con=engine)
                except Exception as e:
                    print(f":x: Error in Query {i}: {e}")
                else:
                    print(f"\n:lupa_derecha: Query {i}:\n{query}")
                    print(df)
    except Exception as e:
        print(f":x: Error processing queries from {filepath}: {e}")
# Entry point
if __name__ == "__main__":
    engine = connect()
    if engine:
        run_queries_from_file(engine, './src/sql/queries.sql')
        
        

    