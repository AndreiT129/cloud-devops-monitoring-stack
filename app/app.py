from flask import Flask, jsonify, Response
import os
import psycopg2
from prometheus_client import Counter, generate_latest

app = Flask(__name__)

REQUEST_COUNT = Counter("app_requests_total", "Total number of HTTP requests")

def get_db_connection():
    return psycopg2.connect(
        host=os.getenv("DB_HOST", "db"),
        database=os.getenv("DB_NAME", "devopsdb"),
        user=os.getenv("DB_USER", "devopsuser"),
        password=os.getenv("DB_PASSWORD", "devopspass")
    )

@app.route("/")
def home():
    REQUEST_COUNT.inc()
    return "Hello from the Cloud/DevOps monitoring project!"

@app.route("/health")
def health():
    REQUEST_COUNT.inc()
    return jsonify({"status": "ok"})

@app.route("/db-check")
def db_check():
    REQUEST_COUNT.inc()
    try:
        conn = get_db_connection()
        cur = conn.cursor()
        cur.execute("SELECT version();")
        version = cur.fetchone()
        cur.close()
        conn.close()
        return jsonify({
            "database_connection": "successful",
            "postgres_version": version[0]
        })
    except Exception as e:
        return jsonify({
            "database_connection": "failed",
            "error": str(e)
        }), 500

@app.route("/metrics")
def metrics():
    return Response(generate_latest(), mimetype="text/plain")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
