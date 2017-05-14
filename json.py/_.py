#!/usr/bin/env python
#
#
import sys, re, json;
from pprint import pprint;

the_raw_input = sys.argv[1].strip();
the_raw_key   = sys.argv[2].strip();
the_json      = json.loads(the_raw_input);

def to_int(raw):
  if re.match('^[0-9]{1,3}$', raw):
    return int(raw)
  else:
    raise Exception("Invalid value for int: " + repr(raw))

def get(val, raw_key):
  the_type = type(val).__name__;
  if the_type == "list":
      return get_index(val, raw_key);
  elif the_type == "dict":
      return get_key(val, raw_key);
  else:
    raise Exception("Invalid value: " + repr(val) + " (key: " + repr(raw_key) + ")")

def get_index(val, raw_key):
  return val[to_int(raw_key)];

def get_key(d, raw_key):
  keys = to_keys(raw_key)
  if len(keys) == 1:
    return d[keys[0]]
  else:
    return get_index(d[keys[0]], keys[1])


def to_keys(raw_key):
  m = re.search('^(?P<k>[^\[]+)(\[(?P<i>[0-9]+)\])?$', raw_key)
  if m.group("i"):
    return [m.group("k"), m.group("i")]
  else:
    return [m.group("k")]

current = the_json
for m in re.finditer('[^\.]+', the_raw_key):
  current = get(current, m.group(0));
pprint(current)

