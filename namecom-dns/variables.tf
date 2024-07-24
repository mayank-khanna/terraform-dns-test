variable "namecom_username" {
  description = "The API key for the namecom account"
  type        = string
}

variable "namecom_token" {
  description = "The API secret for the namecom account"
  type        = string
  sensitive   = true
}

variable "domain" {
  description = "The domain name to manage"
  type        = string
}

variable "record_name" {
  description = "The name of the DNS record to manage"
  type        = string
}

variable "record_type" {
  description = "The type of the DNS record"
  type        = string
}

variable "record_value" {
  description = "The value of the DNS record"
  type        = string
}

variable "ttl" {
  description = "The TTL of the DNS record"
  type        = number
}
