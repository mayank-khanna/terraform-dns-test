variable "godaddy_api_key" {
  description = "The API key for the GoDaddy account"
  type        = string
}

variable "godaddy_api_secret" {
  description = "The API secret for the GoDaddy account"
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
