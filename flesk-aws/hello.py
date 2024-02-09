from flask import Flask

# This is needed so that Flask knows where to look
# for resources such as templates and static files.
app = Flask(__name__)

@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"

@app.route("/products")
def get_products():
    return "<p>Product page</p>"

@app.route("products/<int:product_id>")
def get_product(product_id):
    return "<h1>Product detailed page for {{ product_id }}</h1>"

if __name__ == "__main__":
    # app.run(debug=True)
    app.run(host="0.0.0.0", port=80)