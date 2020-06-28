FROM ibmcom/ace

RUN pwd

ENV GITCODE=IBMACEDEPLOYMENT_JAT_master

ENV BAR2=CloudWave_v1_Transactions_JATIN.bar

COPY ./$GITCODE /tmp

#RUN bash -c 'cp -r /var/jenkins_home/workspace/pipelinejob_master/ /tmp'

RUN ls -laR /tmp/*

#RUN bash -c 'source /opt/ibm/ace-11/server/bin/mqsiprofile'

RUN bash -c 'mqsipackagebar -a /tmp/CloudWave_v1_Transactions_JATIN.bar -w /tmp/ -k CloudWave_v1_Transactions -i'

#RUN '. /opt/ibm/ace-11/server/bin/ mqsiprofile && mqsipackagebar'



RUN bash -c 'mqsicreateworkdir /home/aceuser/ace-server && mqsibar -w /home/aceuser/ace-server -a /tmp/$BAR2 -c'

RUN sed -i 's/adminRestApiPort/#adminRestApiPort/g' /home/aceuser/ace-server/server.conf.yaml
