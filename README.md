## Edge Gateway for the IT/OT convergence - NIOT-E-TIJCX-GB

For platform details read on [here](https://www.netiot.com/netiot/netiot-edge/).

### Passive fieldbus raw data access from container example

The image provided hereunder deploys a container which contains all necessary libraries to grant access to raw frame data of the passive fieldbus interface.
Note, that using the passive fieldbus interface requires an appropriate license on the NIOT-E-TIJCX-GB edge gateway.

Base of this image builds a tagged version of [ubuntu](https://hub.docker.com/r/library/ubuntu/tags/14.04/) with enabled [SSH](https://en.wikipedia.org/wiki/Secure_Shell).

#### Container prerequisites

##### Port mapping

The image SSH port `22` needs to be mapped to an unused gateway port, e.g. `22` to be available for remote access.

##### Privileged mode

Only the privileged mode option lifts the enforced container limitations to allow usage of the passive fieldbus interface in a container.

#### Container start

Pulling the image from Docker Hub may take up to 5 minutes average. 

#### Getting started

STEP 1. Open the gateway's landing page under `https://<gateways's ip address>`. 

STEP 2. Click the Docker tile to open the [Portainer.io](http://portainer.io/) Docker management user interface. 

STEP 3. Enter the following parameters under **Containers > Add Container**

* **Image**: `hilschernetiotedge/netiot-edge-ubuntu-ssh-passive-fieldbus-raw`

* **Restart policy**: `always`

* **Port mapping**: `Host: 22 -> Container: 22`

* **Runtime > Privileged mode** : `On`

* **Runtime > Devices > add device**
**Host path:** `/dev/netanalyzer_0`
**Container path:** `/dev/netanalyzer_0`

STEP 4. Press the button **Actions > Start container**

#### Accessing

The container starts the SSH service automatically. 
Login to it with an SSH client such as [putty](http://www.putty.org/) using the gateway's IP address along with the mapped SSH port. Use the credentials `root` as user and `root` as password when asked and you are logged in as root.

Access to passive filedbus raw frame data is enabled via the popular libpcap library. The required special libpcap version is already provided within the Docker image.
See the [libpcap project](http://www.tcpdump.org/) for details about the libpcap API.

#### Give it a try

As the passive fieldbus interface is available as a standard libpcap capture device, popular network analyzers such as [tshark](https://www.wireshark.org/) are able to use the capture interface directly.
`tshark` and `dumpcap` are already provided within the given Docker image.

Login via SSH and start `dumpcap -D` to list all available capture devices.
You should see following output:
```
1. eth0
2. any
3. lo (Loopback)
4. nflog
5. nfqueue
6. sit0
7. cifXANALYZER_0
```
Where `cifXANALYZER_0` represents the passive fieldbus interface.

To start a capture type `dumpcap -i cifXANALYZER_0` or `tshark -i cifXANALYZER_0` respectively


### GitHub sources
The image is built from the GitHub project [passive-fieldbus-raw](https://github.com/hilschernetiotedge/passive-fieldbus-raw). It complies with the [Dockerfile](https://docs.docker.com/engine/reference/builder/) method to build a Docker image [automated](https://docs.docker.com/docker-hub/builds/). 

   
[![N|Solid](http://www.hilscher.com/fileadmin/templates/doctima_2013/resources/Images/logo_hilscher.png)](http://www.hilscher.com)  Hilscher Gesellschaft fuer Systemautomation mbH  www.hilscher.com
