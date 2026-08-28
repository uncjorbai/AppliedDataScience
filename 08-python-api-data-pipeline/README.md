# Formula 1 Analytics via the OpenF1 API

**Course:** DATA 720: Programming Methods for Data Science · **Stack:** Python, requests, pandas, ipywidgets

This was my first large project in my Graduate program. 

It pulls 2024 Formula 1 race data live from the [OpenF1 API](https://openf1.org/) and explores driver performance, lap consistency, and positional change.

## What it shows

I came into the program from a business intelligence background, so my instinct was to make the data report itself. 

Instead of heavy statistical modeling, I built interactive, report-style widgets (dropdowns, per-driver views, live-updating output) so a reader can explore the season like a BI dashboard. 

Under that sits a modular, object-oriented OpenF1 client with session-by-session ingestion.

I initially set out to create a class based solution, but the widget became my focus point, so the modeling is light in lieu of that.

## Contents

- `f1_api_data_analysis.ipynb`: custom API client, transform, merge, interactive exploration

## A starting point

I kept this in my portfolio as an origin piece. The strengths are the data sourcing and the widget-based reporting. The modeling is exploratory, and the notebook's own conclusion is that race outcomes don't predict cleanly from pace. Later projects in my program are where I learn to apply deeper analysis.