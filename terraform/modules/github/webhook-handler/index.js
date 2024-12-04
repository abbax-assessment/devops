const AWS = require('aws-sdk');
const firehose = new AWS.Firehose();

exports.handler = async (event) => {
    try {
        const payload = JSON.parse(event.body);
        console.log(JSON.stringify(event));
        const event_type = event.headers["x-github-event"];
        const project = payload.repository.name;
        const branch = (
            (payload.workflow_job && payload.workflow_job.head_branch) ||
            (payload.workflow_run && payload.workflow_job.head_branch) ||
            (payload.ref && payload.ref.split("/").pop()) ||
            (payload.pull_request && payload.pull_request.head.ref)
        );

        console.log("Received github event", {
            project,
            branch,
            event_type,
            payload
        });
        const record = {
            Data: JSON.stringify({
                project,
                branch,
                event_type,
                ...payload,
            }),
        };

        const params = {
            DeliveryStreamName: process.env.FIREHOSE_STREAM_NAME,
            Record: record,
        };

        const result = await firehose.putRecord(params).promise();
        console.log('Record sent to Firehose:', result);
    } catch (error) {
        console.error('Error sending record to Firehose:', error);
        throw error;
    }
};


