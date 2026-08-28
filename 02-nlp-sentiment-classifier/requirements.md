# Sentiment Classifier Requirements

## 1. Business Metrics

- **Primary Goal:** Automatically tag incoming customer reviews by sentiment so the
  support team can prioritize negative feedback and reduce average response time by 25%.
- **Measurement:** Weekly report comparing average support-ticket response time and
  escalation rate before vs. after deployment. Sentiment labels are audited by sampling
  200 predictions per week and comparing to human labels.
- **Timeline:** Evaluate after 30 days of production traffic. Re-evaluate quarterly.
- **Success Threshold:** >= 20% reduction in average response time to negative reviews

---

## 2. System Performance Requirements

- **Latency:**
  - p50: < 80 ms
  - p95: < 250 ms
  - p99: < 500 ms
- **Throughput:** 50 requests/second sustained
- **Availability:** 99.9% uptime 
- **Data Volume:** 1,000 reviews/day


---

## 3. Model Quality Requirements

- **Primary Metric:** Macro F1 score
- **Minimum Threshold:** Macro F1 > 0.85 on held-out test set
- **Per-Class Requirements:**

  | Class    | Min Precision | Min Recall |
  |----------|--------------|------------|
  | Positive | > 0.87       | > 0.85     |
  | Negative | > 0.90       | > 0.88     |
  | Neutral  | > 0.80       | > 0.78     |


- **Fairness:** Maximum F1 performance gap < 5% across product categories.

---

## 4. Data Quality Requirements

- **Input Validation:**
  - Text length: 10 - 5,000 characters (reject outside this range)
  - Language: English only (detect with `langdetect`; reject or flag non-English)
  - Encoding: UTF-8; strip or reject malformed bytes
  - Special characters: Unallowed. Prevent non-printable characters, match case sensitivity of DB. 

- **Drift Detection:**
  - Monitor: Vocabulary distribution, mean text length, percentage of reviews triggering the rule-based fallback
  - Alert Threshold: UCL/LCL event alerts when reviews are too biased either positive/negative.
  - Retraining trigger: Drift alert fires for 3 consecutive days, OR weekly human-audit agreement drops below 80%

---

## 5. Failure Modes and Mitigation

| Failure Mode | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Model file missing / corrupted on startup | Low | Critical | Validate file hash at load time; fail fast with clear error log |
| Empty or whitespace-only input | High | Low | Input validation layer rejects before inference |
| Non-English review submitted | Medium | Medium | Language detection; return structured rejection response |
| Input exceeds max length | Medium | Low | Truncate to 5,000 chars with warning log, or reject |
| Model confidence below threshold | Medium | Medium | Route to rule-based fallback, then human queue if still uncertain |
| Prediction latency spike (p99 > 500 ms) | Low | Medium | Async processing queue; timeout + fallback after 400 ms |
| Data drift detected | Low | High | Alert on-call; freeze retraining pipeline; notify team |
