variable "project" {
  description = "Project ID GCP"
  default     = "de-zoomcamp-demo-12345"
}

variable "region" {
  description = "Region untuk GCP"
  default     = "asia-southeast1"
}

variable "gcs_bucket_name" {
  description = "Nama unik Storage Bucket"
  default     = "demo-bucket-de-zoomcamp-2026"
}

variable "bq_dataset_name" {
  description = "Nama BigQuery Dataset"
  default     = "demo_dataset"
}
