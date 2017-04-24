data "docker_registry_image" "nginxproxy" {
  name = "jwilder/nginx-proxy:latest"
}

resource "docker_image" "nginxproxy" {
  name          = "${data.docker_registry_image.nginxproxy.name}"
  pull_triggers = ["${data.docker_registry_image.nginxproxy.sha256_digest}"]
}

resource "docker_container" "vhost_proxy" {
    image = "${docker_image.nginxproxy.latest}"
    name = "vhost_proxy"

    ports {
      internal = 80
      external = 80
    }

    volumes {
      host_path = "/var/run/docker.sock"
      container_path = "/tmp/docker.sock"
      read_only = true
    }
}


module "chrisipowell_site" {
  source = "./staticsite"
  sitedomain = "chrisipowell.dev"
  root_dir = "/Users/cip/Projects/cip/public"
}

module "monitor_site" {
  source = "./staticsite"
  sitedomain = "monitor.dev"
  root_dir = "/Users/cip/Projects/monitor/dist"
}
