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
//Added quality gate check    
   stage("Quality Gate Status Check"){
          timeout(time: 3, unit: 'HOURS') {
              def qg = waitForQualityGate()
              if (qg.status != 'OK') {
                  error "Pipeline aborted due to quality gate failure: ${qg.status}"
              }
          }
      }
   
}
