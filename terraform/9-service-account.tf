#create new service account for gke 
resource "google_service_account" "project-service-account" {
  account_id = "project-service-account"
  project    = "iti-abdelrahman"
}

#grant permissions for service account
resource "google_project_iam_binding" "project-service-account-iam" {
  project = "iti-abdelrahman"
  role    = "roles/storage.admin"
  members = [
    "serviceAccount:${google_service_account.project-service-account.email}"
  ]
}


# resource "google_service_account" "service-account" {
#   account_id   = "service-account"
#   display_name = "Service Account"
# }

# resource "google_project_iam_binding" "service-account-binding" {
#   project = "iti-abdelrahman"
#   role    = "roles/storage.objectViewer"
#   members = ["serviceAccount:${google_service_account.service-account.email}"]

# }

# resource "google_project_iam_binding" "service-account-binding-2" {
#   project = "iti-abdelrahman"
#   role    = "roles/container.admin"
#   members = ["serviceAccount:${google_service_account.service-account.email}"]

# }
