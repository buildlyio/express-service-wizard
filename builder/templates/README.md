# {{ displayed_name }}

## Development

Build the image:

```bash
docker build -t {{ service_name }} .
```

Run the web server:

```bash
docker run -p 3000:3000 --name {{ service_name }} {{ service_name }}
```

Open your browser with URL `http://localhost:3000`.
