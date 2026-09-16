import dlt
import pandas as pd
from pathlib import Path
import os


# used for extracting data from source, in this case a local csv file
@dlt.resource(write_disposition="replace")
def load_csv_resource(file_path: str, **kwargs):

    df = pd.read_csv(file_path, **kwargs)
    yield df


if __name__ == "__main__":

    # need to change to current working directory as this is where
    # dlt looks for .dlt and when using the play button in vscode
    # it will run from where you are in the terminal, not neccessarily
    # where this script is resided
    working_directory = Path(__file__).parent

    # if you are using files from .dlt,
    # the working directory should be the direct parent of .dlt folder
    os.chdir(working_directory)

    data_dir = working_directory.parent / "data"
    excel_path = data_dir / "iFood.xlsx"
    csv_path = data_dir / "iFood.csv"

    read_file = pd.read_excel(excel_path)
    read_file.to_csv(csv_path, index=None, header=True)

    data = load_csv_resource(csv_path, encoding="latin1")
    print(data)
    pipeline = dlt.pipeline(
        pipeline_name='ifood',
        destination="snowflake",
        dataset_name='staging'
    )

    load_info = pipeline.run(data, table_name="ifood_orders")

    # pretty print the information on data that was loaded
    print(load_info)
