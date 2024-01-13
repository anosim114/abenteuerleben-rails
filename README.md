# Abenteuerleben Rails version

## Deployment

Github actions automatically deploys all changes to master to the dokku environment (production has to be triggered manually as long as no customer-journey and e2e tests are in place)

## Cookbook (Answer to questions and ready to use solutions in a whole package)

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

### Environment Cleanup
- `docker system prune -a`
- `dokku cleanup`
