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
