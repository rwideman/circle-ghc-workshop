FROM amazonlinux
WORKDIR /root/ghc
COPY . ./
RUN yum update -y &&\
    yum install -y tar zip gzip httpd &&\
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash &&\
    . ~/.nvm/nvm.sh &&\
    nvm install node &&\
    npm install &&\
    npm run webpack &&\
    cp -a index.html data.js assets build /var/www/html/
ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]
