# GATK4 HaplotypeCaller Acc

***The Jar package of Accelerated GATK4 HaplotypeCaller is moved to the Release repository, because of the file size limit of Code repository. ***

## Usage 

* **`create effective regions`**
Chop the whole genome region into pieces so as to facilitate the parallelized calculation. Command `ebed_creater` will create a bed file with the suffix `effective.bed` in the same directory of the reference fasta file.
This step only needs to be run once and its result can be reused in the `Accelerated HaplotypeCaller` step.

```
ebed_creater reference.fa
```

* **`Run Accelerated GATK4 HaplotypeCaller`**
The usage of `Accelerated HaplotypeCaller` is almost the same as the original GATK4 HaplotypeCaller, except for the new parameter `--num-threads`, which can be used to set the number of threads for the tool. This paramter is optiional. If it is not set, all available threads will be used.

```java
// VCF
java -jar acc_hc4_v2.0.4.jar HaplotypeCaller -R  ucsc.hg19.fasta -I 
NA12878_dedup_merge.bam  -O test_gvcf.vcf 
// GVCF
java   -jar acc_hc4_v2.0.4.jar HaplotypeCaller -R  ucsc.hg19.fasta -I 
NA12878_dedup_merge.bam  -O test_gvcf.g.vcf --emit-ref-confidence GVCF

// FPGA
java -jar acc_hc4_v2.0.4.jar HaplotypeCaller -R  ucsc.hg19.fasta -I 
NA12878_dedup_merge.bam  -O test_gvcf.vcf --use-fpga
```

### Note 
* If **downsampling** is disabled, which can be set by `--max-reads-per-alignment-start 0`, the VCF result of this tool is eactly the same as the original GATK4 HaplotypeCaller.
* if downsampling is **not** disabled, there will be on average of 10 out of millions variants on our WGS test data.
* This tool needs **java 1.8** to run properly. 
