# Solutions for Maintaining Concurrent Public and Internal OpenAPI Definitions

This example demonstrates a solution to the following scenario:

- A monolithic public API definition is maintained and frequently updated via a public process.

- An internal definition is also maintained that requires a distinct update workflow from the public definition.

- The internal definition contains alternative versions of paths and components that are present in the public definition, as well as paths and components that are unique to the internal definition.

- A complete internal definition is required that contains both the public and internal endpoints and components and uses the internal versions of the same that appear in both definitions.

- An update strategy is required to handle updates to both public and internal definitions.

## yq Solution

[yq](https://mikefarah.gitbook.io/yq/) is a powerful yaml manipulation tool, similar in function to `jq`.

This solution utilizes `yq` to simply add internal elements contained within an internal yaml file to a public definition.

Details and test files are located in the [yq](/yq) directory.

## OpenAPI CLI Solution

The [OpenAPI CLI](https://redoc.ly/docs/cli/installation/) is a robust tool that leverages the OpenAPI standard.

This solution explores Redocly's suggestion of utilizing [multi-file OpenAPI definitions](https://redoc.ly/docs/resources/multi-file-definitions/).

Details and test files are located in the [openapi-cli](/openapi-cli) directory.
