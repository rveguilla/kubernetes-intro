#!/usr/bin/env bash
docker login

#!/usr/bin/env bash

set -u

for IMPL_FLAVOR in java nodejs ; do
    docker push ${IMAGE_REPO}/example-app-${IMPL_FLAVOR}
done



