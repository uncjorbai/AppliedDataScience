# Applied Data Science Portfolio

Selected work from my Master of Applied Data Science (MADS) degree at UNC-Chapel Hill. These
are the projects I'm proudest of across the program: data engineering, deep learning,
numerical methods, machine learning, and AI governance.

Author: Jordan Bailey · UNC-Chapel Hill MADS

---

## Projects

| # | Project | Course | Stack | What it shows |
|---|---------|--------|-------|---------------|
| 01 | [Medallion Data Pipeline](01-data-engineering-medallion-pipeline/) | DATA 789 | Python, pandas, PyArrow | Bronze→Silver→Gold architecture with a runnable Bronze→Silver validator |
| 02 | [NLP Sentiment Classifier + Fallback](02-nlp-sentiment-classifier/) | DATA 789 | Python | A classifier with a structured fallback system and documented edge cases |
| 03 | [TinyBERT Fine-Tuning (SST-2)](03-transformers-tinybert-finetuning/) | DATA 785 | PyTorch, Hugging Face | Fine-tuning an encoder-only transformer for sentiment |
| 04 | [Word Embeddings & Representation Learning](04-deep-learning-foundations/) | DATA 785 | PyTorch | Pre-trained embeddings, cosine similarity, representation analysis |
| 05 | [Numerical Methods](05-numerical-methods-julia/) | DATA 750 | Julia, Pluto.jl | SVD, FFT, PCA, least-squares, optimization (interactive notebooks) |
| 06 | [Recidivism Fairness & Applied ML](06-machine-learning-final/) | DATA 780 | Python, scikit-learn, TensorFlow | COMPAS bias, disparate impact (80% rule, BER), ratio-based debiasing toward statistical parity |
| 07 | [AFES / NIST Governance Capstone](07-governance-nist-capstone/) | DATA 740 | NIST AI RMF, ethical matrix | Algorithmic Fairness Evaluation Standard for AI credit scoring |
| 08 | [Formula 1 Analytics via OpenF1 API](08-python-api-data-pipeline/) | DATA 720 | Python, requests, pandas | OOP API client with iterative, live-updating ingestion (2024 F1 season) |

Each project folder has its own README with context, how to run it, and results.

---

## Program coverage

The MADS program ran from Spring 2025 to Summer 2026.

- DATA 710: Foundations of Applied Data Science
- DATA 720: Programming Methods for Data Science
- DATA 730: Statistical Modeling and Inference for Data Science
- DATA 735: Applied Causal Inference Methods in Data Science
- DATA 740: Governance, Bias, and Ethics in Data Science and Artificial Intelligence
- DATA 750: Mathematical Tools for Data Science
- DATA 780: Machine Learning
- DATA 785: Deep Learning
- DATA 789: Data Science & Artificial Intelligence in the Cloud
- DATA 992: Master's (Non-Thesis)

## How this repo was built

I used Claude Code to assemble the repository: cloning and sorting files from my coursework,
setting up the folder structure, and drafting these READMEs. The projects themselves are my
own work from the program, including the code, analysis, models, and writing. I reviewed and
edited everything here.
