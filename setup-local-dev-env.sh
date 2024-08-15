#!/bin/bash

set -eu

# TODO -> prerequisites
# 1. certain ports must be open
# 2. docker must be installed (maybe just for developing)
# 3. certain bash commands must be available (openssl)

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

DB_HOST='localhost'
DB_PORT='3033'
DB_NAME='mye'

MYE_WEB_UI_ROOT_URL='http://localhost:5173'

AUTH_JWT_SECRET=$(openssl rand -base64 32)

WEBAPP_SSH_PRIVATE_KEY="../mye-webapp/ssh/gh_private_key"

read -p "$(echo -e ${YELLOW}Enter the path to your github private SSH key: ${NC}) " FILE_PATH

if [ -f "$FILE_PATH" ]; then
  mkdir -p ../mye-webapp/ssh
  cp "$FILE_PATH" "$WEBAPP_SSH_PRIVATE_KEY"
  echo -e "${GREEN}File copied and renamed to 'gh_private_key'${NC}"
else
  echo -e "${RED}Error: The file does not exist.${NC}"
  exit 1
fi

# cd ..
# echo -e "${CYAN}[MYE] Cloning repositories...${NC}"
# TODO -> change clone ops to use ssh?
# # git clone https://github.com/ardeleanmarcel/mye-database.git mye-database
# # git clone https://github.com/ardeleanmarcel/Manage-your-expenses.git mye-webapp
# # git clone https://github.com/ardeleanmarcel/mye-APIs.git mye-api
# echo -e "${CYAN}[MYE] Cloning repositories complete.${NC}"

# echo -e "${CYAN}[MYE] Let's configure the local database!${NC}"

# read -p "DB User: " DB_USER
# read -p "DB Password: " DB_PASS

# cat <<EOF >./mye-database/.env
# NODE_ENV=development

# LOCAL_DB_HOST=$DB_HOST
# LOCAL_DB_PORT=$DB_PORT
# LOCAL_DB_NAME=$DB_NAME
# LOCAL_DB_USER=$DB_USER
# LOCAL_DB_PASS=$DB_PASS
# EOF

# cat <<EOF >./mye-database/docker/.env
# POSTGRES_DB=$DB_NAME
# POSTGRES_USER=$DB_USER
# POSTGRES_PASSWORD=$DB_PASS
# EOF

# echo -e "${CYAN}[MYE] Database .env files created.${NC}"
# echo -e "${CYAN}[MYE] We need a few more things for the API...${NC}"

# read -p "SendGrid API Key: " SENDGRID_API_KEY
# # TODO -> email source should be known (support@xpensmngr)
# read -p "Notification Email Source: " NOTIFICATION_EMAIL_SOURCE

# cat <<EOF >./mye-api/.env
# DB_HOST=$DB_HOST
# DB_PORT=$DB_PORT
# DB_NAME=$DB_NAME
# DB_USER=$DB_USER
# DB_PASS=$DB_PASS

# AUTH_JWT_SECRET=$AUTH_JWT_SECRET

# MYE_WEB_UI_ROOT_URL=$MYE_WEB_UI_ROOT_URL

# SENDGRID_API_KEY=$SENDGRID_API_KEY
# NOTIFICATION_EMAIL_SOURCE=$NOTIFICATION_EMAIL_SOURCE
# EOF

# echo -e "${CYAN}[MYE] API .env file created.${NC}"

# # TODO -> give host, port etc
# # echo "To connect to your local DB use the following: "

# # TODO -> should run a DB migration:latest and a seed
