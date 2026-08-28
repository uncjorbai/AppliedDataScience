# NLP Sentiment Classifier with Fallback

**Course:** DATA 789: Data Science & AI in the Cloud · **Stack:** Python

A sentiment classifier built around a predictable contract and a fallback system for
low-confidence or malformed input. This is the kind of defensive design a classifier needs
before it can be trusted in a pipeline.

## Interface

```python
classify(text)                       # -> {label, confidence, status, reason}
apply_fallback(text, model_response) # -> same shape, after fallback logic
```

Both return the same dictionary shape, so downstream code handles one contract whether the
primary path or the fallback produced the answer.

## Files

- `sentiment_classifier.py`: `classify(text)`. Run it directly to see all 5 edge cases
- `fallback_system.py`: `apply_fallback(text, model_response)`
- `assumptions.md` and `requirements.md`: documented assumptions and requirements

## Run it

```bash
python sentiment_classifier.py   # prints the 5 edge cases
```
