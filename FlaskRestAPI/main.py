from flask import Flask,jsonify

app=Flask(__name__)

@app.route('/')

@app.route('/is_armstrong_number/<int:number>')
def is_armstrong_number(number):
    num_str = str(number)
    num_digits = len(num_str)
    armstrong_sum = sum(int(digit) ** num_digits for digit in num_str)
    if armstrong_sum == number:
        result={
            "Number":number,
            "Armstrong":True,
            "Server IP":"122.234.213.53"
        }
    else:
        result={
            "Number":number,
            "Armstrong":False,
            "Server IP":"122.234.213.53"
        }
    return jsonify(result)

if __name__=="__main__":
    app.run(debug=True)
