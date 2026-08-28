#sentiment_classifier.py
import logging
import os
import joblib
from langdetect import detect, LangDetectException                                                                                                                          #This was recommended by Claude when I asked for help
from fallback_system import rule_based_fallback, confidence_rejection, route_to_human                                                                                       #From my Fallback file    

logging.basicConfig(level=logging.INFO, format="%(asctime)s [%(levelname)s] %(message)s")
logger = logging.getLogger(__name__)

try:
    model = joblib(load("model.pkl"))
    vectorizer = joblib.load("vectorizer.pkl")
except Exception as e:
    logger.error("Failed to load model: %s", e)
    model, vectorizer = None, None


def classify(text):
    if not isinstance(text, str) or not text.strip():
        return {"label": None, "confidence": None, "status": "rejected", "reason": "Input must be a non-empty string."}                                                   # First Edge Case
    if not (10 <= len(text) <= 5000):
        return {"label": None, "confidence": None, "status": "rejected", "reason": "Input must be between 10 and 5000 characters."}                                       # Second Edget Case
    try:
        if detect(text) != "en":
            return {"label": None, "confidence": None, "status": "rejected", "reason": "Only English text is supported."}                                                 # Third Edge Case
    except LangDetectException:
        return {"label": None, "confidence": None, "status": "rejected", "reason": "Could not detect language."}                                                          # Fourth Edge Case

    if model is None or vectorizer is None:
        return rule_based_fallback(text)

    try:
        vec = vectorizer.transform([text])
        pred = model.predict(vec)[0]
        confidence = float(max(model.predict_proba(vec)[0]))
        logger.info("text_length=%d confidence=%.3f label=%s", len(text), confidence, pred)

        if confidence < 0.70:
            return confidence_rejection(pred, confidence)

        return {"label": pred, "confidence": confidence, "status": "ok", "reason": "Model prediction."}

    except Exception as e:
        logger.error("Prediction failed: %s", e)
        return rule_based_fallback(text)


if __name__ == "__main__":
    test_inputs = [
        "",
        "x" * 10000,
        "Ceci n'est pas anglais",
        "I loved this product, fast shipping!",
        None,
    ]
    for t in test_inputs:
        print(classify(t))