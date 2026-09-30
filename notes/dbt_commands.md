## DBT Commands

## Vanligaste kommandona

| Kommando               | Vad det gör                                                                              |
| ---------------------- | ---------------------------------------------------------------------------------------- |
| `dbt debug`            | Kontrollerar att setup, `profiles.yml` och databasanslutning fungerar.                   |
| `dbt deps`             | Installerar paket som ligger i `packages.yml` (t.ex. dbt_utils).                         |
| `dbt run`              | Bygger alla modeller (skapar tabeller/vyer i databasen).                                 |
| `dbt test`             | Kör tester på modeller och källor (t.ex. `unique`, `not_null`).                          |
| `dbt build`            | Kör `seed`, `run`, `snapshot` och `test` i rätt ordning, i ett svep.                     |
| `dbt compile`          | Kompilerar Jinja till ren SQL utan att köra den. Resultatet hamnar i `target/compiled/`. |
| `dbt seed`             | Laddar CSV-filer från `seeds/` till databasen som tabeller.                              |
| `dbt snapshot`         | Sparar historik över hur data förändras över tid (SCD typ 2).                            |
| `dbt docs generate`    | Skapar dokumentation för projektet.                                                      |
| `dbt docs serve`       | Startar en lokal webbsida där du kan bläddra i dokumentationen och lineage-grafen.       |
| `dbt clean`            | Tar bort kompilerade filer och paket (mappar listade under `clean-targets`).             |
| `dbt ls`               | Listar modeller, tester och andra resurser i projektet.                                  |
| `dbt source freshness` | Kontrollerar hur färsk datan i källorna är.                                              |

## Vanliga flaggor (välj vad som körs)

| Kommando                             | Vad det gör                                                            |
| ------------------------------------ | ---------------------------------------------------------------------- |
| `dbt run --select min_modell`        | Kör bara en specifik modell.                                           |
| `dbt run --select +min_modell`       | Kör modellen **och allt den beror på** (uppströms).                    |
| `dbt run --select min_modell+`       | Kör modellen **och allt som beror på den** (nedströms).                |
| `dbt run --select +min_modell+`      | Kör modellen med både uppströms och nedströms.                         |
| `dbt run --select dim`               | Kör alla modeller i mappen `dim/`.                                     |
| `dbt run --select tag:daily`         | Kör alla modeller med taggen `daily`.                                  |
| `dbt run --exclude min_modell`       | Kör allt utom en specifik modell.                                      |
| `dbt run --full-refresh`             | Bygger om inkrementella modeller från grunden.                         |
| `dbt run --target prod`              | Kör mot en annan miljö (target) från `profiles.yml`.                   |
| `dbt test --select min_modell`       | Kör tester bara för en modell.                                         |
| `dbt build --select state:modified+` | Kör bara ändrade modeller och det som beror på dem (kräver `--state`). |
