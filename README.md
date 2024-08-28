# Mailer

A docker container which sends out a mail over an (not integrated) mail server.

I use this to send notification mails from CI flows most of the time.

## Usage

To send a mail every config option needs to be set via environment variable of your `docker run`.
For example:

```shell
docker run --rm -it \
  -e SSMTP_SERVER "<your mail server>" \
  -e SSMTP_PORT 587 \
  -e SSMTP_TLS False \
  -e SSMTP_FROM "<Your email address>" \
  -e SSMTP_TO "<receivers email address>" \
  -e SSMTP_USER "<username if required>" \
  -e SSMTP_PASS "<pass if required>" \
  -e SSMTP_SUBJECT "Test" \
  -e SSMTP_MESSAGE "This is a Test" \
  ghcr.io/poeschl/docker-mailer
```

An docker-compose with all possible variabels is also provided in the repository.

### GitLab

To use it in a GitLab CI pipeline insert the following job snippet into your `gitlab-ci.yaml`.
It is intended to send a mail to several emails on job failure.

```yaml
notification-mail:
  stage: test
  rules:
    - when: on_failure
  image: ghcr.io/poeschl/docker-mailer
  needs: []
  parallel:
    matrix:
      - EMAIL: mail1@mail.de
      - EMAIL: mail2@mail.de
  variables:
    SSMTP_SERVER: "<your mail server>"
    SSMTP_PORT: 587
    SSMTP_TLS: False
    SSMTP_FROM: "<Your email address>"
    SSMTP_TO: "$EMAIL"
    SSMTP_USER: "<username if required>"
    SSMTP_PASS: "<pass if required>"
    SSMTP_SUBJECT: "Test"
    SSMTP_MESSAGE: "This is a Test"
```

