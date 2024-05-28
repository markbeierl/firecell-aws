# Copyright 2024 Canonical Ltd.
# See LICENSE file for licensing details.

variable "control_plane_model_name" {
  description = "Name of Juju model to deploy application to."
  type        = string
  default     = "control-plane"
}

variable "create_model" {
  description = "Allows to skip Juju model creation and re-use a model created in a higher level module."
  type        = bool
  default     = false
}

variable "user_plane_model_name" {
  description = "Name of Juju model to deploy application to."
  type        = string
  default     = "user-plane"
}

variable "gnb_model_name" {
  description = "Name of Juju model to deploy application to."
  type        = string
  default     = "radio"
}
