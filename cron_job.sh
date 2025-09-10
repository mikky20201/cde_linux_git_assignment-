#!/bin/bash

chmod +x /Users/micahonyedikachitobias/Desktop/bash_assignment/raw/etl_pipeline.sh

crontab -e

0 0 * * * /Users/micahonyedikachitobias/Desktop/bash_assignment/raw/etl_pipeline.sh >> /Users/micahonyedikachitobias/Desktop/bash_assignment/raw/etl_pipeline.log 2>&1
