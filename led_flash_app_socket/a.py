import socket
import os

SOCKET_FILE = '/tmp/mysocket'  # Path to the socket file

if os.path.exists(SOCKET_FILE):
    os.remove(SOCKET_FILE)

with socket.socket(socket.AF_UNIX, socket.SOCK_STREAM) as s:
    s.bind(SOCKET_FILE)
    s.listen()
    conn, addr = s.accept()
    with conn:
        print('Connected by', addr)
        while True:
            data = conn.recv(1024)
            if not data:
                break
            conn.sendall(data)
