# Abenteuerleben Rails version


## Guidelines

- Everything is English except German in
  * Links
  * Linked ids (ex. index page 'kontakt')
  * Text content


## Deployment

### Digital Ocean Rails App
Just push the changes to origin/main via a pull request and the app will pick up the changes
automatically and rebuild + deploy the updated application

### Dokku Droplet
TDB
Currently:
- merge changes via pull request to main
- pull main locally
- merge main to dokku/main
- push dokkku/main to remote