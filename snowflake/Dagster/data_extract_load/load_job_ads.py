
import dlt
import requests
import json

# By default DLT & dagster will create a staging dataset
# Clean up the staging in the staging_stating_..
dlt.config["load.trancate_staging_dataset"] = True
params = {"limit": 100, "occupation-field": "6Hq3_tKo_V57"}


def _get_ads(url_for_search, params):
    response = requests.get(url_for_search, params=params)
    response.raise_for_status()  # check for http errors
    return json.loads(response.content.decode("utf8"))


# add parameter table name
@dlt.resource(table_name="job_ads", write_disposition="replace")
def jobads_resource(params):

    url = "https://jobsearch.api.jobtechdev.se"
    url_for_search = f"{url}/search"

    for ad in _get_ads(url_for_search, params)["hits"]:
        yield ad


# Dagster works with dlt source not resource
# You can collect different / multiple resources into a source
@dlt.source
def jobads_source():
    return jobads_resource(params)  # place params here

# def run_pipeline(table_name):
#     pipeline = dlt.pipeline(
#         pipeline_name="jobsearch",
#         destination="snowflake",
#         dataset_name="staging",
#     )


#     load_info = pipeline.run(jobads_resource(
#         params=params), table_name=table_name)
#     print(load_info)
