terraform {
  required_version = ">=0.13"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "4.3.2"
    }
  }
}

provider "github" {
  token = var.PAT
  owner = "Practical-DevOps-GitHub"
}


resource "github_repository_collaborator" "collaborator" {
  #adding collaborator softservedata to repository
  repository = var.repo_name
  username   = "softservedata"
}

resource "github_branch" "develop" {
  repository = var.repo_name
  branch     = "develop"
}

resource "github_branch_default" "defbranch" {
  #making develop branch as a default
  repository = var.repo_name
  branch     = github_branch.develop.branch
}

resource "github_branch_protection" "develop_protection" {

  repository_id = data.github_repository.repo_name.id
  pattern       = "develop"
  required_pull_request_reviews {
    required_approving_review_count = 2
  }
}

resource "github_branch_protection" "main_protection" {
  #main branch protection rule
  repository_id = data.github_repository.repo_name.id
  pattern       = "main"

  required_pull_request_reviews {
    dismiss_stale_reviews      = true
    require_code_owner_reviews = true
  }
}

resource "github_repository_file" "soft_codeowner" {
  repository = var.repo_name
  branch = "develop"
  content = "* @softservedata"
  file = "CODEOWNERS"
}

resource "github_repository_file" "pull_request_file" {
  repository = var.repo_name
  file = ".github/pull_request_template.md"
  content = <<EOF
      ## Describe your changes

    ## Issue ticket number and link

    ## Checklist before requesting a review
    - [ ] I have performed a self-review of my code
    - [ ] If it is a core feature, I have added thorough tests
    - [ ] Do we need to implement analytics?
    - [ ] Will this be part of a product update? If yes, please write one phrase about this update
EOF
}

resource "github_repository_deploy_key" "deploy_key" {
  title      = "DEPLOY_KEY"
  repository = var.repo_name
  key        = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJr8ocXgTjWHOD5AfQZMfQ8Md+LvKyCeEUgqfkbzNepU postnikov@mail.com"
  read_only  = "false"
}

resource "github_repository_webhook" "discord_webhook" {
  repository = var.repo_name
  events = ["pull_request"]
  
  configuration {
    url = "https://discord.com/api/webhooks/1137122289633198110/MtNHA9ieOGVeg0oHuvlBMtnfJuBi-iNGpqpkxZxO_u4IJ9XSHRFClerRZlOxdS70JU6o/github"
    content_type = "form"

  }
}

resource "github_actions_secret" "PAT" {
  repository = var.repo_name
  secret_name = "PAT"
  plaintext_value = var.PAT
}


