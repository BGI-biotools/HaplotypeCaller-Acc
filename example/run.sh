#!/bin/bash

# java 8
# jvm 调优， 使用更大内存 -Xmx80g -Xms80g
# jvm 垃圾回收机制调优， -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 for G1GC
# run acc_hc4 output vcf
## Step 1 : 生成高效的运行区间
tar -zxvf effective_bed_creator.tar.gz
ebed_creator hg19.fasta

## Step 2 : 运行ACC_HC4
BAM=test.bam;
ref=hg19.fasta;
java -jar ../acc_hc4_v2.0.2_cpu.jar HaplotypeCaller \
-R $ref \
-I $BAM \
-O test_vcf.g.vcf \
--num-threads 10


# run acc_hc4 output gvcf
java -jar ../acc_hc4_v2.0.2_cpu.jar HaplotypeCaller \
-R $ref \
-I $BAM \
-O test_gvcf.g.vcf \
--emit-ref-confidence GVCF \
--num-threads 10

# run acc_hc4 output vcf(test_vcf) & gvcf (test_gvcf)
java -jar ../acc_hc4_v2.0.2_cpu.jar HaplotypeCaller \
-R $ref \
-I $BAM \
-O test_gvcf.g.vcf \
--output-gvvcf test_vcf.g.vcf \
--emit-ref-confidence GVCF \
--num-threads 10
