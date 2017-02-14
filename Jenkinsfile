pipeline {
  agent {
    docker {
      image 'maven:3.3.9'
    }
  }


  stages {
    stage('Build') {
      steps {
        sh 'mvn -B clean package -DskipTests=true findbugs:findbugs'
      }
      post {
        success {
          step([$class: 'FindBugsPublisher', canComputeNew: false, defaultEncoding: '', excludePattern: '', healthy: '', includePattern: '', pattern: 'target/findbugsXml.xml', unHealthy: ''])
        }
      }
    }

    stage('Test') {
      when {
        branch '**/master'
      }
      steps {
        sh 'mvn -B clean package -Pintegration'
      }
      post {
        always {
          archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true, allowEmptyArchive: true
        }
        success {
          junit '**/target/surefire-reports/TEST-*.xml'
        }
        unstable {
          junit '**/target/surefire-reports/TEST-*.xml'
        }
      }
    }
    stage('Release') {
      when {
        branch '**/release-*'
      }
      steps {
        sh "mvn -B clean package -Prelease -Dversion='${env.BRANCH_NAME.drop(env.BRANCH_NAME.lastIndexOf('-'))}.$BUILD_NUMBER'"
      }
      post {
        always {
          archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true, allowEmptyArchive: true
        }
        success {
          junit '**/target/surefire-reports/TEST-*.xml'
        }
        unstable {
          junit '**/target/surefire-reports/TEST-*.xml'
        }
      }
    }
  }
}
