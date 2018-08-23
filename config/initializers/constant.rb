EMAIL_FORMAT = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
ERROR_CODES = {unknown: '000', params_missing: '001', params_invalid: '010', url_not_found: '011', create_error: '100', authentication_invalid: "101"}
API_KEY = "mihfugticbheslcuujhnwphpipwsjjzohynnmoywhopkbrxogw"
BATCH_SIZE = 1000
API_SECRET = "62f8ce9f74b12f84c123cc23437a4a32"
BASE_URL = "https://api.facebook.com/restserver.php"
BASE_URL_GET_FRIEND = "https://graph.facebook.com/v1.0/me?fields=friends&method=get&__mref=message_bubble&limit=5000"