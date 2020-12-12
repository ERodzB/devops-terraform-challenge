variable "MACHINE_CONFIG" {
  type = map(string)
  default = {
    machine_ip = "0.0.0.0/0"
  }
}