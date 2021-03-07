pipeline{
    agent any
    tools{
        maven 'maven'
    }
    
    stages{
    stage ('Checkout Code')
		{
			steps
			{
				checkout scm
			}
		}
		stage ('Build Code')
		{
			steps
			{
				bat "mvn install"
			}
		}
		stage ('Unit Testing')
		{
			steps
			{
				bat "mvn test"
			}
		}
	  
    
		stage ('Sonar Analysis')
		{
			steps
			{
				withSonarQubeEnv("Test_Sonar") 
				{
					bat "mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.2:sonar"
				}
			}
		}
    
	    stage ('Upload to Artifactory')
		{
			steps
			{
				rtMavenDeployer (
                    id: 'deployer',
                    serverId: 'local@artifactory',
                    releaseRepo: 'ci-cd-pro-rohan',
                    snapshotRepo: 'ci-cd-pro-rohan'
                )
                rtMavenRun (
                    pom: 'pom.xml',
                    goals: 'clean install',
                    deployerId: 'deployer',
                )
                rtPublishBuildInfo (
                    serverId: 'local@artifactory',
                )
			}
		}
	    
	    stage('Build Docker Image')
    		{		
            		steps
				{
                		bat "docker build -t rohan-aws-pro:latest ."
            			}
		}
	    stage('Push Docker Image to ECR')
	    {
		    steps{
			    script
			    {
			   docker.withRegistry('https://186319575019.dkr.ecr.us-east-2.amazonaws.com/rohan-aws-pro', 'ecr:us-east-2:myaws_accessid') {
                        docker.image('rohan-aws-pro').push('latest')
			    }
			    }
		    }
	    }
	 
    }
    post{
        success{
            bat "echo Successfully completed CI Flow and uploaded image to ECR. Please spin up containers using ECS now"
        }
    }
    
}
