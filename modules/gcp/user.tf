# create service account
resource "google_service_account" "bitmovin_account" {
  account_id   = var.account_id
  display_name = var.user_name
}

# assign project role
resource "google_project_iam_member" "bitmovin_project" {
  project = var.project_id
  role    = "roles/compute.instanceAdmin.v1"
  member  = "serviceAccount:${google_service_account.bitmovin_account.email}"
}

resource "google_project_iam_member" "bitmovin_project-static-ip" {
  count   = var.service_account_network_admin_permissions == true ? 1 : 0
  project = var.project_id
  role    = "roles/compute.networkAdmin"
  member  = "serviceAccount:${google_service_account.bitmovin_account.email}"
}

# create new access key
resource "google_service_account_key" "mykey" {
  service_account_id = google_service_account.bitmovin_account.id
}
