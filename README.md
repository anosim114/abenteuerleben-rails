# Abenteuerleben Rails version


## Guidelines

- Everything is English except German in
  * Links
  * Linked ids (ex. index page 'kontakt')
  * Text content

## Development

### Needed tools:
- Text editor (vim, helix, vscode, intellij one)
- Act (for running pipeline locally)
- Git (for source control)
- Ruby (for development)
- A browser (also for development)

## Deployment

### Github Actions
Github actions automatically deploys all changes to master to the dokku aleben environment

## Cookbook (Answer to questions and ready to use solutions in a whole package)

### Error 16, can't use bundle in Github actions
- Run `bundle lock --add-platform x86_64-linux`
  * [See here](https://ryuichirosuzuki.com/posts/rails-github-action-exit-with-code-16/)