# Data Orchestration with Dagster

## What is Dagster?

Dagster is a **data orchestrator**. It helps you automate data pipelines and keep track of the data they produce.

Think of it like this: instead of writing a long script that runs step 1, then step 2, then step 3, you describe the pieces of data you want to exist (like tables or files) and how they depend on each other. Dagster then figures out in which order to run everything.

- data orchestrator
- automates data pipelines
- produces data assets
- built on **Software Defined Assets (SDA)** [Read More](https://dagster.io/glossary/software-defined-assets)
  - you define the assets and their relationships
  - the execution plan is inferred from these definitions
  - declarative programming (e.g. SQL) instead of imperative programming (e.g. pandas)
    - declarative: you describe _what_ should exist
    - imperative: you describe _how_ to get there step by step
- benefits of the asset-centric approach
  - dependencies are easy to manage, since Dagster knows what depends on what
  - execution is easy to monitor, since you can see which assets are up to date

> [!Note]
> Check out the [link](https://dagster.io/glossary/software-defined-assets) to read more about SDA and a simple example of how Dagster uses assets to build a data pipeline.

## Core concepts

With Dagster, a data pipeline is built from components such as `asset`, `job`, `schedule` and `sensor`. In a Python script, `Definitions` is used to collect these components into one workflow. The definitions are then deployed, and the assets can be **materialized**.

The big picture:

1. **Assets** describe _what_ data should exist.
2. **Jobs** group assets so they can be run together.
3. **Schedules** and **sensors** decide _when_ a job runs.
4. **Definitions** bundles everything so Dagster can load it.
5. **Materialization** is the actual run that produces the data.

### Asset

An asset is the most important building block in Dagster.

- a logical unit of data, like a database table, a CSV file, a PNG file etc.
- in code, an asset is a Python function that produces that data
- an `asset` can depend on other assets
  - for example, `clean_orders` depends on `raw_orders`
  - Dagster uses this to build the dependency graph and run things in the right order
- an `asset` can be used in a `job`, `schedule` or `sensor`

```python
from dagster import asset

@asset
def raw_orders():
    ...

@asset
def clean_orders(raw_orders):  # depends on raw_orders
    ...
```

### Job

- the main form of execution
- contains a selection of assets that should be run together
  - for example, only the assets needed for one specific report
- can be started manually, by a `schedule` or triggered by `sensor`

```python
from dagster import define_asset_job

orders_job = define_asset_job("orders_job", selection="*")
```

### Schedule

- a way to automate a `job` or the materialization of an `asset` at a specific interval
  - for example, every night at 02:00
- uses a cron expression to describe the time
- after deployment, the schedule needs to be turned on in the Dagster UI

```python
from dagster import ScheduleDefinition

daily = ScheduleDefinition(job=orders_job, cron_schedule="0 2 * * *")
```

### Sensor

- a way to trigger a `job` or the materialization of an `asset` when a certain event occurs
  - for example, a new file arrives in a bucket, or another asset has finished materializing
- unlike a schedule, a sensor is event-driven, not time-driven
- after deployment, the sensor needs to be turned on in the Dagster UI

### Definitions

- `Definitions` is the top-level construct in a workflow
- it collects all the components in one place
- only objects included in the definitions will be deployed and visible in the Dagster UI

```python
from dagster import Definitions

defs = Definitions(
    assets=[raw_orders, clean_orders],
    jobs=[orders_job],
    schedules=[daily],
)
```

### Materialization

- materializing an asset means that Dagster actually runs the code behind it
- the data is produced and stored, and metadata about the run is saved
- can be triggered
  - manually in the Dagster UI
  - by a schedule
  - by a sensor

## Summary

| Concept         | Role                                   |
| --------------- | -------------------------------------- |
| Asset           | _What_ should be produced              |
| Job             | Which assets are run together          |
| Schedule        | _When_ a job runs (time-based)         |
| Sensor          | _When_ a job runs (event-based)        |
| Definitions     | Bundles everything into one workflow   |
| Materialization | The run that actually creates the data |

## Installation

Install the Python packages below in your uv virtual environment:

```bash
uv add dagster dagster-webserver dagster-dlt dagster-dbt
```

- `dagster`: the core library
- `dagster-webserver`: the web UI
- `dagster-dlt`: integration with dlt (data loading)
- `dagster-dbt`: integration with dbt (data transformation)

## Command

To start a local Dagster development server and load the definitions from a Python file:

```bash
dagster dev -f <python file>
```

After starting, open the UI in your browser to see the assets, run materializations and turn on schedules and sensors.

### sources file

```yml
sources:
  - name: job_ads
    schema: staging
    tables:
      - name: stg_ads
        identifier: technical_field_job_ads
        meta:
          dagster:
            asset_key: ["dlt_jobads_source_jobads_resource"]
```

# References

Material from this lecture comes from these official Dagster documentation pages:

- [dagster overview](https://dagster.io/blog/dagster-crash-course-oct-2022)
- [dagster components](https://docs.dagster.io/getting-started/concepts)
- [dagster dlt](https://docs.dagster.io/integrations/libraries/dlt)
- [dagster dbt](https://docs.dagster.io/integrations/libraries/dbt)
