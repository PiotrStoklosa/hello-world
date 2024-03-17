FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y curl unzip zip

RUN curl -s "https://get.sdkman.io" | bash
RUN /bin/bash -c "source /root/.sdkman/bin/sdkman-init.sh && sdk install java 8.0.402-amzn"
RUN /bin/bash -c "source /root/.sdkman/bin/sdkman-init.sh && sdk install kotlin"
RUN /bin/bash -c "source /root/.sdkman/bin/sdkman-init.sh && sdk install gradle"

ENV PATH="/root/.sdkman/candidates/java/current/bin:/root/.sdkman/candidates/kotlin/current/bin:/root/.sdkman/candidates/gradle/current/bin:${PATH}"

COPY . /root/project/

WORKDIR /root/project

RUN /bin/bash -c "source /root/.sdkman/bin/sdkman-init.sh && gradle build"

CMD ["/bin/bash", "-c", "source /root/.sdkman/bin/sdkman-init.sh && gradle run"]
