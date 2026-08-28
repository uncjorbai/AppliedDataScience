# Data Pipeline Architecture
Medallion Structure:

Bronze:
Raw ingestion using ingestion_opensource.py to seed data.
Would have to run on Python for data_validator.py or ingestion_opensource.py to run
Only landing data here, no transforms. 

Silver:
Where we're running data_validator.py.
Semi-Structured, cleaned, generally validated records.
In a perfect world, I'd swap the stack to Spark here. Files are in Parquet and Spark would be a much better choice, especially to scale. 
Adding logging & Timestamps

Gold:
Production ready data. Formatted, cleaned, and schematized data. 


## 1. Data Sources
| Source | Type | Volume | Update Frequency | Format |
|--------|------|--------|------------------|--------|
| Customer Events | Streaming | 1M events/day | Real-Time | JSON |
| Product Catalog | Batch | 100k products | Daily | CSV |
| User Profiles | Batch | 500k users | Weekly | Parquet |


## 2. Storage Layers
### Bronze Layer (Raw Data)
- **Purpose:** Raw landing stage for data ingested from the sources in section 1.No transforms. Records are validated as they leave Bronze. 
- **Schema:** 
    - **Events:** `raw_payload` (string, original JSON), `event_type` (string), `user_id` (string), `product_id` (string, nullable), `event_timestamp` (string, unparsed), `ingestion_timestamp` (timestamp), `source` (string)
    - **Products:** all CSV columns as raw strings — `product_id`, `name`, `category`, `price`, `stock` — plus `ingestion_timestamp` (timestamp), `source_file` (string, lineage)
    - **Users:** `user_id` (string), `age_bracket` (string), `state` (string), `signup_date` (string), `ingestion_timestamp` (timestamp) — dtypes preserved as received from Parquet
- **Retention:** Long term records for audits and upstream edits in case of changes to business logic. Metadata logs for trending & audits. 
- **Format:** JSON for events, CSV files for Products, Parquet for Users. 
### Silver Layer (Cleaned Data)
- **Purpose:** Output of Bronze --> Silver transformation. Validated, cleaned, semi-structured data. Bad records are excluded and logged before reaching Silver. 
- **Schema:** Normalized, type-cast, deduplicated. Logging and supplemental data is also stored here for managing the pipeline. There's going to be a clean events table, products, and users. Users may include other information like "last record" or "is active" on the products table. Depends on the needs of the systems and how much logging/storage you can use. Lineage table might store records moved, quarantined, etc.
- **Retention:** Medium term retention policies. Business logic and updates will be less frequent, but timely maintenance will help prevent shutdowns in the long term. 
- **Format:** Delta-Parquet
### Gold Layer (Feature Store)
- **Purpose:** Production ready data. ML features are cleaned and aggregated, and ready for ingestion to their respective models. Schematized with a central fact and proper foreign keys for dimension tables. 
- **Schema:** Star schema, modeled per project. Central fact tables + conformed dimensions.
- **Retention:** Should be refreshed on a consistent schedule. These are the records in production, and should be maintained at the speed of their respective projects. Independent pipelines for each project, so there's no "least common denominator"
- **Format:** Delta-Parquet schematized by report and preceded with Fact_ or Dim_.


## 3. Data Pipeline Flow
Data is directly ingested from separate sources into Bronze. 
Bronze then runs the Data Validator to ensure that all records are okay to move to Silver. Bad records are quarantined and prevented from moving up the pipeline. Once in Silver, we clean and format our data, before creating production ready and modeled Gold tables. 

```
Customer Events (JSON) ---+
  Product Catalog (CSV) ----+---> BRONZE ---> [validator] ---> SILVER ---> GOLD
  User Profiles (Parquet) --+
```

## 4. Technology Choices
| Capability | Azure Managed | OSS Alternative | Other-Cloud Equivalent | Why
this one |
|------------|---------------|-----------------|------------------------|----
-----------|
| Streaming ingestion | Azure Eventhub | Kafka | AWS Kinesis | Kafka is free and not limited to a single provider. Best control over our system. |
| Object storage (Bronze) | ADLSG2 | MinIO | AWS S3 | MinIO is a better fit for the freedom we're looking for. ADLSG2 puts us too into the Microsoft Stack and S3 requires a subscription and overhead. |
| Stream/batch processing | Azure Synapse | Apache Spark | AWS EMR | If we were just virtualizing the tables, Synapse would be great. We have to move data, however, and that requires that we have something lightweight. In the spirit of keeping our platform agile, Spark allows us to set the conditions we need for processing, while being deployable on any managed or unmanaged instance we need.  |
| Orchestration | Azure Data Factory | Apache Airflow | AWS Step Function | Airflow. Freedom to choose, no reliance on any singular stack. |
| Data quality / validation | Synapse | Great Expectations | AWS Deequ | We're preventing "garbage in-garbage out" using Great Expectations. Open source means it's lightweight on costs, but gives us the plug and play we're missing with Azure or AWS. |

## 5. Data Quality Strategy
- Validation rules for each layer
    **Bronze:** Structure only. Data type validations as we ingest, expected file types, validator.
    **Silver:** Validated data, schema enforcement and data cleaning & filtering. 
    **Gold:** Schematized modeling and edge case management, data validation and deduplication done here. 
- Drift detection approach
    - Schema Drift: hash incoming column set per batch and compare to the last known schema. Alert on drops, new data, or renames.
    - Distribution Drift: Is data coming as expected. When do we notice 'significant' changes in data?
- Error handling strategy
    - Malformed records are handled by the data validator. 
    - Logging & Audits with threshholds for alerting.