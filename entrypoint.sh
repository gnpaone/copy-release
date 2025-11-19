#!/bin/sh
set -e

REPO="${GITHUB_ACTION_REPOSITORY}"
TAG="${GITHUB_ACTION_REF}"
TOKEN="$INPUT_GITHUB_TOKEN"

echo "Action repo: $REPO"
echo "Action version (tag): $TAG"

RELEASE_JSON=$(curl -s \
  -H "Authorization: Bearer $TOKEN" \
  "https://api.github.com/repos/$REPO/releases/tags/$TAG")

JAR_URL=$(echo "$RELEASE_JSON" | jq -r '.assets[] | select(.name=="app.jar") | .url')

if [ -z "$JAR_URL" ] || [ "$JAR_URL" = "null" ]; then
  echo "::error::app.jar not found in release $TAG of $REPO"
  exit 1
fi

echo "Downloading app.jar from $REPO@$TAG…"
curl -L \
  -H "Authorization: Bearer $TOKEN" \
  -H "Accept: application/octet-stream" \
  "$JAR_URL" \
  -o /app/app.jar

echo "Running app.jar"
exec java -jar /app/app.jar
