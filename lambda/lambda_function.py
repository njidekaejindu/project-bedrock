import json

def lambda_handler(event, context):
    for record in event.get("Records", []):
        key = record.get("s3", {}).get("object", {}).get("key", "unknown")
        print(f"Image received: {key}")
    return {"statusCode": 200, "body": json.dumps("ok")}
