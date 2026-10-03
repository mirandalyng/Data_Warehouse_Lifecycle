## DBT testing

1. install the dbt package in the packages.yml file in dbt_code map
2. run {dbt deps}
3. create a schemas.yml inside of models
4. create models inside the yml file for the file you want to test
5. check what the test chould include

```
models:
  - name: dim_employer
    columns:
      - name: employer_id
        data_tests:
          - unique
          - not_null
```

6. run {dbt test}
7. find tests here:
   https://github.com/calogica/dbt-expectations/tree/0.10.3/?tab=readme-ov-file
