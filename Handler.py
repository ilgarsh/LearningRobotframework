import re
from BaseHTTPServer import BaseHTTPRequestHandler

valid_message = re.compile(r"^[a-zA-Z0-9_]+$")


class MyHandler(BaseHTTPRequestHandler):

    def do_GET(self):

        if "iws" in self.headers.keys():
            self.send_response(200)
            ln = len(self.headers['iws'])
            if 1 < ln < 12 \
                    and valid_message.match(self.headers['iws']):

                self.send_header("Accepted", "true")

            else:
                self.send_header("Accepted", "false")

        else:
            self.send_response(400)

        self.end_headers()
        return
