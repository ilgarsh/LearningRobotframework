import SocketServer
from Handler import MyHandler

PORT = 8002

httpd = SocketServer.TCPServer(("", PORT), MyHandler)

print "serving at port", PORT
httpd.serve_forever()