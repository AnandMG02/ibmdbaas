const express = require('express');
const { exec } = require('child_process');
const fs = require('fs');
const path = require('path');

const token = 'sha256~2TSiQ1kZorfNBTQ7vPG4ChHhhldHjHFNLBqdxZvgB3E';
const server = 'https://c104-e.us-east.containers.cloud.ibm.com:32744';
const projectName = 'hackathon2023-mongo-t-mobile';

const app = express();
app.use(express.json());

app.get('/', (req, res) => {
  res.send('Server Working');
});

app.get('/pods', async (req, res) => {
  console.log("getting");
  try {
    const { stdout } = await exec(`oc login --token=${token} --server=${server} && oc project ${projectName}`);
    console.log(stdout);

    const { stdout: stdout2 } = await exec(`oc project ${projectName}`);
    console.log(stdout2);

    const response = await exec('oc get pods -o json');

    const pods = JSON.parse(response.stdout).items.map((pod) => ({
      clustername : pod.metadata.name,
      podip :  pod.status.podIP ,
      podport : pod.spec.containers[0].ports[0].containerPort ,
      mongoUser : pod.spec.containers[0].env[0].value ,
      url :  'mongodb://' +  pod.spec.containers[0].env[0].value  + ':' +  pod.spec.containers[0].env[1].value+ '@' + pod.status.podIP + ':' + pod.spec.containers[0].ports[0].containerPort + '/?authSource=admin' ,
      status : pod.status.phase
    }));

    console.log(pods);

    res.json(pods);

  } catch (error) {
    console.error('Error occurred during API request:', error);
    res.status(500).json({ error: 'Failed to fetch pod data' });
  }
});


app.post('/', (req, res) => {
  const data = req.body;

  const minPort = 27000; // Minimum port number
  const maxPort = 29999; // Maximum port number
  const randomPort = Math.floor(Math.random() * (maxPort - minPort + 1)) + minPort;

  const podName = data.cluster;

  const podSpec = {
    kind: 'Pod',
    metadata: {
      name: podName,
      labels: {
        app: 'mongo',
      },
    },
    spec: {
      containers: [
        {
          name: 'mongo',
          image: 'mongo:latest',
          ports: [
            {
              containerPort: randomPort,
              name: 'mongodb',
            },
          ],
          command: ['mongod', '--auth', '--port', randomPort.toString()],
          env: [
            {
              name: 'MONGO_INITDB_ROOT_USERNAME',
              value: data.user,
            },
            {
              name: 'MONGO_INITDB_ROOT_PASSWORD',
              value: data.pwd,
            },
          ],
        },
      ],
    },
  };
  
  const loginCommand = `oc login --token=${token} --server=${server} && oc project ${projectName}`;

  exec(loginCommand, (error, stdout, stderr) => {
    if (error) {
      console.error('Error logging in or setting project:', error);
      res.status(500).json({ error: 'Error logging in or setting project' });
      return;
    }

    const tempFilePath = path.join(__dirname, 'podSpec.json');

    fs.writeFile(tempFilePath, JSON.stringify(podSpec), (err) => {
      if (err) {
        console.error('Error writing pod specification to file:', err);
        res.status(500).json({ error: 'Error creating MongoDB pod' });
        return;
      }

      // Create MongoDB pod using oc command
    
      const createMongoDBPodCommand = `oc apply -f ${tempFilePath}`;
      console.log("Executing command:", createMongoDBPodCommand);
      exec(createMongoDBPodCommand, (error, stdout, stderr) => {
        fs.unlinkSync(tempFilePath); // Delete the temporary file

        if (error) {
          console.error('Error creating MongoDB pod:', error);
          res.status(500).json({ error: 'Error creating MongoDB pod' });
          return;
        }

        console.log('MongoDB pod created successfully.');
        res.json({ message: 'MongoDB pod created successfully' });
      });
    });
  });
});





const port = 3000;

app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
