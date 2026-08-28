import json, random
import pandas as pd
 
random.seed(42)
 
EVENT_TYPES = ["page_view", "add_to_cart", "purchase", "search", "remove_from_cart"]
STATES = ["TN","CA","NY","TX","FL","WA","CO","GA","OH","NC"]
AGE_BRACKETS = ["18-24","25-34","35-44","45-54","55-64","65+"]
 
def make_events(path="events.jsonl"):
    lines = []
    for i in range(100):
        lines.append(json.dumps({
            "event_type": random.choice(EVENT_TYPES),
            "user_id": f"u{random.randint(1, 500)}",
            "product_id": f"p{random.randint(1, 50)}",
            "event_timestamp": "2025-01-01T10:00:00",
        }))
    lines[10] = json.dumps({"event_type":"FLYING","user_id":"u1","event_timestamp":"2025-01-01T10:00:00"})
    lines[20] = json.dumps({"event_type":"search","user_id":"","event_timestamp":"2025-01-01T10:00:00"})
    lines[30] = json.dumps({"event_type":"page_view","user_id":"u2","event_timestamp":"not-a-real-date"})
    lines[40] = '{"event_type":"page_view","user_id":"u3", THIS IS BROKEN'
    with open(path, "w") as f:
        f.write("\n".join(lines))
 
def make_products(path="products.csv"):
    rows = [{"product_id": f"p{i}","name": f"Product {i}",
             "category": random.choice(["books","toys","games","home","tech"]),
             "price": round(random.uniform(1,200),2),
             "stock": random.randint(0,500)} for i in range(50)]
    rows[5]["price"]=-9.99
    rows[15]["price"]="free"
    rows[25]["category"]=""
    pd.DataFrame(rows).to_csv(path, index=False)
 
def make_users(path="users.csv"):
    rows = [{"user_id": f"u{i}","age_bracket": random.choice(AGE_BRACKETS),
             "state": random.choice(STATES),"signup_date":"2025-01-01"} for i in range(50)]
    rows[8]["age_bracket"]=None
    rows[18]["state"]="ZZ"
    rows[28]["user_id"]="u0"
    pd.DataFrame(rows).to_csv(path, index=False)
 
if __name__ == "__main__":
    make_events(); make_products(); make_users()
    print("Sample data written: events.jsonl, products.csv, users.csv")