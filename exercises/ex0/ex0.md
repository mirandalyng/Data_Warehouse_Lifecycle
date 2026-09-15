# Exercise 0 - Introduction

## 2. Theory questions

**a) What are the main components of Snowflake's architecture?**

Snowflake uses a hybrid architecture with three independently scalable layers:

1. **Storage layer** – holds all persisted data
2. **Compute layer** – virtual warehouses that process queries
3. **Cloud services layer** – coordinates authentication, metadata, query optimization, and more

Because these layers are decoupled, you can scale compute and storage independently, unlike traditional architectures where they're tightly coupled.

**b) Explain the role of the storage layer in Snowflake.**

The storage layer holds all data Snowflake manages — tables, staged files, and metadata. Snowflake automatically compresses, organizes, and stores this data in cloud storage (S3, Azure Blob, or GCS, depending on your cloud provider). It's shared across all compute resources, so multiple warehouses can query the same data simultaneously without duplicating it. You're billed for storage separately from compute, at a flat rate per compressed TB/month.

**c) What is the purpose of the compute layer in Snowflake?**

The compute layer consists of virtual warehouses — clusters of compute resources that actually execute queries (reads, writes, DML, etc.). Each warehouse is independent, meaning one workload's compute demand doesn't affect another's performance. You only pay for compute while a warehouse is running (billed per second, with a 60-second minimum per start/resume), and you can suspend warehouses when idle to avoid unnecessary cost.

**d) How does the cloud services layer enhance the functionality of Snowflake?**

The cloud services layer is the "brain" coordinating the whole platform. It handles:

- Authentication and access control
- Metadata management (table structures, statistics, micro-partition info)
- Query parsing and optimization
- Infrastructure management
- Result caching (allowing some queries to return instantly without spinning up compute)

This layer is what makes features like zero-copy cloning, Time Travel, and cross-warehouse metadata consistency possible without manual coordination.

**e) What is a virtual warehouse in Snowflake, and how does it differ from a traditional data warehouse?**

A virtual warehouse is a cluster of compute resources (CPU, memory, temp storage) that Snowflake provisions on demand to run queries. Key differences from a traditional data warehouse:

- **Elastic**: can be resized, started, suspended, or auto-scaled in seconds
- **Decoupled from storage**: multiple warehouses can hit the same data without contention
- **Ephemeral**: you pay only for the time it runs, rather than maintaining fixed, always-on infrastructure
- **Isolated**: one warehouse's load doesn't degrade another's performance, since each gets its own dedicated compute

**f) When are the cases you would want to scale up versus scaling out in terms of virtual warehouses and compute resources.**

- **Scale up** (increase warehouse size, e.g., S → M → L): use this when individual queries are slow due to complexity, large data volumes, or heavy joins/aggregations. A bigger warehouse gives each query more compute and memory.
- **Scale out** (add clusters via multi-cluster warehouses): use this when you have high concurrency — many simultaneous users/queries — rather than slow individual queries. Additional clusters handle queuing, not per-query speed.

Rule of thumb: slow single queries → scale up; queueing under many concurrent users → scale out.

**g) How does Snowflake's pricing model differ from traditional on-premise data warehousing solutions?**

Snowflake is consumption-based (pay only for compute-seconds and storage actually used) rather than requiring large upfront capital expenditure on hardware sized for peak load. On-premise systems require you to provision for worst-case capacity, leading to idle/wasted resources most of the time, plus ongoing costs for maintenance, power, cooling, and staffing. Snowflake shifts this to an operating expense model with elastic, near-instant scaling and no infrastructure management.

**h) What is the difference between pay-as-you-go and upfront storage, and when should you choose one over the other?**

- **Pay-as-you-go (on-demand)**: no commitment, billed monthly based on actual average storage used. Best for unpredictable or smaller storage needs, or early-stage projects where usage isn't well understood yet.
- **Upfront (capacity)**: you commit to a certain amount of credits/storage over a contract term (often 1-3 years) in exchange for a discounted rate. Best when you have predictable, sustained usage at scale — the discount (often 20-45%) outweighs the loss of flexibility.

**i) Explain the concept of Time Travel and Fail-safe in Snowflake and its use cases**

- **Time Travel**: lets you access historical data (query, clone, or restore) within a defined retention window (up to 1 day on Standard, up to 90 days on Enterprise+). Use cases: recovering accidentally dropped/updated data, auditing changes, comparing data at different points in time.
- **Fail-safe**: a non-configurable 7-day period _after_ Time Travel expires, during which Snowflake can recover data — but only Snowflake support can perform this recovery, and it's meant as a last-resort disaster recovery mechanism, not a self-service tool. It's not intended for routine use and can carry storage cost implications.

Together, they form a layered recovery strategy: self-service recovery via Time Travel, then Snowflake-assisted emergency recovery via Fail-safe.

## Glossary

| terminology       | explanation                                                                                                                                                                            |
| ----------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| downstream        | Systems, processes, or consumers that receive/use data _after_ it has been processed or transformed — i.e., further along the data pipeline.                                           |
| upstream          | Systems or sources that data originates from _before_ reaching the current stage — earlier in the data pipeline.                                                                       |
| data warehouse    | A centralized system designed to store and analyze large volumes of structured data, typically optimized for read-heavy analytical queries rather than transactional workloads.        |
| cloud computing   | On-demand delivery of computing resources (servers, storage, databases, networking) over the internet, billed based on usage rather than owned infrastructure.                         |
| OLAP              | Online Analytical Processing — systems optimized for complex, read-heavy analytical queries over large datasets (e.g., reporting, BI). Snowflake is primarily an OLAP system.          |
| OLTP              | Online Transaction Processing — systems optimized for fast, small, frequent read/write transactions (e.g., order processing systems).                                                  |
| virtual warehouse | A cluster of compute resources in Snowflake used to execute queries and DML operations; independently scalable and billed by the second while running.                                 |
| external stage    | A named location outside Snowflake (e.g., an S3 bucket, Azure container, or GCS bucket) used for loading data into or unloading data from Snowflake tables.                            |
| data consumer     | An account, organization, or user that accesses and uses data shared with them (e.g., via Snowflake's Secure Data Sharing), as opposed to the data provider who owns/shares it.        |
| scaling out       | Adding more compute clusters (multi-cluster warehouses) to handle increased concurrency/query volume, without changing the size of any individual cluster.                             |
| scaling up        | Increasing the size of a single virtual warehouse (e.g., S → M → L) to give individual queries more compute power and memory.                                                          |
| snowflake credit  | Snowflake's unit of billing for compute consumption; the cost per credit depends on edition, cloud provider, and region.                                                               |
| securable object  | Any Snowflake entity to which access can be granted/restricted via RBAC (e.g., databases, schemas, tables, warehouses, roles).                                                         |
| schema            | A logical grouping of database objects (tables, views, etc.) within a Snowflake database, used to organize and namespace objects.                                                      |
| permanent table   | The default table type in Snowflake; supports full Time Travel (up to 90 days on higher editions) and Fail-safe (7 days), making it durable and recoverable.                           |
| transient table   | A table type that persists like a permanent table but has no Fail-safe period and limited Time Travel (0 or 1 day), reducing storage costs for non-critical data.                      |
| temporary table   | A session-scoped table that exists only for the duration of the session and is automatically dropped afterward; no Fail-safe and minimal Time Travel.                                  |
| time-travel       | A Snowflake feature allowing access to historical versions of data (query, clone, restore) within a configurable retention period, used for recovering or auditing past data states.   |
| fail-safe         | A 7-day, non-configurable period after Time Travel expires during which Snowflake can recover data as a last-resort disaster recovery measure (requires contacting Snowflake support). |
| view              | A saved SQL query that presents data as a virtual table without physically storing the data itself; can be standard, secure, or materialized.                                          |
| table             | The fundamental structure for storing data in rows and columns within a schema.                                                                                                        |
| DML               | Data Manipulation Language — SQL statements that modify data, such as `INSERT`, `UPDATE`, `DELETE`, and `MERGE`.                                                                       |
| DDL               | Data Definition Language — SQL statements that define or alter database structures, such as `CREATE`, `ALTER`, and `DROP`.                                                             |
| DQL               | Data Query Language — SQL statements used to retrieve data, primarily `SELECT`.                                                                                                        |
| DCL               | Data Control Language — SQL statements that control access/permissions, such as `GRANT` and `REVOKE`.                                                                                  |
