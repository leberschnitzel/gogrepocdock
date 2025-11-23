# GOG Repo Sync Docker

This repository provides a Docker setup for synchronizing GOG games using the `gogrepoc` https://github.com/Kalanyr/gogrepoc Python script. The Docker setup uses `docker-compose` to manage the container configuration and execution.

## Getting Started

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/) (version 20.10 or later)
- [Docker Compose](https://docs.docker.com/compose/install/) (version 1.29 or later)

### Setup

1. **Clone the Repository**

   Clone this repository to your local machine:

   ```bash
   git clone https://github.com/leberschnitzel/gogrepocdock.git
   cd gogrepocdock
   ```

2. **Configure Docker Compose**

Open the docker-compose.yaml file and configure the environment variables:

Example configuration:

```yaml
version: '3.9'
services:
    gogrepoc:
        image: leberschnitzel/gogrepocdock:latest
        volumes:
            - ./Downloads:/gogrepocdock/downloads
        environment:
            - goguser=your_gog_username #Your GOG Username (required).
            - gogpassword=your_gog_password #Your GOG Password (required).
            - updatecommands=-os windows linux -lang en #Configuration for update commands. See https://github.com/Kalanyr/gogrepoc for information (required).
            - downloadcommands=-dryrun #Configuration for download commands (optional). Remove -dryrun when you're ready to start actual downloads (optional).
            - repeat=1w #Interval for syncing. Use formats like 1w for 1 week or 3d for 3 days Default is 1w (optional)
            - clean=true #if set to true it will run the "clean" commands to find files unknown to the manifest
            - trash=false #if set to true it will run the "trash" commands, deleting the previousely found files.
```

3. **Create the Downloads Directory**

Make sure the Downloads directory exists on your host machine where you want the downloads to be stored.

4. **Start the Container**
Run the following command to start the container with docker-compose:
```bash
docker-compose up
```
This command will pull the Docker image if not already available, create the container, and start the synchronization process. It will run until it fails for whatever reason. It will repeat the sync as instructed, standard every week. If the actual sync will run for longer than a week (or other given time), it will restart the sync as soon as it is finished.