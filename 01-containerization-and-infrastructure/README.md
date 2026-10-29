# Module 1: Containerization & Infrastructure as Code

This directory contains the source code, infrastructure configurations, and ingestion pipelines for **Module 1**. The goal of this project is to set up a containerized PostgreSQL database and pgAdmin interface using Docker Compose, and ingest the NYC Yellow Taxi dataset in chunks via Python.

---

## 🛠️ Stack & Technologies
* **Containerization:** Docker, Docker Compose
* **Database & Management:** PostgreSQL 18, pgAdmin 4
* **Language & Environment:** Python 3.13, `uv` (Fast Python package installer & resolver)
* **Libraries:** Pandas, SQLAlchemy, psycopg2

---

## 📁 Folder Structure

```text
01-containerization-and-infrastructure/
├── src/
│   ├── ingest_data.py      # Core data ingestion script (Chunk-based loading)
│   ├── main.py             # Alternative entrypoint script
│   ├── pipeline.py         # Test pipeline logic
│   └── Notebook.ipynb      # EDA and prototyping notebook
├── Dockerfile              # Docker build file for custom ingestion image
├── docker-compose.yaml     # Service definitions for Postgres & pgAdmin
├── pyproject.toml          # Project metadata & dependencies
└── uv.lock                 # Lockfile for reproducible dependencies

```

---

## 🚀 Getting Started

### 1. Prerequisites

Ensure you have Docker and `uv` installed, or run this project inside a **GitHub Codespace**.

### 2. Start Infrastructure

Spin up the PostgreSQL database and pgAdmin containers in detached mode:

```bash
docker compose up -d

```

* **pgAdmin Web UI:** Access at `http://localhost:8085` (Email: `admin@admin.com`, Password: `root`)
* **PostgreSQL:** Access at `localhost:5432` (User: `root`, Pass: `root`, DB: `ny_taxi`)

---

## 📥 Run the Data Ingestion Pipeline

Execute the ingestion script using `uv` to download and stream the NYC Taxi dataset into PostgreSQL:

```bash
uv run python src/ingest_data.py \
  --pg-user=root \
  --pg-pass=root \
  --pg-host=localhost \
  --pg-port=5432 \
  --pg-db=ny_taxi \
  --target-table=yellow_taxi_trips_2021_1 \
  --chunksize=100000

```

> **Note for GitHub Codespaces:** If connecting pgAdmin to PostgreSQL inside Codespaces, use `172.17.0.1` or the Docker bridge gateway IP as the host address to bypass internal DNS resolution constraints.

```

```