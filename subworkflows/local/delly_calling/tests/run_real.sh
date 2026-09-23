#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
    echo "Usage: bash subworkflows/local/delly_calling/tests/run_real.sh /path/to/AnnotSV_annotations [nextflow-profile]"
    exit 1
fi

ANNOTSV_ANNOTATIONS="$1"
PROFILE="${2:-singularity}"

nextflow run subworkflows/local/delly_calling/tests/run_real.nf \
    -c nextflow.config \
    -c subworkflows/local/delly_calling/tests/run_real.config \
    -profile "${PROFILE}" \
    --annotsv_annotations "${ANNOTSV_ANNOTATIONS}"
