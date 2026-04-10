#!/usr/bin/env bash
# Publishes a message to billing-events and reads it from audit-events-queue
# to verify the auto-forwarding works.
#
# Requires: curl (uses the RabbitMQ Management HTTP API)

set -euo pipefail

BASE="http://localhost:15672/api"
AUTH="guest:guest"

echo "--- Publishing message to billing-events exchange ---"
curl -s -u "$AUTH" -X POST "$BASE/exchanges/%2F/billing-events/publish" \
  -H "content-type: application/json" \
  -d '{
    "properties": {},
    "routing_key": "",
    "payload": "{\"invoice_id\": \"INV-001\", \"amount\": 99.99}",
    "payload_encoding": "string"
  }' | jq .

echo ""
echo "--- Reading message from audit-events-queue (forwarded) ---"
curl -s -u "$AUTH" -X POST "$BASE/queues/%2F/audit-events-queue/get" \
  -H "content-type: application/json" \
  -d '{
    "count": 1,
    "ackmode": "ack_requeue_false",
    "encoding": "auto"
  }' | jq .
