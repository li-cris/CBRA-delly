include { DELLY_CALL } from '../../../modules/nf-core/delly/call/main'

workflow SV_CALLING_DELLY {

    take:
    ch_bam   // channel (mandatory): [ val(meta), path(bam), path(bai) ]
    ch_fasta // channel (mandatory): [ val(meta2), path(fasta) ]
    ch_fai   // channel (mandatory): [ val(meta3), path(fai) ]

    main:

    // delly expects: [ meta, bam, bai, vcf, vcf_index, exclude_bed ]
    // For WGS there is no prior callset to genotype, so pass empty files, nor excluded BED for now
    ch_delly_input = ch_bam.map { meta, bam, bai ->
        [ meta, bam, bai, [], [], [] ]
    }

    DELLY_CALL (
        ch_delly_input,
        ch_fasta,
        ch_fai,
        'vcf' // or 'bcf', but other subworkflows expect vcf output, so default to that
    )

    ch_versions = DELLY_CALL.out.versions_delly
        .unique()
        .map { process, tool, version ->
            "\"${process}\":\n    ${tool}: ${version}\n"
        }
        .collectFile(name: 'delly_versions.yml')




    // manta seems to have .tbi
    emit:
    vc_format      = DELLY_CALL.out.bcf // channel: [ val(meta), path(vcf.gz) ]
    vc_index      = DELLY_CALL.out.csi // channel: [ val(meta), path(tbi) ]
    versions = ch_versions        // channel: [ versions.yml ]
}
