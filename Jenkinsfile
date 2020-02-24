node {
    def app

    stage('Clone repository') {

        checkout scm
    }

    stage('Build image') {

        app = docker.build("rafael1abrao/node")
    }

    stage('Push image') {
        /* Finally, we'll push the image with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }

    stage('Pull image'){

    	docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            def image
		    image = docker.image('rafael1abrao/node:latest')
        	image.pull()
    	}
    }

    stage('Run image'){

    	docker.image('rafael1abrao/node:latest').withRun('-p 8000:3000') {
            /* do things */
        }
    }
}