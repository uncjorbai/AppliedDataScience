# fallback_system.py
iimport logging

logger = logging.getLogger(__name__)

CONFIDENCE_THRESHOLD = 0.70
HUMAN_QUEUE = []

POSITIVE_WORDS = {"great", "love", "excellent", "amazing", "good", "fantastic"}
NEGATIVE_WORDS = {"bad", "terrible", "awful", "hate", "worst", "horrible"}


def rule_based_fallback(text):
    words = set(text.lower().split())
    if len(words & POSITIVE_WORDS) > len(words & NEGATIVE_WORDS):
        label = "positive"
    elif len(words & NEGATIVE_WORDS) > len(words & POSITIVE_WORDS):
        label = "negative"
    else:
        label = "neutral"
    return {"label": label, "confidence": None, "status": "fallback", "reason": "Rule-based keyword match."}


def confidence_rejection(label, confidence):
    if confidence < CONFIDENCE_THRESHOLD:
        return {"label": None, "confidence": confidence, "status": "rejected", "reason": f"Confidence {confidence:.3f} too low."}
    return {"label": label, "confidence": confidence, "status": "ok", "reason": "Confidence acceptable."}


def route_to_human(text, confidence):
    HUMAN_QUEUE.append({"text": text, "confidence": confidence, "status": "pending"})
    logger.info("Routed to human queue. Depth: %d", len(HUMAN_QUEUE))
    return {"label": None, "confidence": confidence, "status": "fallback", "reason": "Routed to human review."}


def apply_fallback(text, model_response):                                                                                                               
    confidence = model_response.get("confidence")
    if model_response.get("status") == "rejected":
        return rule_based_fallback(text)
    if confidence is not None and confidence < CONFIDENCE_THRESHOLD:
        return route_to_human(text, confidence)
    return model_response


if __name__ == "__main__":
    print(rule_based_fallback("This is terrible, this has to be the worst product ever."))
    print(confidence_rejection("positive", 0.45))
    print(route_to_human("It was fine I guess.", 0.51))
    low_conf = {"label": "neutral", "confidence": 0.55, "status": "ok", "reason": "Model prediction."}
    print(apply_fallback("It was fine I guess.", low_conf))