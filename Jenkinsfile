node {
    def app
    def remote = [:]
    remote.name = 'Wdcmldev01'
    remote.host = 'Wdcmldev01.westcom.com.br'
    remote.user = 'sisadmin'
    remote.password = 'adminsis'
    remote.allowAnyHosts = true

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
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials-rafa') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }

    stage('Remote SSH') {
      sshCommand remote: remote, command: "ls -lrt"
      sshCommand remote: remote, command: "for i in {1..5}; do echo -n \"Loop \$i \"; date ; sleep 1; done"
    }

    stage('Pull image'){

    	docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials-rafa') {
            def image
		    image = docker.image('rafael1abrao/node:latest')
        	image.pull()
    	}
    }

    stage('Run image'){

    	docker.image('rafael1abrao/node').withRun('-p 8000:3000') {
            /* do things */
        }
    }
}