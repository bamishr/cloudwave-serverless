FROM ibmcom/ace

ENV GITCODE=CloudWave_v1_Transactions

ENV BAR2=CloudWave_v1_Transactions_bad.bar

COPY ./$GITCODE /tmp

RUN ls -laR /tmp/*

#RUN bash -c 'source /opt/ibm/ace-11/server/bin/mqsiprofile'

RUN bash -c 'mqsipackagebar -a /tmp/CloudWave_v1_Transactions_JAT.bar -w /tmp/ -k CloudWave_v1_Transactions -i'

#RUN '. /opt/ibm/ace-11/server/bin/ mqsiprofile && mqsipackagebar'



RUN bash -c 'mqsicreateworkdir /home/aceuser/ace-server && mqsibar -w /home/aceuser/ace-server -a /tmp/$BAR2 -c'

RUN sed -i 's/adminRestApiPort/#adminRestApiPort/g' /home/aceuser/ace-server/server.conf.yaml
