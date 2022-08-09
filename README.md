# snyk-container-test-sif

Simple proof of concept to test Singularity SIF container image with Snyk

#### Requirements
- *stacker* (https://github.com/project-stacker/stacker)
- *snyk* (https://github.com/snyk/cli)
- *squashfs-tools-ng* (https://github.com/AgentD/squashfs-tools-ng)
- bash, tar, grep, sed
- Local storage sufficient to hold image contents

#### Usage
    snyk-container-test-sif.sh [SIF_FILE]
