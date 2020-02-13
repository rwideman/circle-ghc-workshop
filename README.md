# CircleCI - Grace Hopper Jeopardy

## Run locally - Host

Run the following:

    npm install
    npm run webpack

Then open index.html in your browser.

## Run locally - Docker

In terminal / PuTTY session:

    docker pull amazonlinux
    containerId=$(docker run -itd amazonlinux /bin/bash)
    docker exec -it $containerId /bin/bash

    yum update -y
    yum install -y tar nano git httpd
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
    . ~/.nvm/nvm.sh
    nvm install node
    node -e "console.log('Running Node.js ' + process.version)"
    cd ~ && git clone https://github.com/YOUR_GITHUB_PUBLIC_FORK_HERE/circle-ghc-workshop.git
    cd circle-ghc-workshop
    npm install
    npm run webpack

In a new terminal / PuTTY session:

    docker commit containerId ghc:1.0
    docker run -itd -p 8000:80 ghc:1.0 /bin/bash

In your browser visit: ```http://localhost:8000"

## Deploy on AWS

### Note: 
#####CircleCI requires IAM user access key id + secret key. Create environmental variables for these values in CircleCI web console under project system gear icon:

    AWS_ACCESS_KEY_ID
    AWS_SECRET_ACCESS_KEY

This solution uses CircleCI to deploy EC2 resources using AWS CloudFormation.  It can be used as an example application in a workshop, with multiple stacks in the same account.

Create shared resources (create once):
```
aws cloudformation deploy --stack-name ghc-workshop-shared-resources --template-file cfn/shared_resources.yml --capabilities CAPABILITY_NAMED_IAM --parameter-overrides WorkshopName="ghc-workshop"
```

Create website resources (can create multiple stacks for a workshop):
```
aws cloudformation deploy --stack-name ghc-workshop-application-1 --template-file cfn/application.yml --parameter-overrides SharedResourceStack="ghc-workshop-shared-resources"
```

Once the deployment completes, go to the application URL:
```
aws cloudformation describe-stacks --stack-name ghc-workshop-application-1 --query 'Stacks[0].Outputs[?OutputKey==`Url`].OutputValue' --output text
```

Cleanup:
```
Delete Stacks:

aws cloudformation delete-stack --stack-name ghc-workshop-shared-resources

aws cloudformation delete-stack --stack-name ghc-workshop-application-1
```

## Credits
* Based on [React Trivia](https://github.com/ccoenraets/react-trivia)
* Grace Hopper clip art by [gingercoons](https://openclipart.org/detail/137533/grace-hopper)

