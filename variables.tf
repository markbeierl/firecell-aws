# Copyright 2024 Canonical Ltd.
# See LICENSE file for licensing details.

variable "sdcore_model_name" {
  description = "Name of Juju model to deploy application to."
  type        = string
  default     = "sdcore"
}

variable "gnb_model_name" {
  description = "Name of Juju model to deploy application to."
  type        = string
  default     = "radio"
}
