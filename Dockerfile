FROM kfei/slack-cleaner

ADD ./slack-clean.sh /bin/
RUN chmod a+x /bin/slack-clean.sh

ENV LOGSTASH_TAGS=SLACK_CLEANER,AUX

ENTRYPOINT ["/bin/slack-clean.sh"]
