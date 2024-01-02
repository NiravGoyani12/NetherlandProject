def initProject(String projectName, String previousBuildNumber) {
    stage('Init project') {
        sh 'npm set cache .npm'
        sh 'npm ci --cache .npm'
        sh 'npm run clean'
        if (projectName && previousBuildNumber) {
            try {
                copyArtifacts(projectName: projectName, selector: specific(previousBuildNumber), filter: 'allure-results.zip, rerun.txt')
                unzip zipFile: 'allure-results.zip', dir: 'allure-results'
                sh 'del @execute.txt 2>/dev/null'
                sh "cp rerun.txt @execute.txt 2>/dev/null"
                sh "echo Sucessfully extracted build artifacts from job ${projectName}, build number ${previousBuildNumber}"
            }
            catch (e) {
                sh "echo Failed to get build artifacts from job ${projectName}, build number ${previousBuildNumber}"
            }
        }
        else {
            sh 'echo Skipping copy artifacts'
        }
    }
}

def lint() {
    stage('Lint') {
        String currentBranch = env.BRANCH.toLowerCase().trim()
        if (currentBranch == 'master') {
            sh "echo Skipping lint on branch ${currentBranch}"
        } else {
            sh 'npm run lint'
        }
    }
}

def buildProject() {
	stage('Build project') {
        sh 'npm run build'
	}
}

def startBrowserStackLocal(String driverName) {
    stage('Start BrowserStackLocal') {
        if (driverName.contains('browserstack')) {
            sh "/var/jenkins_home/bin/BrowserStackLocal --daemon start --key ngyfWofQtUzgjZuZzXMV --force-local --force --verbose"
        } else {
            echo "Skipping BrowserstackLocal stage"
        }
    }
}

return this