FROM fluent/fluentd:edge
USER root

ADD ./config/fluent.conf /fluentd/etc/fluent.conf

RUN apk add --update --virtual .build-deps \
    sudo build-base ruby-dev \
 && sudo gem install \
        fluent-plugin-elasticsearch \
        fluent-plugin-rewrite-tag-filter \
 && sudo gem sources --clear-all \
 && apk del .build-deps \
 && rm -rf /var/cache/apk/* \
           /home/fluent/.gem/ruby/2.4.0/cache/*.gem \
&& mkdir /logs 