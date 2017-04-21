data "docker_registry_image" "mysql" {
  name = "mysql:latest"
}

resource "docker_image" "mysql" {
  name = "${data.docker_registry_image.mysql.name}"
  pull_triggers = ["${data.docker_registry_image.mysql.sha256_digest}"]
}

resource "docker_container" "database" {
  image = "${docker_image.mysql.latest}"
  name  = "main_db"

  env = [
    "MYSQL_ROOT_PASSWORD=root"
  ]

  ports {
    external = 3306
    internal = 3306
  }
}
