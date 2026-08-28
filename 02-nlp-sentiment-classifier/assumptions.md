# System Assumptions

# Machine
- Model Predictions
- Confidence Scores
- Fallback mechanisms
- Error handling

# World
1. **Assumption:** Reviews are in English
- **Risk if violated:** Model will fail on other languages
- **Mitigation:** Language detection + rejection
- **Monitoring:** Track language distribution
2. **Assumption:** Users submit text via web form
- **Risk if violated:** Input format might change
- **Mitigation:** Input validation + schema enforcement
- **Monitoring:** Track input formats
3. **Assumption:** Trained Models exist in the location the programs are run.
- **Risk if violated:** Service can't make predictions without the model. 
- **Mitigation:** Audits in file locations, ensuring naming conventions match. 
- **Monitoring:** Log Model load at startup.
4. **Assumption:** Review length is going to be between 10 and 50000 characters. 
- **Risk if violated:** too little and you don't get enough context, too large and you lose context. 
- **Mitigation:** Edge cases and error handling. 
- **Monitoring:** Log text length on every request.
5. **Assumption:** The review distribution is aligned with the training data.
- **Risk if violated:** Model accuracy degrades silently as language patterns change or drift. 
- **Mitigation:** confidence scores are logged and compared, and analyzed for offline drift monitoring. 
- **Monitoring:** Alerts if rate remains beyond threshold.
6. **Assumption:** Human review actually exists and is monitored in appropriate time. 
- **Risk if violated:** Low confidence cases back up, defeats the purpose of a human-in-the-loop.
- **Mitigation:** Queue monitoring, alerts if too many cases appear in a short time frame or threshold is surpassed. 
- **Monitoring:** Alerts for too many requests at once, or too many requests in queue. 
