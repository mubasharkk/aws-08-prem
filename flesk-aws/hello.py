from flask import Flask, render_template

# This is needed so that Flask knows where to look
# for resources such as templates and static files.
app = Flask(__name__)

@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"

@app.route("/products")
def get_products():
    return "<p>Product page</p>"

@app.route("/products/<int:product_id>")
def get_product(product_id):
    return f"<h1>Product detailed page for { product_id }</h1>"

@app.route("/products/<int:product_id>/details")
def get_product_details(product_id):
    return render_template('index.html', product_id=product_id)

if __name__ == "__main__":
    # app.run(debug=True)
    app.run(host="0.0.0.0", port=80)