properties([buildDiscarder(logRotator(numToKeepStr: '50', artifactNumToKeepStr: '15')), durabilityHint('PERFORMANCE_OPTIMIZED')])
node('linux') {

    currentBuild.result = "SUCCESS"

    try {

	stage('Checkout'){
	
		  properties([pipelineTriggers([[$class: 'GitHubPushTrigger'], pollSCM('H/15 * * * *')])])
          checkout scm

       }

       stage('EnvironmentTest'){
	   
         env.NODE_ENV = "IBM_HACATHON"

         print "Environment will be : ${env.NODE_ENV}"

         print "Build number will be : ${env.BUILD_NUMBER}"

         print "Build number will be : ${env.BRANCH_NAME}"

         sh 'Previous_BNO=$(($BUILD_NUMBER-1))'

         sh 'echo $Previous_BNO'         

       }


       stage('Precheck Docker'){

	    echo ' Precheck intiated.................................'
			
            sh 'cp $WORKSPACE/Dockerfile ../'
			
	    sh 'docker ps -f name=cloudwaveapp_jatt_$Previous_BNO -q | xargs --no-run-if-empty docker container stop'

            sh 'docker container ls -a -fname=cloudwaveapp_jatt_$Previous_BNO -q | xargs -r docker container rm'

       }


       stage('Build_Docker_Image'){



         echo 'Push to Repo..........'

         sh 'cd ../ && pwd'

         sh 'docker images && docker ps -a'

       //sh 'docker build -t cloudwaveapp_jat_${BUILD_NUMBER} .'
		 
		 echo 'Push to Repo is completed..........'

       }
	   
	   stage('Image_Push2Dockerhub'){

			echo 'Push to Repo'

          //sh 'docker run -d --name cloudwaveapp_jatt_${BUILD_NUMBER} -p 7600:7600 -p 7800:7800 -p 7843:7843 --env LICENSE=accept --env ACE_SERVER_NAME=ACESERVER cloudwaveapp_ars_10'

           // sh 'docker login -u bamishr -p "203420ba@BL"'

            //sh 'docker tag cloudwaveapp_jatt_10 bamishr/cloudwaveapp_ars_${BUILD_NUMBER}:Latest'

           // sh 'docker push  bamishr/cloudwaveapp_jatt_${BUILD_NUMBER}:Latest'
		  // sh 'docker login -u admin -p admin 3.14.14.234:8083'

		// sh 'docker tag cloudwaveapp_jat_8 3.14.14.234:8083/cloudwaveapp_jatt_${BUILD_NUMBER}'

		// sh 'docker push  3.14.14.234:8083/cloudwaveapp_jatt_${BUILD_NUMBER}'
	   
		}
		
        stage('Docker_Image_Deployment'){

         echo 'Image Deployment started ....................'

         sh 'docker run -d --name cloudwaveapp_jatt_${BUILD_NUMBER} -p 7600:7600 -p 7800:7800 -p 7843:7843 --env LICENSE=accept --env ACE_SERVER_NAME=ACESERVER cloudwaveapp_jat_10'
		 
        echo 'Deployment is completed......................'            

        }

       stage('Cleanup'){

         echo 'images prune and cleanup'

           sh 'docker images'

           sh 'docker ps -a'

           sh 'docker ps'  

        

       }
	     node('master') {	    

	 stage('serverless_function_deployment'){		 

         echo 'Serverless function deployment intiated......'

          // sh 'ibmcloud login --apikey _3FrUqNXxk3PownmW3wua5P7DNDQtCdeLbEegFTom1Hh -r "eu-gb" -a cloud.ibm.com -o "Badrish.Mishra-CIC@ibm.com"  -s "dev"'

          // sh 'ibmcloud target -o Badrish.Mishra-CIC@ibm.com -s dev'

          // sh 'docker login -u bamishr -p "203420ba@BL"'
          // sh 'ibmcloud fn action create IBMSERVERLESS_FN_$BUILD_NUMBER --docker bamishr/cloudwaveapp_ars_1'        



       }

	    }
    }

    catch (err) {

        currentBuild.result = "FAILED"

        step([$class: 'Mailer',

          notifyEveryUnstableBuild: true,

          recipients: 'badrish.mishra-cic@ibm.com',

          sendToIndividuals: true])          

        throw err

    }



}
