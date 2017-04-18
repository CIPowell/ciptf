resource "mysql_database" "monitor" {
  depends_on = ["docker_container.database"]

  name = "monitor"
}

resource "mysql_user" "monitor_user" {
  depends_on = ["docker_container.database"]

  user  = "monitor_user"
  password = "bac1234"
}

resource "mysql_grant" "monitor" {
  depends_on = ["mysql_database.monitor", "mysql_user.monitor_user"]

  user = "${mysql_user.monitor_user.user}"
  database = "${mysql_database.monitor.name}"
  privileges = ["SELECT", "INSERT", "UPDATE", "DELETE"]
}
