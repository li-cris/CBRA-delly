# Manual Delly Calling Smoke Test

This helper runs only the `SV_CALLING_DELLY` subworkflow with Delly's example
short-read data. It is intended for manual validation on machines with
Nextflow, Singularity, and an AnnotSV annotations directory available.

Run from the repository root:

```bash
nextflow run subworkflows/local/delly_calling/tests/manual/run_real.nf \
    -c nextflow.config \
    -c subworkflows/local/delly_calling/tests/manual/run_real.config \
    -profile singularity \
    --annotsv_annotations /path/to/AnnotSV_annotations
```

Outputs are written to `manual_outputs/delly_calling_real/`, which is ignored
by git.
