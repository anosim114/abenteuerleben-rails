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


## Mailtrap DNS Settings
```
CNAME bwyjwe53mox5a1eq.abenteuerleben-ev.de -> smtp.mailtrap.live
TXT abenteuerleben-ev.de -> v=spf1 include:_spf.smtp.mailtrap.live ~all
CNAME rwmt1._domainkey.abenteuerleben-ev.de -> rwmt1.dkim.smtp.mailtrap.live
CNAME rwmt2._domainkey.abenteuerleben-ev.de -> rwmt2.dkim.smtp.mailtrap.live
TXT _dmarc.abenteuerleben-ev.de -> v=DMARC1; p=none; rua=mailto:dmarc@smtp.mailtrap.live; ruf=mailto:dmarc@smtp.mailtrap.live; rf=afrf; pct=100
CNAME mt-link.abenteuerleben-ev.de -> t.mailtrap.live
```

### Configuring EMail sending
For sending helper registration emails configure the action_mailer, for this set the `emailUser` and `emailPass`
environment variables in production to your Mailtrap credentials.
