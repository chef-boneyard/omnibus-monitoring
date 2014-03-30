# Omnibus Monitoring

This repository contains the skeleton for building an Omnibus package
with server monitoring services (estatsd, graphite)

# Building omnibus-monitoring

    vagrant up PLATFORM

You will need Vagrant 1.2.1 or greater installed.

If the package creation fails, once the error is addressed you can pick up
where you left off with

    vagrant provision PLATFORM

Packages will be in pkg/

## Licensing

See the LICENSE file for details.

Copyright: Copyright (c) 2014 Chef Software, Inc.
License: Apache License, Version 2.0

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.


