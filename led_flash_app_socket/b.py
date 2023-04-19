import socket

SOCKET_FILE = '/tmp/mysocket'  # Path to the socket file

with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as s:
    s.connect(SOCKET_FILE)
    s.sendall(b'Hello, world')
    data = s.recv(1024)

print('Received', repr(data))
