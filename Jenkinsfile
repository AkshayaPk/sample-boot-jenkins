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
          sh "${mvnHome}/bin/mvn sonar:sonar"
        }
    }
    
   stage("Quality Gate Status Check"){
          timeout(time: 1, unit: 'HOURS') {
              def qg = waitForQualityGate()
              if (qg.status != 'OK') {
                  error "Pipeline aborted due to quality gate failure: ${qg.status}"
              }
          }
      }
   
   stage('Email Notification'){
      mail bcc: '', body: '''Hi Welcome to jenkins email alerts
      Thanks
      Hari''', cc: '', from: '', replyTo: '', subject: 'Jenkins Job', to: 'akshayp@revature.com'
   }
  

}
