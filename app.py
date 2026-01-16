import pickle
from flask import Flask, request, jsonify, render_template
import numpy as np
import pandas as pd

app = Flask(__name__)

# Load the model
model = pickle.load(open('rfmodel.pkl', 'rb'))

# Home page
@app.route('/')
def home():
    return render_template('home.html')

# Prediction route
@app.route('/predict', methods=['POST'])
def predict():
    try:
        features = [float(x) for x in request.form.values()]
        final_features = np.array(features).reshape(1, -1)

        prediction = model.predict(final_features)[0]

        result = "Fraudulent Transaction ❌" if prediction == 1 else "Legitimate Transaction ✅"

        return render_template('home.html', prediction_text=f"Prediction Result: {result}")

    except Exception as e:
        return render_template('home.html', prediction_text=f"Error occurred: {str(e)}")

# Run app
if __name__ == "__main__":
    print("Starting Flask app...")
    app.run(debug=True)