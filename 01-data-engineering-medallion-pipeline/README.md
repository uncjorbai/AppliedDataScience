# Medallion Data Pipeline (Bronze → Silver → Gold)

**Course:** DATA 789: Data Science & AI in the Cloud · **Stack:** Python, pandas, PyArrow

A data engineering exercise: design an ingestion and validation pipeline for three sources
(streaming events, batch product catalog, batch user profiles) using a medallion
architecture, and build a runnable Bronze to Silver validator.

## Design

| Layer | Role |
|-------|------|
| Bronze | Raw landing zone. No transforms, full lineage and ingestion timestamps |
| Silver | Cleaned, type-cast, deduplicated records. Bad rows quarantined and logged |
| Gold | Production-ready, schematized data |

Full write-up in [architecture.md](architecture.md).

## Files

- `architecture.md`: medallion design, data sources, storage layers, retention strategy
- `ingestion_opensource.py`: Bronze ingestion for all three sources (designed and documented)
- `data_validator.py`: runnable Bronze to Silver validator (events, products, users)
- `make_sample_data.py`: generates seeded synthetic sample data to exercise the validator

## Run it

```bash
python make_sample_data.py   # generate seeded sample data (includes deliberate bad records)
python data_validator.py     # run validation, print report
```

## Limitations

Bad records are deliberately seeded for testing. `ingestion_opensource.py` is designed and
documented for the assignment scope but not executed, and the Silver-layer transform is out
of scope. One documented edge case: on malformed JSON lines, an event's reported `row_index`
can drift from the physical line number after the DataFrame renumbers rows. Total validation
counts stay correct; only the per-row index can be off.
