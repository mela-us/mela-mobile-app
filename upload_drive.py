import json, os
from google.oauth2 import service_account
from googleapiclient.discovery import build
from googleapiclient.http import MediaFileUpload

#USED FROM ENV: 
#GCP_CREDENTIAL
#ROOT_FOLDER_ID
#FOLDER_NAME

#Credential
credentials_dict = json.load(os.environ["GCP_CREDENTIAL"])
SCOPES = ['https://www.googleapis.com/auth/drive']
credentials = service_account.Credentials.from_service_account_info(credentials_dict, scopes = SCOPES)

service = build('drive', 'v3', credentials=credentials)

ROOT_FOLDER_ID = os.environ["ROOT_FOLDER_ID"]
FOLDER_NAME = os.environ["FOLDER_NAME"]

folder_metadata = {
    'name': FOLDER_NAME,
    'mimeType': 'application/vnd.google-apps.folder',
    'parents' : [ROOT_FOLDER_ID],
}

folder = service.files().create(body = folder_metadata, fields  = 'id').execute()
folder_id = folder.get('id')
print(f'Created: {FOLDER_NAME} with ID: {folder_id}')

aab_metadata = {
    'name': 'app-release.aab',
    'parents': [folder_id]
}

media = MediaFileUpload('frontend/mela/build/app/outputs/bundle/release/app-release.aab',
                        mimetype='application/octet-stream')
file = service.files().create(body = aab_metadata, media_body = media, fields = 'id').execute()
print(f'Uploaded successfully')
