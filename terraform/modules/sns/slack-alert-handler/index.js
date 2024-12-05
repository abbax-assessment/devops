const handler = async (event) => {
  try {

    console.log('Received event:', JSON.stringify(event, null, 2));
    const snsMessage = JSON.parse(event.Records[0].Sns.Message);
    const slackMessage = formatSlackMessage(snsMessage);
    const slackWebhookUrl = process.env.SLACK_WEBHOOK_URL;

    const response = await fetch(slackWebhookUrl, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(slackMessage),
    });

    if (!response.ok) {
      throw new Error(`Slack message failed with status: ${response.status}`);
    }

    console.log('Message sent to Slack successfully');
    return { statusCode: 200, body: 'Message sent to Slack successfully' };
  } catch (error) {
    console.error('Error sending message to Slack:', error);
    return { statusCode: 500, body: `Error sending message: ${error.message}` };
  }
};

function formatSlackMessage(snsMessage) {
  let slackMessage = {};
  if (snsMessage.AlarmName) {
    slackMessage = formatAlertMessage(snsMessage);
  } else {
    slackMessage.text = `Unhandled message received:\n${snsMessage}`
  }

  return slackMessage;
}

function formatAlertMessage(message) {
  const { AlarmName, NewStateValue, NewStateReason, StateChangeTime, Region, Trigger } = message;
  const environment = process.env.ENVIRONMENT.toUpperCase();

  // Define color based on alarm state
  const stateColors = {
    OK: "good", // Green
    ALARM: "danger", // Red
    INSUFFICIENT_DATA: "warning", // Yellow
  };

  return {
    attachments: [
      {
        color: stateColors[NewStateValue] || "warning",
        title: `CloudWatch Alarm: ${AlarmName}`,
        text: `*Environment*: ${environment}\n*State:* ${NewStateValue}\n*Reason:* ${NewStateReason}`,
        fields: [
          {
            title: "Region",
            value: Region,
            short: true,
          },
          {
            title: "State Change Time",
            value: new Date(StateChangeTime).toLocaleString(),
            short: true,
          },
          {
            title: "Metric",
            value: `${Trigger.MetricName} (${Trigger.Namespace})`,
            short: true,
          },
          {
            title: "Threshold",
            value: `> ${Trigger.Threshold}`,
            short: true,
          }
        ],
        footer: "AWS CloudWatch",
        ts: Math.floor(new Date(StateChangeTime).getTime() / 1000), // Slack uses Unix timestamp for footer
      },
    ],
  };
}

exports.handler = handler;