# python lambda layer

A simple-stupid script for automatically creating an AWS python lambda layer.

## Pre-requirements:
1. docker
2. bash command line shell

## How to use?
Pretty straight forward:
```
bash create_lambda_layer.sh -p python3.9 -r requirements.txt 
```
1. -p argument specifies lambda version (`python3.6`, `python3.7`, etc...)
2. -r argument specifies the path for the `requirements.txt` file.

The ```requirements.txt``` file has all the python packages listed inside it, preferably with their exact version.  
For example:
```
pandas==1.4.0
requests==2.25.0
```

The result of the script is a `lambda_layer.zip` file, containing all the python packages listed in the `requirements.txt` file.  
You can later easily create an AWS python lambda layer straight from the zip file.

## Credits
The script is heavily inspired by this great [blog post](https://aws.amazon.com/premiumsupport/knowledge-center/lambda-layer-simulated-docker/).