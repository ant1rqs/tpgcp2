variable "project_id" {
  type    = string
  default = "tpfinal-447407"
}

variable "source_image" {
  type    = string
  default = "projects/debian-cloud/global/images/family/debian-11"
}

variable "zone" {
  type    = string
  default = "europe-west9-a"
}

source "googlecompute" "debian" {
  project_id  = var.project_id
  source_image = var.source_image
  zone        = var.zone
  instance_type = "e2-medium"
}

build {
  sources = ["source.googlecompute.debian"]

  provisioner "ansible" {
    playbook_file = "playbook.yml"
  }

  post-processor "googlecompute-import-image" {
    project_id = var.project_id
    family     = "debian-custom-image"
  }
}
