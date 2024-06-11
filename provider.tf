terraform {
  required_providers {
    spacelift = {
      source  = "spacelift-io/spacelift"
      version = "~> 1.9.0"
    }
  }
}
provider "spacelift" {}
