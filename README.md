# Self-Paced Data Engineering Portfolio (DataTalksClub Curriculum)

Welcome! This repository serves as my hands-on portfolio while independently studying the **Data Engineering Zoomcamp** curriculum by DataTalksClub. It is structured as a **Monorepo** containing end-to-end data pipelines, infrastructure setup, and batch/streaming data engineering workflows.

---

## Repository Structure

```text
docker-data-engineering-zoomcamp-2026/
├── 01-containerization-and-infrastructure/  # Docker, Postgres, pgAdmin, Ingestion Pipeline
│   ├── src/                                 # Pipeline source scripts & notebooks
│   ├── Dockerfile
│   ├── docker-compose.yaml
│   ├── pyproject.toml
│   └── uv.lock
├── 02-workflow-orchestration/               # Orchestration pipelines (Upcoming)
├── 03-data-warehouse/                      # Data Warehousing with BigQuery/dbt (Upcoming)
├── 04-analytics-engineering/               # Transformation & dbt (Upcoming)
├── 05-batch-processing/                    # Apache Spark (Upcoming)
└── 06-streaming/                            # Kafka & Real-time Processing (Upcoming)