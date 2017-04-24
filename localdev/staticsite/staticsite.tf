variable "sitedomain" {}
variable "root_dir" {}

data "docker_registry_image" "nginx" {
  name = "nginx:latest"
}

resource "docker_image" "nginx" {
  name          = "${data.docker_registry_image.nginx.name}"
  pull_triggers = ["${data.docker_registry_image.nginx.sha256_digest}"]
}

resource "docker_container" "static_nginx" {
    image = "${docker_image.nginx.latest}"
    name = "${var.sitedomain}"

    volumes {
      host_path = "${var.root_dir}"
      container_path = "/usr/share/nginx/html"
      read_only = true
    }

    ports {
      internal = 80
    }

    env  = [
      "VIRTUAL_HOST=${var.sitedomain}"
    ]
}
