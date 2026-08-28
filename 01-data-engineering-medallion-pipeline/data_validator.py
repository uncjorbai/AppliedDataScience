"""

"""
import json
import pandas as pd
import numpy as np


def _missing_columns(df, expected):
    '''
    Return issue dicts for any required column absent from the dataframe.
    '''
    return [{"row_index":-1, "field":col, "issue":"required column missing."} for col in expected if col not in df.columns]


def _check_events(df, raw_lines=None):
    issues = []
    VALID_EVENT_TYPES = {"page_view", "add_to_cart", "purchase", "search", "remove_from_cart"}

    if raw_lines is not None:
         for i, line in enumerate(raw_lines):
                if line.strip() == "":
                   continue
                try:
                   json.loads(line)
                except json.JSONDecodeError:
                   issues.append({"row_index": i, "field":"raw_payload", "issue":"malformed JSON"})
    expected = ["event_type", "user_id", "event_timestamp"]
    missing = _missing_columns(df, expected)
    if missing:
         return issues + missing
    for idx, row in df.iterrows():
        if pd.isna(row["user_id"]) or str(row["user_id"]).strip() =="":
                issues.append({"row_index": idx, "field": "user_id", "issue": "Missing user-id"})
        et = str(row["event_type"]).strip()
        if et not in VALID_EVENT_TYPES:
            issues.append({"row_index": idx, "field": "event_type", "issue": "Invalid event_type"})
        ts = pd.to_datetime(row["event_timestamp"], errors="coerce")
        if pd.isna(ts):
            issues.append({"row_index": idx, "field": "event_timestamp", "issue": "unparseable timestamp"})
            
    return issues

def _check_products(df, raw_lines=None):
    issues = []
    expected = ["product_id", "price", "category"]

    missing = _missing_columns(df, expected)
    if missing:
        return missing

    for idx, row in df.iterrows():
        if pd.isna(row["product_id"]) or str(row["product_id"]).strip() =="":
            issues.append({"row_index": idx, "field": "product_id", "issue": "Missing product id"})
        price = pd.to_numeric(row["price"], errors="coerce")                #This was throwing me for a loop
        if pd.isna(price):
            issues.append({"row_index": idx, "field": "price", "issue": "Non-numeric price"})        
        elif price <0:
            issues.append({"row_index": idx, "field": "price", "issue": "Negative price"})
        if pd.isna(row["category"]) or str(row["category"]).strip() =="":
            issues.append({"row_index": idx, "field": "category", "issue": "Empty category"})

    return issues        

def _check_users(df, raw_lines=None):
    issues = []
    expected = ["user_id", "age_bracket", "state"]

    missing = _missing_columns(df, expected)
    if missing:
        return missing

    VALID_STATES = {
        "AL","AK","AZ","AR","CA","CO","CT","DE","FL","GA","HI","ID","IL","IN",
        "IA","KS","KY","LA","ME","MD","MA","MI","MN","MS","MO","MT","NE","NV",
        "NH","NJ","NM","NY","NC","ND","OH","OK","OR","PA","RI","SC","SD","TN",
        "TX","UT","VT","VA","WA","WV","WI","WY"
    }
    dup_mask = df["user_id"].duplicated(keep=False)

    for idx, row in df.iterrows():
        # user_id present
        if pd.isna(row["user_id"]) or str(row["user_id"]).strip() == "":
            issues.append({"row_index": idx, "field": "user_id", "issue": "Missing user_id"})
        # duplicate user_id
        if dup_mask.loc[idx]:
            issues.append({"row_index": idx, "field": "user_id","issue": "Duplicate user_id"})

        # age_bracket non-null
        if pd.isna(row["age_bracket"]) or str(row["age_bracket"]).strip() == "":
            issues.append({"row_index": idx, "field": "age_bracket", "issue": "Missing age_bracket"})

        # state must be a valid 2-letter code
        state = str(row["state"]).strip().upper()
        if state not in VALID_STATES:
            issues.append({"row_index": idx, "field": "state", "issue": "Invalid State"})

    return issues


def validate(df, source_type, raw_lines=None):
    checkers = {
        "events": _check_events,
        "products": _check_products,
        "users": _check_users,
    }
    issues = checkers[source_type](df, raw_lines)
    bad_rows = {i["row_index"] for i in issues if i["row_index"] != -1}
    schema_failed = any(i["row_index"] == -1 for i in issues)
    total_rows = len(raw_lines) if (source_type == "events" and raw_lines is not None) else len(df)
    valid_rows = 0 if schema_failed else total_rows - len(bad_rows)
    missing_cols = [i["field"] for i in issues if i["row_index"] == -1]
    summary = (f"SCHEMA FAILURE: missing columns {missing_cols}"
               if schema_failed
               else f"{len(bad_rows)} of {total_rows} rows failed validation")
    return {
        "table": source_type,
        "total_rows": total_rows,
        "valid_rows": valid_rows,
        "issues": issues,
        "summary": summary,
    }