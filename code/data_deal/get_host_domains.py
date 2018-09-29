import os
from collections import defaultdict
from alexa_top import Alexa_top
from utils import clean_string, have_other_characters

file = "/mnt/Work/DNS/data/nxdomains_per_5_mins/20171104/201711040000.txt"

A = Alexa_top()
sip_domains = defaultdict(lambda :set())
with open(file) as f:
    for row in f:
        items = row.strip().split(',')
        sip = items[0]
        domain = clean_string(items[3])
        if have_other_characters(domain):
            continue
        if not A.in_alexa_top(domain):
            sip_domains[sip].add(domain)

count = 0
for sip, domains in sorted(sip_domains.items(), key=lambda x: len(x[1]), reverse=True):
    if len(domains) > 10:
        print("{}: {}".format(sip, domains))
        count += 1

print(count)
