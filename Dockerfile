# Use the official Jenkins image as the base image
FROM jenkins/jenkins:latest

# Switch to the root user for installation
USER root

# Update the package manager and install required packages
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common


# Add Docker's official GPG key
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

# Add Docker CE repository
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"

# Install Docker CE and tini
RUN apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io tini


# Optional: Install Docker Compose (uncomment the following lines if needed)
# USER root
# RUN curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# RUN chmod +x /usr/local/bin/docker-compose
# USER jenkins

# Optionally, configure Docker permissions (you may need to adjust this depending on your use case)
# RUN usermod -a -G docker jenkins

# Start Jenkins
ENTRYPOINT ["/bin/bash"]
