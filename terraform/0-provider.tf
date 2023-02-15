# https://registry.terraform.io/providers/hashicorp/google/latest/docs
provider "google" {
  project = "iti-abdelrahman"
  region  = "us-central1"
}
#configuring terraform to use google cloud bucket to store terraform state
# https://www.terraform.io/language/settings/backends/gcs
terraform {
  backend "gcs" {
    bucket = "abdelrahman-bucket"
    prefix = "terraform/state"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}
