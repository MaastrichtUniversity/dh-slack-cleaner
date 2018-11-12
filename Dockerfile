FROM kfei/slack-cleaner

ADD ./slack-clean.sh /bin/
RUN chmod a+x /bin/slack-clean.sh


ENTRYPOINT ["/bin/slack-clean.sh"]