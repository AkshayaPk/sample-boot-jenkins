node{
   stage('SCM Checkout'){
     git 'https://github.com/AkshayaPk/sample-boot-jenkins'
   }
   stage('Compile-Package'){
      // Get maven home path
      def mvnHome =  tool name: 'mitchell-rms-mvn', type: 'maven'   
      sh "${mvnHome}/bin/mvn package"
   }
   
   stage('SonarQube Analysis') {
        def mvnHome =  tool name: 'mitchell-rms-mvn', type: 'maven'
        withSonarQubeEnv('mitchell-rms') { 
          sh "${mvnHome}/bin/mvn sonar:sonar \
                   -Dsonar.projectKey=AkshayaPk_sample-boot-jenkins \
                   -Dsonar.organization=akshayapk-github \
                   -Dsonar.branch.name=master \
                   -Dsonar.host.url=https://sonarcloud.io \
                   -Dsonar.login=8b35d2d04ebd56846cefaf1e7d1332d8ddcc5a9a"
           
        }
    }
    
   stage("Quality Gate Status Check"){
          timeout(time: 3, unit: 'HOURS') {
              def qg = waitForQualityGate()
              if (qg.status != 'OK') {
                  error "Pipeline aborted due to quality gate failure: ${qg.status}"
              }
          }
      }
   
   stage('Build Docker Image'){
    sh 'docker build -t sample .'
      }
   
   stage('Tag Docker Image'){
    sh 'docker tag sample:latest 367484709954.dkr.ecr.us-west-1.amazonaws.com/sample:latest'
      }
   
   stage('Docker Login & Push to ECR'){
      sh '$(AWS_SHARED_CREDENTIALS_FILE=/var/lib/jenkins/credentials AWS_CONFIG_FILE=/var/lib/jenkins/config aws ecr get-login --no-include-email --region us-west-1 )' 
      
   }
  
   
   stage('Force New Deployment'){
    sh 'AWS_SHARED_CREDENTIALS_FILE=/var/lib/jenkins/credentials AWS_CONFIG_FILE=/var/lib/jenkins/config aws ecs update-service --cluster mitchell-rms --service sample-service --task-definition sample-task-def --force-new-deployment'      
      }
   
}
