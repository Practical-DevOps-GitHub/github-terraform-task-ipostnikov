

variable "PAT" {
  type    = string
  default = ""
}
variable "owner" {
  type    = string
  default = "Practical-DevOps-GitHub"
}

variable "repo_name" {
  type    = string
  default = "github-terraform-task-ipostnikov"
}

# rep data get the ID

data "github_repository" "repo_name" {
  full_name = "Practical-DevOps-GitHub/github-terraform-task"
}

output "repository_id" {
  value = data.github_repository.repo_name.id
}