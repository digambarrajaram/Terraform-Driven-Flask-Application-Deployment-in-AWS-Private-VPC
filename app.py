from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return """
    <html>
        <head>
            <title>Terraform + Flask on AWS</title>
            <style>
                body {
                    font-family: Arial, sans-serif;
                    background-color: #f4f4f4;
                    color: #333;
                    text-align: center;
                    padding-top: 100px;
                }
                h1 {
                    color: #007bff;
                }
                .container {
                    background: white;
                    padding: 40px;
                    margin: auto;
                    width: 50%;
                    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
                    border-radius: 10px;
                }
            </style>
        </head>
        <body>
            <div class="container">
                <h1>🚀 Flask App Deployed with Terraform!</h1>
                <p>This web app is running on an EC2 instance provisioned using <strong>Terraform</strong>.</p>
                <p>Powered by: <strong>AWS + Flask + Python</strong></p>
            </div>
        </body>
    </html>
    """

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)
