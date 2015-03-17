Description
===========

This is a template to deploy [Gitlab](https://www.gitlab.com/) on a single
Linux server with [OpenStack Heat](https://wiki.openstack.org/wiki/Heat)
on the [Rackspace Cloud](http://www.rackspace.com/cloud/). This template uses
[chef-solo](http://docs.opscode.com/chef_solo.html) to configure the server.

Requirements
============
* A Heat provider that supports the following:
  * OS::Nova::KeyPair
  * OS::Heat::RandomString
* An OpenStack username, password, and tenant id.
* [python-heatclient](https://github.com/openstack/python-heatclient)
`>= v0.2.8`:

```bash
pip install python-heatclient
```

We recommend installing the client within a [Python virtual
environment](http://www.virtualenv.org/).

Example Usage
=============
Here is an example of how to deploy this template using the
[python-heatclient](https://github.com/openstack/python-heatclient):

```
heat --os-username <OS-USERNAME> --os-password <OS-PASSWORD> --os-tenant-id \
  <TENANT-ID> --os-auth-url https://identity.api.rackspacecloud.com/v2.0/ \
  stack-create gitlab-stack -f gitlab.yaml -P ssh_keypair_name=gitlab-example
```

* For UK customers, use `https://lon.identity.api.rackspacecloud.com/v2.0/` as
the `--os-auth-url`.

Optionally, set environmental variables to avoid needing to provide these
values every time a call is made:

```
export OS_USERNAME=<USERNAME>
export OS_PASSWORD=<PASSWORD>
export OS_TENANT_ID=<TENANT-ID>
export OS_AUTH_URL=<AUTH-URL>
```

Parameters
==========
Parameters can be replaced with your own values when standing up a stack. Use
the `-P` flag to specify a custom parameter.

* `server_hostname`: Hostname to use for setting the server name. (Default:
  gitlab)
* `gitlab_admin_user`: User name for gitlab admin user (Default: root)
* `image`: Server image used for all servers that are created as a part of this
  deployment (Default: Ubuntu 14.04 LTS (Trusty Tahr))
* `kitchen`: URL for the kitchen to use (Default:
  https://github.com/rackspace-orchestration-templates/gitlab.git)
* `flavor`: Rackspace Cloud Server flavor to use. The size is based on the
  amount of RAM for the provisioned server. (Default: 4 GB Performance)
* `chef_version`: Version of chef client to use (Default: 11.12.8)


Outputs
=======
Once a stack comes online, use `heat output-list` to see all available outputs.
Use `heat output-show <OUTPUT NAME>` to get the value fo a specific output.

* `private_key`: SSH private that can be used to login as root to the server.
* `server_ip`: Public IP address of the cloud server
* `gitlab_admin_password`: Password for the `root` login

For multi-line values, the response will come in an escaped form. To get rid of
the escapes, use `echo -e '<STRING>' > file.txt`. For vim users, a substitution
can be done within a file using `%s/\\n/\r/g`.

Stack Details
=============
#### Getting Started
[GitLab](http://gitlab.org/gitlab-ce/) is an open source, web based
application that enables users to collaborate on code.

#### Accessing Your Deployment
To access your GitLab deployment, take the IP of the GitLab server and plug
it in your browser. By default it will redirect you to https and you'll get a
warning since a self signed certificate is installed.

Login as `root` using the password stored in the output `gitlab_admin_password`.

#### Logging in via SSH
The private key provided in the passwords section can be used to login as
root via SSH.  We have an article on how to use these keys with [Mac OS X
and Linux](http://www.rackspace.com/knowledge_center/article/logging-in-with-a-ssh-private-key-on-linuxmac)
as well as [Windows using
PuTTY](http://www.rackspace.com/knowledge_center/article/logging-in-with-a-ssh-private-key-on-windows).

#### Details of Your Setup
Gitlab is installed using the [Gitlab Omnibus installer](https://gitlab.com/gitlab-org/omnibus-gitlab)

Full documentation is available in [the Gitlab Omnibus README file](https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/README.md).

* [How to start and stop gitlab components](https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/README.md#starting-and-stopping)

Contributing
============
There are substantial changes still happening within the [OpenStack
Heat](https://wiki.openstack.org/wiki/Heat) project. Template contribution
guidelines will be drafted in the near future.

License
=======
```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
