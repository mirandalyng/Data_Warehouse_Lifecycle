
import sys
from dagster_dbt import DbtCliResource, DbtProject, dbt_assets
from dagster_dlt import DagsterDltResource, dlt_assets
import dagster as dg
import dlt
from pathlib import Path


sys.path.insert(0, "../data_extract_load")
from load_job_ads import jobads_source  # noqa: E402  # isort: skip


# dlt asset
dlt_resource = DagsterDltResource()


@dlt_assets(
    dlt_source=jobads_source(),
    dlt_pipeline=dlt.pipeline(
        pipeline_name="jobsearch",
        destination="snowflake",
        dataset_name="staging",
    ),
)
def dlt_load(context: dg.AssetExecutionContext, dlt: DagsterDltResource):
    yield from dlt.run(context=context)


# dbt asset
dbt_project_directory = Path(__file__).parents[1] / "data_transformation"

profiles_dir = Path.home() / ".dbt"

dbt_project = DbtProject(
    project_dir=dbt_project_directory, profiles_dir=profiles_dir)

dbt_resource = DbtCliResource(project_dir=dbt_project)

# -> manigest in runtime
dbt_project.prepare_if_dev()


@dbt_assets(manifest=dbt_project.manifest_path)
def dbt_models(context: dg.AssetExecutionContext, dbt: DbtCliResource):
    yield from dbt.cli(["build"], context=context).stream()


# jobs
job_dlt = dg.define_asset_job(
    "job_dlt", selection=dg.AssetSelection.keys("dlt_jobads_source_jobads_resource"))

job_dbt = dg.define_asset_job(
    "job_dbt", selection=dg.AssetSelection.key_prefixes("warehouse", "marts")
)

schedule_dlt = dg.ScheduleDefinition(
    job=job_dlt,
    cron_schedule="15 13 * * *"
)


@dg.asset_sensor(asset_key=dg.AssetKey("dlt_jobads_source_jobads_resource"), job_name="job_dbt")
# trigger
def dlt_load_sensor():
    yield dg.RunRequest()

# Definitions


defs = dg.Definitions(
    assets=[dlt_load, dbt_models],
    resources={
        "dlt": dlt_resource,
        "dbt": dbt_resource
    },
    jobs=[job_dlt, job_dbt],
    schedules=[schedule_dlt],
    sensors=[dlt_load_sensor]
)
