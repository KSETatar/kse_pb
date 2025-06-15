from slack_sdk import WebClient

client = WebClient(token='xoxb-9024374351126-9024493904003-9xArLdYy9HZkS5V2WV84py77')

response = client.chat_postMessage(
    channel='#all-op-group-1',
    text="2"
)
print(response)