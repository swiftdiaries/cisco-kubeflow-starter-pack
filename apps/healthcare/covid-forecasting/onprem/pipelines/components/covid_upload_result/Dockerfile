FROM google/cloud-sdk:alpine

ADD ./src/upload_result.sh /bin/.
RUN chmod 755 /bin/upload_result.sh
ENTRYPOINT ["/bin/upload_result.sh"]
