provider "http" {}

data "http" "godaddy_get_record" {
  url = "https://api.godaddy.com/v1/domains/${var.domain}/records/${var.record_type}/${var.record_name}"
  request_headers = {
    Authorization = "sso-key ${var.godaddy_api_key}:${var.godaddy_api_secret}"
  }
}

resource "null_resource" "godaddy_update_record" {
  provisioner "local-exec" {
    command = <<EOT
    curl -X PUT "https://api.godaddy.com/v1/domains/${var.domain}/records/${var.record_type}/${var.record_name}" \
    -H "Authorization: sso-key ${var.godaddy_api_key}:${var.godaddy_api_secret}" \
    -H "Content-Type: application/json" \
    -d '[{"data":"${var.record_value}", "ttl": ${var.ttl}}]'
    EOT
  }
}

output "response" {
  value = data.http.godaddy_get_record.status_code
}
