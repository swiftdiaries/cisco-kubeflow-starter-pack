FROM google/cloud-sdk:alpine

ADD ./src/download_data.sh /bin/.
RUN chmod 755 /bin/download_data.sh
ENTRYPOINT ["/bin/download_data.sh"]
