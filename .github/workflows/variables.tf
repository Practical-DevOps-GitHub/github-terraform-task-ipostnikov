

variable "repo_name" {
  type    = string
  default = "github-terraform-task-ipostnikov"
}

variable "PAT" {
  type        = string
  description = "Git Hub Personal Access Token"
}

#get repo id

data "github_repository" "repo_name_id" {
  full_name = "Practical-DevOps-GitHub/github-terraform-task"
}

output "repository_id" {
  value = data.github_repository.repo_name_id.id
}