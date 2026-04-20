const { EC2Client, StartInstancesCommand, StopInstancesCommand } = require('@aws-sdk/client-ec2');

const ec2 = new EC2Client({ region: 'us-east-1' });
const params = { InstanceIds: ['i-0eabb5950d7553d6b'] };

exports.startEC2Instance = async (event) => {
    try {
        const data = await ec2.send(new StartInstancesCommand(params));
        console.log('Porteiro started successfully:', data);
        return {
            statusCode: 200,
            body: JSON.stringify({ message: 'Porteiro started successfully', data }),
        };
    } catch (error) {
        console.error('Error starting Porteiro:', error);
        return {
            statusCode: 500,
            body: JSON.stringify({ message: 'Error starting Porteiro', error }),
        };
    }
};

exports.stopEC2Instance = async (event) => {
    try {
        const data = await ec2.send(new StopInstancesCommand(params));
        console.log('Porteiro stopped successfully:', data);
        return {
            statusCode: 200,
            body: JSON.stringify({ message: 'Porteiro stopped successfully', data }),
        };
    } catch (error) {
        console.error('Error stopping Porteiro:', error);
        return {
            statusCode: 500,
            body: JSON.stringify({ message: 'Error stopping Porteiro', error }),
        };
    }
};
