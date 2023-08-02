resource "shoreline_notebook" "high_4xx_errors_on_nginx" {
  name       = "high_4xx_errors_on_nginx"
  data       = file("${path.module}/data/high_4xx_errors_on_nginx.json")
  depends_on = [shoreline_action.invoke_check_nginx_conf,shoreline_action.invoke_restart_nginx]
}

resource "shoreline_file" "check_nginx_conf" {
  name             = "check_nginx_conf"
  input_file       = "${path.module}/data/check_nginx_conf.sh"
  md5              = filemd5("${path.module}/data/check_nginx_conf.sh")
  description      = "Check if the configuration file exists"
  destination_path = "/agent/scripts/check_nginx_conf.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "restart_nginx" {
  name             = "restart_nginx"
  input_file       = "${path.module}/data/restart_nginx.sh"
  md5              = filemd5("${path.module}/data/restart_nginx.sh")
  description      = "Restart NGINX if the configuration file is valid"
  destination_path = "/agent/scripts/restart_nginx.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_check_nginx_conf" {
  name        = "invoke_check_nginx_conf"
  description = "Check if the configuration file exists"
  command     = "`/agent/scripts/check_nginx_conf.sh`"
  params      = []
  file_deps   = ["check_nginx_conf"]
  enabled     = true
  depends_on  = [shoreline_file.check_nginx_conf]
}

resource "shoreline_action" "invoke_restart_nginx" {
  name        = "invoke_restart_nginx"
  description = "Restart NGINX if the configuration file is valid"
  command     = "`/agent/scripts/restart_nginx.sh`"
  params      = []
  file_deps   = ["restart_nginx"]
  enabled     = true
  depends_on  = [shoreline_file.restart_nginx]
}

