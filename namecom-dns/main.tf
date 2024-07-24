locals {
  records = jsondecode(data.http.namecom_records.response_body)
  # (data.http.namecom_records.response_body_base64)
  
  # Assume the response body is an array of records
  filtered_record = [
    for record in local.records : record
    if record.host == var.record_name && record.type == var.record_type
  ]
  
  # Convert the filtered record to a JSON string for local-exec
  filtered_record_json = jsonencode(local.filtered_record[0])
}

provider "http" {}

data "http" "namecom_records" {
  url = "https://api.name.com/v1/domains/${var.domain}/records"
  
  request_headers = {
    Authorization = "Basic ${base64encode("${var.namecom_username}:${var.namecom_token}")}"
    Content-Type  = "application/json"
  }
}

resource "null_resource" "namecom_create_record" {
  provisioner "local-exec" {
    command = <<EOT
      curl -u ${var.namecom_username}:${var.namecom_token} -X POST "https://api.name.com/v1/domains/${var.domain}/records" \
      -H "Content-Type: application/json" \
      -d '[{"host":"${var.record_name}","type":"${var.record_type}","answer":"${var.record_value}","ttl":${var.ttl}}]'
    EOT
  }
}

resource "null_resource" "namecom_update_record" {
  provisioner "local-exec" {
    command = <<EOT
      record_id=$(echo '${local.filtered_record_json}' | jq -r '.id')
      echo "Record ID: $record_id"
      curl -u ${var.namecom_username}:${var.namecom_token} -X PUT "https://api.name.com/v1/domains/${var.domain}/record/$record_id" \
      -H "Content-Type: application/json" \
      -d '[{ "host":"${var.record_name}", "type":"${var.record_type}", "answer":"${var.record_value}", "ttl":"${var.ttl}" }]'
    EOT
  }
}