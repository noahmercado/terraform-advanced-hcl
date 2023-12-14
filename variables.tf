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

variable "project_id" {
  type = string
  description = "The project ID to deploy resources into"
}

variable "vm_params" {
  type = object({
    count                     = optional(number, 1)
    name                      = string
    machine_type              = string
    zone                      = string
    allow_stopping_for_update = bool
    tags                      = list(string)
  })

  description = "vm parameters"
  default = {
    name                      = "terraform-instance"
    machine_type              = "f1-micro"
    zone                      = "us-central1-a"
    allow_stopping_for_update = true
    tags                      = []
  }

  validation {
    condition     = length(var.vm_params.name) > 3
    error_message = "VM name must be at least 4 characters."
  }
}