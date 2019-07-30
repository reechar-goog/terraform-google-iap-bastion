/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */



 /******************************************
  Default compute service account deletion
 *****************************************/
resource "null_resource" "delete_default_compute_service_account" {
  count = "${var.default_service_account == "delete" ? 1 : 0}"

  provisioner "local-exec" {
    command = "${path.module}/scripts/delete-service-account.sh ${google_project.main.project_id} ${data.null_data_source.default_service_account.outputs["email"]} ${var.credentials_path}"
  }

  triggers {
    default_service_account = "${data.null_data_source.default_service_account.outputs["email"]}"
    activated_apis          = "${join(",", var.activate_apis)}"
  }

  depends_on = ["google_project_service.project_services"]
}