terraform {
  required_version = ">=0.13"
  required_providers {
    github = {
      source = "hashicorp/github"
      version = "4.3.2"
    }
  }
}

provider "github" {
  token = var.PAT
  owner = var.org_name.default
  repository = var.repo_name
}

resource "github_repository_collaborator" "softservedata" {
  repository = var.repo_name.default
  username   = "softservedata"
}

resource "github_branch_default" "default_branch" {
  repository = var.repo_name.default
  branch = "develop"
}

resource "github_branch_protection" "main_protection" {
  repository = var.repo_name.default
  branch     = "main"
  enforce_admins = true
  required_pull_request_reviews {
    dismiss_stale_reviews            = true
    require_code_owner_reviews       = true
  }  
}


resource "github_branch_protection" "develop_protection" {

  repository = var.repo_name.default
  branch     = "develop"
  enforce_admins = true

  required_pull_request_reviews {

    required_approving_review_count  = 2

  }
}