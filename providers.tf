terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}
provider "google" {
  credentials = file("proj.json")

  project = "terraform-test-321108"
  region  = var.region
  zone    = var.zone
}
