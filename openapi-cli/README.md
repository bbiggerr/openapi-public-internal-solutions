# OpenAPI CLI Solution to Maintaining Concurrent Public and Internal OpenAPI Definitions

## Summary

- The public API definition is split into a [multi-file OpenAPI definition](https://redoc.ly/docs/resources/multi-file-definitions/) by utilizing the [OpenAPI CLI](https://redoc.ly/docs/cli/installation/).
  - In this example, the public definition is represented by `public-openapi.yaml`.
  - Elements that have internal versions are tagged with the `x-joint: true` extension to help maintainers identify when internal updates are required; this extension is not a requirement for this solution.

- An internal definition is modified to refer to components in the public definition wherever appropriate.
  - In this example, the internal definition is represented by `internal-openapi.yaml`.
  - Note that the `ErrorResponse` component within the internal definition refers to the anticipated relative location of the public definition after splitting.
  - All fully-internal elements are also tagged with the `x-internal: true` extension to confirm the correct element is used in the final definition; this extension is not a requirement for this solution.

- A joint definition is written that points to the relative public or internal multi-file definition paths.
  - In this example, the joint definition is represented by `joint-openapi.yaml`.

- The joint definition is bundled, resulting in a complete monolithic definition containing elements of both public and internal definitions as desired.

- After the public definition is updated, maintainers must ensure that updates to `x-joint: true` elements are also made to the internal definition prior to bundling.

- After the internal definition is updated as needed, both definitions are re-split.

- After the joint definition is updated as needed, it is re-bundled to incorporate both public and internal updates.

## Setup

Ensure that the [OpenAPI CLI](https://redoc.ly/docs/cli/installation/) is installed on your machine.

    npm i -g @redocly/openapi-cli@latest

or

    yarn global add @redocly/openapi-cli

## Run the Test

### Generate a Joint Definition

1. Split the **public definition** to the `public` directory:

        openapi split public-openapi.yaml --outDir public

1. Split the **internal definition** to the `internal` directory:

        openapi split internal-openapi.yaml --outDir internal

1. Bundle the **joint definition** to incorporate elements from both of the split public and internal definitions:

        openapi bundle -o openapi.yaml joint-openapi.yaml

1. Review the results located in the `openapi.yaml` file. Note that the `GET /joint` command and the `JointSchema` component use their respective internal versions and all references are built properly.

### Handle Updates

1. Update both fully public and `x-joint: true` elements the **public definition**.

1. Update the **internal definition**, ensuring to include necessary updates made to `x-joint: true` elements from the **public definition**.

    **NOTE**: Because the **joint definition** is configured to use elements from the **internal definition** for `x-joint: true` elements, the **internal definition** must be updated for such elements, as their public counterparts are excluded from bundling.

1. Remove the existing split definitions:

        rm -rf {public,internal}

1. Re-split both the **public and internal definitions**:

        openapi split public-openapi.yaml --outDir public
        openapi split internal-openapi.yaml --outDir internal

1. Re-bundle the **joint definition**:

        openapi bundle -o openapi-updated.yaml joint-openapi.yaml

1. Review the results located in the `openapi-updated.yaml` file.
