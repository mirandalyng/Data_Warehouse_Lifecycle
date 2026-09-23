import dlt
import pandas as pd
from pathlib import Path
import os  # Confirm we will use this folder


# Dekorator: gör funktionen till en dlt-resource (en dataströmskälla) och
@dlt.resource(write_disposition="replace")
# sätter skrivbeteendet till "replace" -> hela tabellen skrivs över vid varje körning
# Definierar funktionen, tar emot sökväg till CSV-filen + valfria extra argument (t.ex. sep, encoding)
def load_csv_resource(file_path: str, **kwargs):
    # Läser in CSV-filen till en pandas DataFrame, **kwargs skickas vidare till pd.read_csv
    df = pd.read_csv(file_path, **kwargs)
    # yield gör funktionen till en generator -> dlt processar/laddar datan i "chunks"
    yield df
    # istället för att hålla allt i minnet på en gång, och streamar den till destinationen


if __name__ == "__main__":
    # need to change to current working directory as this is where
    # dlt looks for .dlt and when using the play button in vscode
    # it will run from where you are in the terminal, not neccessarily
    # where this script is resided
    working_directory = Path(__file__).parent

    # if you are using files from .dlt,
    # the working directory should be the direct parent of .dlt folder
    os.chdir(working_directory)
    csv_path = working_directory.parent / "data" / "NetflixOriginals.csv"
    data = load_csv_resource(csv_path, encoding="latin1")
    print(data)

    # Pipeline object using the dlt libary and a function called pipeline
    # Provide the information to the destination
    # snowflake is enought for it to find
    # dataset_name is the schema that should be used
    # pipeline_name is for the metadata in pipeline so that dlt will save it

    pipeline = dlt.pipeline(
        pipeline_name='movies',
        destination="snowflake",
        dataset_name='staging'
    )

    # Run the pipeline
    # You need to provide the data you want to extract and table name that is created in staging schema
    # save information in load_info variable
    # to be able to see the log in the terminal
    load_info = pipeline.run(data, table_name="netflix")

    # pretty print the information on data that was loaded
    print(load_info)
