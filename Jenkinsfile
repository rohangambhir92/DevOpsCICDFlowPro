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
                    serverId: '123456789@artifactory',
                    releaseRepo: 'devopsnagpqa2020cdflow',
                    snapshotRepo: 'devopsnagpqa2020cdflow'
                )
                rtMavenRun (
                    pom: 'pom.xml',
                    goals: 'clean install',
                    deployerId: 'deployer',
                )
                rtPublishBuildInfo (
                    serverId: '123456789@artifactory',
                )
			}
		}
	    stage('Build Image')
    		{		
            		steps
				{
                		bat "docker build -t myfirstimage:${BUILD_NUMBER} ."
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
