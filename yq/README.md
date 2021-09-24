# yq Solution to Maintaining Concurrent Public and Internal OpenAPI Definitions

## Summary

- The internal API definition is written to only contain additional elements to the public definition.
  - In this example, the internal definition is represented by `yq-internal.yaml`.
  - In this example, the public definition is represented by `yq-public.yaml`.
  - All fully-internal elements are tagged with the `x-internal: true` extension to confirm the correct element is used in the final definition; this extension is not a requirement for this solution.
  - The internal definition is not a valid OpenAPI definition on its own.

- Using [yq](https://mikefarah.gitbook.io/yq/), procedurally add the elements of the internal definition to the public definition to create a joint definition.
  - Descriptions in the internal definition are automatically marked and added to existing public counterparts.
  - Internal array elements are appended to existing public counterparts.
  - In case of other duplicate values (e.g., `.info.version`), the public version is used

## Setup

Ensure that [yq](https://mikefarah.gitbook.io/yq/) (version 4) is installed on your machine

    brew install yq

## Run the Test

### Generate a Joint Definition

1. Make the `yq-merge.sh` script executable:

        chmod +x yq-merge.sh

1. Run the `yq-merge.sh` script with the following arguments to create a joint API definition:

        ./yq-merge.sh \
          --public yq-public.yaml \
          --internal yq-internal.yaml \
          --output yq-joint.yaml \
          --output-title 'API Definition (includes internal)'

1. Inspect the resultant `yq-joint.yaml` file.

### Handle Updates

1. Update both the public and private definitions as desired.

1. Run the `yq-merge.sh` script again:

        ./yq-merge.sh \
          --public yq-public.yaml \
          --internal yq-internal.yaml \
          --output yq-joint.yaml \
          --output-title 'API Definition (includes internal)'

1. Inspect the updated `yq-joint.yaml` file.
