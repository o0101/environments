mkdir -p stats/$(date -I)
mv stats/code* stats/$(date -I)
sloc --exclude "node_modules|bundle" . > stats/codestats.txt
cloc ./ --exclude-dir=node_modules --exclude-ext=json --use-sloccount --csv --by-file --report-file stats/codecount.csv


