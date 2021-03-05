pipeline{
    agent any
    tools{
        maven 'maven'
    }
    
    stages{
    stage ('checkout')
		{
			steps
			{
				checkout scm
			}
		}
		stage ('Build')
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
	  
    /*  
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
    */
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
	    
	    stage('Build Image')
    		{		
            		steps
				{
                		bat "docker build -t ecr-rohan-pro:latest-sample-app-image-pro ."
            			}
		}
	    stage('Push Image')
	    {
		    steps{
			    script
			    {
			    docker.withRegistry('https://186319575019.dkr.ecr.us-east-2.amazonaws.com/ecr-rohan-pro', 'ecr:us-east-2:myaws_accessid') {
                        docker.image('ecr-rohan-pro').push('latest-sample-app-image-pro')
			    }
			    }
		    }
	    }
	    /*
	    stage("Docker Deployment")
        	{
			steps
			{
                	bat "docker run --name myfirstcontainer -d -p 9050:8080 myfirstimage:${BUILD_NUMBER}"
        		}
		}
		*/
    }
    post{
        success{
            bat "echo success"
        }
    }
    
}
