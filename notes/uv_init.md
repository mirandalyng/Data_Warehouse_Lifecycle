# UV

## upgrade the uv enviroment

```
 pip install --upgrade uv
```

## Installing the packages to sync

## You can remove main.py

```
uv init --no-package --python 3.13
```

## add packages to enviroment

```
uv add [packages]
```

## For specific repo

```
uv add "dlt[snowflake]" ipykernel pandas "dlt[parquet]"
```

## Change name

```
 uv init --no-package --python 3.13 --name Data_Warehouse
```
