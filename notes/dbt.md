# DBT (data build tool)

## What is DBT?

![dbt](images/dbt.png)

## Initiating project for dbt

```
dbt init {name of project ex dbt_code}
```

## If its not the first time working with dbt this will come up:

```
(data-warehouse-lifecycle) mirandalyng@MacBook-Air-som-tillhor-Miranda 09_setup_dbt % dbt init dbt_code
11:27:35  Running with dbt=1.12.5
11:27:36  Setting up your profile.
The profile dbt_code already exists in /Users/mirandalyng/.dbt/profiles.yml. Continue and overwrite it? [y/N]:
```

- both y/N will continue the project
- If you dont want to overwrite choose N

## Two locations that are populated by dbt

### Navigate to dbt folder

Stores the credentials in .dbt

Mac:

```
cd ~/.dbt
```

PowerShell :

```
C:\Users\{din_user}\.dbt
```

```
ls to see .dbt to see profiles.yml
```

open the yml file with credentials

```
open profiles.yml
```

## dbt_code files

### Git ignore and readme

- Put the git ignore from dbt in your own
- Delete the readme and gitignore for more stucture

### Models

- example files
- corresponding to the dbt transformation

### Seeds

- dbt run (the dbt will not go through this when you do the transformation)

### Snapshots

- describe some tables that you want to capture at some point at a time
- remove it

## dbt_project.yml — Project Configuration File

- Think of dbt_project.yml as the control center for your dbt project.

- This is the core configuration file of your dbt project.

#### Key Responsibilities

- Defines project name and version
- Controls model materializations
- Applies folder-level configurations
- Sets schema and database behavior

**profile:**

- you cant have multiple profile.yml in the computer
- No (keep the original file )
- Yes (replace the profiles.yml)

### You can have several profiles in the profiles.yml

- put the profile name in the dbt_projects.yml file

```
profile: '{profile_name}'
```

- if you change the folder names in the dbt init files you need to change it in the dbt_projets.yml

```
EX:
model-paths: ["models"] <-- change here
```

Models

```
models:
add folders you put here to the dbt_projects.yml
```

#### Förklaring

Tänk dig att dbt_project.yml är en regellista för mapparna i din models/-katalog. Istället för att bestämma i varje SQL-fil hur den ska byggas, säger du det en gång per mapp.

## Vad raderna betyder

| Rad                    | Betydelse                                                                               |
| ---------------------- | --------------------------------------------------------------------------------------- |
| `+materialized: table` | "Bygg allt som en riktig tabell i databasen." Standardregeln för alla.                  |
| `+schema: ...`         | "Lägg tabellen i det här schemat i databasen." (Ett schema är som en mapp i databasen.) |
| `ephemeral`            | "Bygg ingen tabell alls, använd bara koden som en tillfällig mellanrutin."              |

## Din config i vanlig text

| Mapp i `models/` | Materialisering | Schema      | Vad händer med SQL-filerna där               |
| ---------------- | --------------- | ----------- | -------------------------------------------- |
| `src/`           | `ephemeral`     | `staging`   | Blir ingen tabell. Planerad plats: `staging` |
| `dim/`           | `table`         | `warehouse` | Blir tabeller i `warehouse`                  |
| `fct/`           | `table`         | `warehouse` | Blir tabeller i `warehouse`                  |
| `mart/`          | `table`         | `marts`     | Blir tabeller i `marts`                      |

#### Kopplingen till models

- Mappnamnen i YAML-filen (src, dim, fct, mart) är samma namn som mapparna i din models/-katalog. En SQL-fil som ligger i models/dim/ får automatiskt reglerna under dim:.

- Ligger en fil i models/dim/kunder.sql så blir den alltså en tabell i schemat warehouse, utan att du skrivit något om det i själva filen.

#### Plustecknet

- betyder "det här är en inställning". Utan + är det ett mappnamn. Därför är src en mapp, men +schema en inställning.

## Src, fct, dim, marts

#### Vad varje mapp står för

| Mapp   | Står för                                        | Vad det är                                                                                                                                                       | Exempel                               |
| ------ | ----------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------- |
| `src`  | **Source** (källa), ofta också kallat _staging_ | Första lagret. Rådata från källsystemen städas lätt: byt kolumnnamn, rätta datatyper, ta bort skräp. Ingen affärslogik.                                          | `src_kunder`, `src_ordrar`            |
| `dim`  | **Dimension**                                   | Tabeller som beskriver **vem, vad, var**: kunder, produkter, butiker, datum. Förändras sällan.                                                                   | `dim_kund`, `dim_produkt`             |
| `fct`  | **Fact** (fakta)                                | Tabeller som beskriver **händelser och siffror**: köp, betalningar, klick. Många rader, mycket mätbart.                                                          | `fct_ordrar`, `fct_betalningar`       |
| `mart` | **Data mart**                                   | Färdiga tabeller anpassade för en **specifik användare eller avdelning**, t.ex. ekonomi eller marknadsföring. Det som BI-verktyg (Power BI, Tableau) läser från. | `mart_forsaljning`, `mart_kundanalys` |

Källsystem → src → dim + fct → mart → rapporter/dashboards
(rådata) (städa) (modellera) (anpassa) (användare)

### packages.yml

#### 1. in packages.yml

```
packages:
  - package: dbt-labs/dbt_utils
    version: 1.3.0
```

#### 2. Go to dbt_code map

```
install (run):

dbt deps

```

#### 3 the dbt_package will appear in dbt_code as a subfolder

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
