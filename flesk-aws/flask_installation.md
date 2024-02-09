## Spin up the project

- Create a working directory, name it as you wish, open the new directory with VSCode.

- Create virtual environment as a best practice:
```py
python3 -m venv env # for Windows or
python -m venv env # for Windows
virtualenv env # for Mac/Linux or;
virtualenv yourenv -p python3 # for Mac/Linux
```

- Activate scripts:
```bash
.\env\Scripts\activate  # for Windows
source env/bin/activate  # for MAC/Linux
```

- For Microsoft Power Shell: For windows Microsoft Tech Support it might be a problem with 
Execution Policy Settings. To fix it, you should try executing 
```sh
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
```

- See the (env) sign before your command prompt.

- Look at package documentation
https://flask.palletsprojects.com/en/3.0.x/

- Install flask
```bash
pip install Flask
```

- See installed packages:
```sh
pip freeze

# If you see lots of things here, that means there is a problem with your virtual env activation. 
# Activate scripts again
```

- Create requirements.txt same level with working directory, send your installed packages to this file, requirements file must be up to date:
```py
pip freeze > requirements.txt
```

- Look at quickstart page to see minimal app:
https://flask.palletsprojects.com/en/3.0.x/quickstart/


- A minimal Flask application looks something like this, save it as hello.py or something similar. Make sure to not call your application flask.py because this would conflict with Flask itself.:
```py
from flask import Flask


# This is needed so that Flask knows where to look 
# for resources such as templates and static files.
app = Flask(__name__)

@app.route("/")
def hello_world():
    return "<p>Hello, World!</p>"
```

- Run the app:
```py
flask --app hello run
```

- `Ctrl C` to stop the app:

## More Flavor

- Show first version cant run using shortcut. To run the app directly add two more lines:

```py
# The code you provided is a common pattern in Python 
# for running a Flask web application.
if __name__ == '__main__':
# This line checks whether the script is being run directly by 
# the Python interpreter (i.e., not imported as a module in another script). 
# This is a common pattern in Python scripts to ensure that certain code 
# is only executed when the script is run directly.

    app.run(debug=True)
    # app.run(debug=True, port=3003)

    # This line actually runs the Flask application. It tells Flask 
    # to run the application on all available network interfaces ('0.0.0.0') 
    # and to use port 80, which is the default port for HTTP traffic. 
    # By default, Flask runs on localhost (127.0.0.1) and a randomly chosen port, 
    # but specifying host='0.0.0.0' makes it accessible from other devices on the network.
    # app.run(host='0.0.0.0', port=80)
```

## More endpoints:

```
@app.route('/second')
def second():
    return 'This is second page'

@app.route('/third')
def third():
    return 'This is third page'

@app.route('/forth/<string:id>')
def forth(id):
    return f'Id of this page is {id}'
```


## Templating

https://flask.palletsprojects.com/en/3.0.x/templating/

## Rendering Templates

https://flask.palletsprojects.com/en/3.0.x/quickstart/#rendering-templates

- Create `templates` folder.

- Add a template example:
```
@app.route('/example')
def example():
    return render_template('index.html', number1=112500, number2=225200)
```

- Create `index.html` under templates folder:
```html

    <h1>This is my first Jinja Template File</h1>

    <h2>{{ number1 }} is my first number from the application</h2>

    <h2>{{ number2 }} is my second number from the application</h2>

```

- Add another template example:
```
@app.route('/multiply')
def multiply():
    x=15
    y=20
    return render_template('body.html', num1=x, num2=y, multiply=x*y)
```

- Create `index.html` in templates folder and add some more html:
```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <h1>The multiplication of {{ num1 }} and {{ num2 }} is {{ mult }}</h1>
</body>

</html>
```

## Tutorial

https://flask.palletsprojects.com/en/3.0.x/tutorial/


## Deploy AL2023

- change last line according to ec2

- send proj to github, public repo

- ssh to ec2 al2023

```sh
# yum update -y
sudo dnf update -y

yum install git -y
# sudo dnf install git -y
git --version

# yum install python3-pip -y
sudo dnf install python3-pip -y
python3 --version

git clone https://github.com/bluehackrafestefano/flask-05-Handling-SQL-with-Flask-Web-Application.git app

cd app

sudo pip install Flask
# pip install -r requirements.txt

sudo python3 hello.py
# python3 app-with-sqlite.py
```

- Update the code, push to the github, pull the changes in ec2, rerun the app, check the changes

## More Automation

- A sample user data can be:
```sh
#!/bin/bash
dnf update -y
dnf install git -y
dnf install python3-pip -y
git clone https://github.com/bluehackrafestefano/flask_test_proj.git app
cd app
pip install Flask
python3 hello.py
```
