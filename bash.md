# bash

### manage runnning processes
#### htop
```
htop
```
shows all running processes with their process ID **PID** and their **user**.
#### htop + F5
```
F5
```
shows you all running processes in a tree representation. making it easy to make out the "mother"-process.
#### htop + F9
```
F9
```
lets you kill a process. It will give you options on how to kill the process.
#### ps
```
ps
```
shows all running processes of the user.
(does not work after being logged out)
#### kill
```
kill PID
```
kills the process. (PID = process ID; see "htop")

```
killall --user q009pz
```
kills all processes by the user. Will log you out.

### find a file
```
find . -name '*info*'
```

### extract Exon positions from vcf
```
awk '$2>480 && $2<841 || $2>4643 && $2<5026' 5104file.vcf 
```

### rename files
go into directory
```
rename 's/exom/panel/' *
```
turns **AK17_exom-kiv2_6_90aQ.txt** into **AK17_panel-kiv2_6_90aQ.txt**

### find and replace
```
$sed 's/unix/linux/' file.txt
```
replaces **"unix"** with **"linux"**.

### to check for erroneous downloads
only if provided with original md5 checksum.
```
md5sum -f
```
and compare

### make a script executable
```
chmod +x script
```

### let command run in background
```
<command> &
```

### extract all mapped reads from a bam file
```
samtools view -b -F 4 file.bam > mapped.bam
```

### extract all unmapped reads from a bam file
```
samtools view -b -f 4 file.bam > unmapped.bam
```

### get information about a single read from a bam file
```
samtools view file.bam | awk '$1 == "M05478:24:000000000-D5HPW:1:1102:20111:23552"'
```
