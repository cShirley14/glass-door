#!/usr/bin/env groovy

pipeline {
  agent any

  triggers {
    cron('H * * * *')
  }

  stages {
    stage('Build') {
      steps {
        sh'''#!/bin/bash
              env
        '''
      }
    }
  }
}