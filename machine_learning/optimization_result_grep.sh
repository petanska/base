
NAME=${1%.*}
NAME=${NAME##*/tmp.}
echo $NAME
grep "|-Trial ID" $1 | awk '/^ |-Trial ID: /{print $NF}' > id.tmp
grep "|-Score" $1 | awk '/^ |-Score: /{print $NF}' > score.tmp
grep "|-Conv_layers" $1 | awk '/^ |-Conv_layers: /{print $NF}' > conv.tmp
grep "|-dense" $1 | awk '/^ |-dense: /{print $NF}' > dense.tmp
grep "|-nodes" $1 | awk '/^ |-nodes: /{print $NF}' > nodes.tmp
grep "|-activation" $1 | awk '/^ |-activation: /{print $NF}' > act.tmp
paste -d '\t' id.tmp score.tmp conv.tmp dense.tmp nodes.tmp act.tmp > results.tmp
sort -k2 -n results.tmp > sorted_results.tmp
sed -i '1i Trial_ID\tScore\tConv_layers\tDense_layers\tNodes\tActivation' sorted_results.tmp
awk '{ OFS="\t" } {if ($4 == 0) $5 = "N/A"; print $0}' sorted_results.tmp > ${NAME}_results.txt
rm ./*.tmp
