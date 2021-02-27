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
                    releaseRepo: 'aws-pro-repo',
                    snapshotRepo: 'aws-pro-repo'
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
                		bat "docker build -t rohan-aws-pro:${BUILD_NUMBER} ."
            			}
		}
	    stage('Push Image')
	    {
		    steps{
			    script
			    {
			    docker.withRegistry('https://186319575019.dkr.ecr.us-east-2.amazonaws.com/rohan-aws-pro', 'ecr:us-east-2:myaws_accessid') {
                        docker.image('rohan-aws-pro').push(${BUILD_NUMBER})
			    }
			    }
		    }
	    }
	    stage("Docker Deployment")
        	{
			steps
			{
                	bat "docker run --name myfirstcontainer -d -p 9050:8080 myfirstimage:${BUILD_NUMBER}"
        		}
		}
    }
    post{
        success{
            bat "echo success"
        }
    }
    
}
