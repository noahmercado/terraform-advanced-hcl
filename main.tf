# Copyright 2023 Google LLC

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     https://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

locals {
  buckets = toset(["my-test-bucket-001", "random-gcs-bucket-23421"])
}

#################################################################
#########        Multiple Instance - count     ##################
#################################################################
resource "google_compute_instance" "default_count" {
  count        = var.vm_params.count

  name         = lower("${var.vm_params.name}-${count.index}")
  machine_type = var.vm_params.machine_type
  zone         = var.vm_params.zone

  tags = var.vm_params.tags

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    network = "default"
  }

  project = var.project_id
}

#################################################################
#########       Multiple Buckets - for_each    ##################
#################################################################
# resource "google_storage_bucket" "bucket" {
#   for_each = local.buckets
#   name     = each.key
#   location = "us-central1"
# }

