'''
NOTE: I do not know Kafka, and I don't have enough time to learn it enough to even 
pretend I know what production ready code looks like.

This is designed and documented, but this is not going to be really runnable code.

Ingestion is focused on Bronze, before we run the validator.
'''

import json
import hashlib
from datetime import datetime, timezone


def timestamp():
    '''
    Every record is stamped as it comes in
    '''

    return datetime.now(timezone.utc).isoformat()

def ingest_events(event_lines):
    '''
    Raw data ingestion of Kafka stream
    Assume any string hitting this is constant, not the static version we'll test with

    Valid records write to Bronze, brokzen records get quarantined. 

    '''

    bronze, quarantine = [], []
    for line in event_lines:
        try:
            payload = json.loads(line)
            payload["ingestion_timestamp"] = timestamp()
            payload["source"] = "events_stream"
            bronze.append(payload)
        except json.JSONDecodeError:
            quarantine.append(line)
    return bronze, quarantine

def schema_fingerprint(columns):                                                        #Claude helped with this. Hashing is kind of new to me.
    '''
    Makes a 'fingerprint' of the column names. Used for lineage tracking. 
    '''
    return hashlib.md5(",".join(sorted(columns)).encode()).hexdigest()

def ingest_products(rows, columns, source_file, last_fingerprint=None):
    current = schema_fingerprint(columns)
    drift = (last_fingerprint is not None and current != last_fingerprint)
    if drift:
        print(f"SCHEMA DRIFT in {source_file}: columns changed")
    
    record = {
        "rows" : rows,
        "ingestion_timestamp" : timestamp(),
        "source_file" : source_file,
        "schema_fingerprint" : current
    }

    return record, current

def ingest_users(rows, source_file):
    '''
    Weekly Parquet + Time Stamp
    '''
    seen, duplicates = set(), []
    for r in rows:
        uid = r.get("user_id")
        if uid in seen:
            duplicates.append(uid)
        seen.add(uid)
        r["ingestion_timestamp"] = timestamp()
        r["source_file"] = source_file

    if duplicates:
            print(f'Found duplicates: {duplicates}')
        
    return rows, duplicates
    
if __name__ == "__main__":
    events = ['{"event_type":"page_view","user_id":"u1"}', 'this line is broken json']
    good, bad = ingest_events(events)
    print(f'events -> {len(good)} good, {len(bad)} quarantined')