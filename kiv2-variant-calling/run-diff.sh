#!/bin/bash
rm -rf output/tmp/*

while true; do
	read -p "Should the VCFs be filtered for exonic LPA variants with 100bp intronic context sequence? [Y/N]"$'\n' yn
	case $yn in
	[Yy] ) 
	awk '$1=="chr#" || $1=="#"' $1 | awk '$2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=#########' | grep -v \# | cut -f1,2,4,5 > output/tmp/comp1.tmp
	awk '$1=="#" || $1=="#"' $2 | awk '$2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=######### || $2<=######### && $2>=#########' | grep -v \# | cut -f1,2,4,5 > output/tmp/comp2.tmp
	break
	;;
        [Nn] ) 
	echo -e "\n[Note that VCFs created during the Master Thesis are filtered for exonic variants but contain variants in the Enhancer region.]\n"
	grep -v \# $1 | cut -f1,2,4,5 > output/tmp/comp1.tmp
	grep -v \# $2 | cut -f1,2,4,5 > output/tmp/comp2.tmp
        break
	;;
	* ) 
	echo "Please type Y or N"
	;;
    esac
done

# This filtering maintains variants found in any of the 6 KIV-2 repeats.
# The 40th non-coding exon is included. The Enhancer region is excluded.

if grep -q chr output/tmp/comp1.tmp; then
	cut -c 4- output/tmp/comp1.tmp > output/tmp/comp1-chr.tmp
	rm output/tmp/comp1.tmp
	mv output/tmp/comp1-chr.tmp output/tmp/comp1.tmp	
fi

if grep -q chr output/tmp/comp2.tmp; then
        cut -c 4- output/tmp/comp2.tmp > output/tmp/comp2-chr.tmp
	rm output/tmp/comp2.tmp
        mv output/tmp/comp2-chr.tmp output/tmp/comp2.tmp
fi

# The if statement checks if #CHROM is written as "#" or "chr#". This is important for the diff command.
# If it is written as "chr#" the first 3 letters of each string are removed with cut.

# The coordinates are used to determine the region in which a respective variant was found (=origin).
# Origin = exonic sequence with 100 bp intronic context. Everythng outside that region is tagged "int" for intronic.

awk '{
if ($2 <= ######### && $2 >= #########) origin="PD6";
else if ($2 <= ######### && $2 >= #########) origin="PD5";
else if ($2 <= ######### && $2 >= #########) origin="PD4";
else if ($2 <= ######### && $2 >= #########) origin="PD3";
else if ($2 <= ######### && $2 >= #########) origin="PD2";
else if ($2 <= ######### && $2 >= #########) origin="PD1";
else if ($2 <= ######### && $2 >= #########) origin="52";
else if ($2 <= ######### && $2 >= #########) origin="51";
else if ($2 <= ######### && $2 >= #########) origin="4102";
else if ($2 <= ######### && $2 >= #########) origin="4101";
else if ($2 <= ######### && $2 >= #########) origin="492";
else if ($2 <= ######### && $2 >= #########) origin="491";
else if ($2 <= ######### && $2 >= #########) origin="482";
else if ($2 <= ######### && $2 >= #########) origin="481";
else if ($2 <= ######### && $2 >= #########) origin="472";
else if ($2 <= ######### && $2 >= #########) origin="471";
else if ($2 <= ######### && $2 >= #########) origin="462";
else if ($2 <= ######### && $2 >= #########) origin="461";
else if ($2 <= ######### && $2 >= #########) origin="452";
else if ($2 <= ######### && $2 >= #########) origin="451";
else if ($2 <= ######### && $2 >= #########) origin="442";
else if ($2 <= ######### && $2 >= #########) origin="441";
else if ($2 <= ######### && $2 >= #########) origin="432";
else if ($2 <= ######### && $2 >= #########) origin="431";
else if ($2 <= ######### && $2 >= #########) origin="422_6";
else if ($2 <= ######### && $2 >= #########) origin="421_6";
else if ($2 <= ######### && $2 >= #########) origin="422_5";
else if ($2 <= ######### && $2 >= #########) origin="421_5";
else if ($2 <= ######### && $2 >= #########) origin="422_4";
else if ($2 <= ######### && $2 >= #########) origin="421_4";
else if ($2 <= ######### && $2 >= #########) origin="422_3";
else if ($2 <= ######### && $2 >= #########) origin="421_3";
else if ($2 <= ######### && $2 >= #########) origin="422_2";
else if ($2 <= ######### && $2 >= #########) origin="421_2";
else if ($2 <= ######### && $2 >= #########) origin="422_1";
else if ($2 <= ######### && $2 >= #########) origin="421_1";
else if ($2 <= ######### && $2 >= #########) origin="412";
else if ($2 <= ######### && $2 >= #########) origin="411";
else if ($2 <= ######### && $2 >= #########) origin="Ex2";
else if ($2 <= ######### && $2 >= #########) origin="Ex1";
else origin="int";
print $0,"\t",origin;
}' output/tmp/comp1.tmp > output/tmp/comp1.ori.tmp

awk '{
if ($2 <= ######### && $2 >= #########) origin="PD6";
else if ($2 <= ######### && $2 >= #########) origin="PD5";
else if ($2 <= ######### && $2 >= #########) origin="PD4";
else if ($2 <= ######### && $2 >= #########) origin="PD3";
else if ($2 <= ######### && $2 >= #########) origin="PD2";
else if ($2 <= ######### && $2 >= #########) origin="PD1";
else if ($2 <= ######### && $2 >= #########) origin="52";
else if ($2 <= ######### && $2 >= #########) origin="51";
else if ($2 <= ######### && $2 >= #########) origin="4102";
else if ($2 <= ######### && $2 >= #########) origin="4101";
else if ($2 <= ######### && $2 >= #########) origin="492";
else if ($2 <= ######### && $2 >= #########) origin="491";
else if ($2 <= ######### && $2 >= #########) origin="482";
else if ($2 <= ######### && $2 >= #########) origin="481";
else if ($2 <= ######### && $2 >= #########) origin="472";
else if ($2 <= ######### && $2 >= #########) origin="471";
else if ($2 <= ######### && $2 >= #########) origin="462";
else if ($2 <= ######### && $2 >= #########) origin="461";
else if ($2 <= ######### && $2 >= #########) origin="452";
else if ($2 <= ######### && $2 >= #########) origin="451";
else if ($2 <= ######### && $2 >= #########) origin="442";
else if ($2 <= ######### && $2 >= #########) origin="441";
else if ($2 <= ######### && $2 >= #########) origin="432";
else if ($2 <= ######### && $2 >= #########) origin="431";
else if ($2 <= ######### && $2 >= #########) origin="422_6";
else if ($2 <= ######### && $2 >= #########) origin="421_6";
else if ($2 <= ######### && $2 >= #########) origin="422_5";
else if ($2 <= ######### && $2 >= #########) origin="421_5";
else if ($2 <= ######### && $2 >= #########) origin="422_4";
else if ($2 <= ######### && $2 >= #########) origin="421_4";
else if ($2 <= ######### && $2 >= #########) origin="422_3";
else if ($2 <= ######### && $2 >= #########) origin="421_3";
else if ($2 <= ######### && $2 >= #########) origin="422_2";
else if ($2 <= ######### && $2 >= #########) origin="421_2";
else if ($2 <= ######### && $2 >= #########) origin="422_1";
else if ($2 <= ######### && $2 >= #########) origin="421_1";
else if ($2 <= ######### && $2 >= #########) origin="412";
else if ($2 <= ######### && $2 >= #########) origin="411";
else if ($2 <= ######### && $2 >= #########) origin="Ex2";
else if ($2 <= ######### && $2 >= #########) origin="Ex1";
else origin="int";
print $0,"\t",origin;
}' output/tmp/comp2.tmp > output/tmp/comp2.ori.tmp


	echo -e "\ninput 1 lists $(wc -l < output/tmp/comp1.tmp) variants."
	echo "input 2 lists $(wc -l < output/tmp/comp2.tmp) variants."

	echo -e "\n#CHROM	POS	REF	ALT	ORI"
	diff output/tmp/comp1.ori.tmp output/tmp/comp2.ori.tmp

	echo -e "\n[Note that the first KIV-2 exon starts at ######### and the 12th KIV-2 exon ends at #########.]\n"
