terraform {
  required_version = ">=0.13"
  required_providers {
    github = {
      source = "hashicorp/github"
      version = "4.3.2"
    }
  }
}

variable "repo_name" {
  default = "github-terraform-task-ipostnikov"
}

variable "org_name" {
  default = "Practical-DevOps-GitHub"
}


provider "github" {
  token = var.PAT
  owner = var.org_name
  repository = var.repo_name
}

resource "github_repository_collaborator" "softservedata" {
  repository = var.repo_name
  username   = "softservedata"
}

resource "github_branch_default" "default_branch" {
  repository = var.repo_name
  branch = "develop"
}

resource "github_branch_protection" "main_protection" {
  repository = var.repo_name
  branch     = "main"
  enforce_admins = true
  required_pull_request_reviews {
    dismiss_stale_reviews            = true
    require_code_owner_reviews       = true
  }

  
}


resource "github_branch_protection" "develop_protection" {

  repository = var.repo_name
  branch     = "develop"
  enforce_admins = true

  required_pull_request_reviews {

    required_approving_review_count  = 2

  }
}