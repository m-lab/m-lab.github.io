---
layout: page
title: Google Cloud Storage
permalink: /data/gcs/
breadcrumb: data
---

* Table of Contents
{:toc}

# Google Cloud Storage

M-Lab publishes all data it collects in raw form as archives on Google Cloud Storage (GCS) at the following location:

[https://console.developers.google.com/storage/browser/m-lab/](https://console.developers.google.com/storage/browser/m-lab/){:target="_blank"}

## File Layout

All M-Lab files are packaged and compressed in [.tar format](https://en.wikipedia.org/wiki/Tar_%28computing%29){:target="_blank"}. They are placed in folders and named according to the following schema:

`[tool]/[YYYY]/[MM]/[DD]/[YYYYMMDD]T[HHMMSS]-[server]-[tool]-[file index].tgz`

* `tool`: The measurement tool that generated the data
* `YYYYMMDDTHHMMSS`: Start of the time window in which the data were collected
* `server`: M-Lab server that collected the data
* `file index`: Index of the file

This means that each compressed .tgz file contains all the data collected during a single day, by a single tool running on a single M-Lab server.

If the data collected during one day by one tool on one server are more than 1 GB (uncompressed), the files are split into multiple compressed .tgz files of up to 1 GB in size.

For example, the compressed .tgz file `20090218T000000Z-mlab1-lga01-ndt-0000.tgz` contains the first 1 GB of data collected by all the NDT tests that were served by the M-Lab server mlab1-lga01 on Feb 18, 2009.

## Project Data

Direct links to each M-Lab project's raw data are available below:

* [Glasnost](https://console.developers.google.com/storage/browser/m-lab/glasnost/){:target="_blank"}
  * Glasnost detects prioritization or censorship of network traffic.
  * More information is available at [MPI SWS](http://broadband.mpi-sws.org/transparency/bttest-mlab.php){:target="_blank"} and [Github](https://github.com/marcelscode/glasnost){:target="_blank"}.
* [NDT](https://console.developers.google.com/storage/browser/m-lab/ndt/){:target="_blank"}
  * Network Diagnostic Tool (NDT) measures characteristics of a TCP connection under heavy load.
  * More information is available at [Internet2](http://software.internet2.edu/ndt/){:target="_blank"} and [Github](https://github.com/ndt-project/ndt){:target="_blank"}.
* [Neubot](https://console.developers.google.com/storage/browser/m-lab/neubot/){:target="_blank"}
  * Neubot measures the Internet in order to gather data useful to study broadband performance, network neutrality, and Internet censorship.
  * More information is available at [Nexa Center](https://neubot.nexacenter.org/){:target="_blank"} and [Github](https://github.com/neubot){:target="_blank"}.
* [NPAD](https://console.developers.google.com/storage/browser/m-lab/npad/){:target="_blank"}
  * Network Path and Application Diagnosis (NPAD) diagnoses issues in a network path that can degrade network performance.
  * More information is available at [UCAR](http://www.ucar.edu/npad/){:target="_blank"} and [Github](https://github.com/npad/npad){:target="_blank"}.
* [OONI](https://console.developers.google.com/storage/browser/m-lab/ooni/){:target="_blank"}
  * OONI measures censorship, surveillance, and traffic manipulation on the Internet.
  * More information is available at [OONI](https://ooni.torproject.org/){:target="_blank"}
* [Paris Traceroute](https://console.developers.google.com/storage/browser/m-lab/paris-traceroute/){:target="_blank"}
  * Paris Traceroute maps network topology between two points on the Internet.
  * More information is available at [Paris Traceroute](http://www.paris-traceroute.net/){:target="_blank"}
* [pathload2](https://console.developers.google.com/storage/browser/m-lab/pathload2/){:target="_blank"} (**deprecated**)
  * **M-Lab no longer supports this tool, but its archived data are available on GCS. For similar measurements with a current and supported tool, see NDT.**
  * Pathload2 measures the available bandwidth of an Internet connection.
  * More information is available at [https://code.google.com/p/pathload2-gatech/](https://code.google.com/p/pathload2-gatech/){:target="_blank"}.
* [ShaperProbe](https://console.developers.google.com/storage/browser/m-lab/shaperprobe/){:target="_blank"} (**deprecated**)
  * **M-Lab no longer supports this tool, but its archived data are available on GCS.**
  * ShaperProbe detects prioritization of network traffic.
  * More information is available at [ShaperProbe](http://netinfer.net/diffprobe/shaperprobe.html){:target="_blank"}.
* [SideStream](https://console.developers.google.com/storage/browser/m-lab/sidestream/){:target="_blank"}
  * SideStream collects TCP state information about completed TCP connections on a system.
  * More information is available on [Github](https://github.com/npad/sidestream){:target="_blank"}.
* [mlab-collectd](https://console.developers.google.com/storage/browser/m-lab/utilization/){:target="_blank"}
  * mlab-collectd is a monitoring tool for M-Lab slices, which collects resource utilization information about all M-Lab servers.
  * More information is available on [Github](https://github.com/m-lab/collectd-mlab){:target="_blank"}.

## Accessing Data Programmatically

### Accessing data with `gsutil`

The easiest way to access M-Lab data on GCS programmatically is by using the [`gsutil`](https://cloud.google.com/storage/docs/gsutil) command-line utility.

~~~ shell
# List the contents of the M-Lab NDT data in GCS.
$ gsutil ls -l gsutil ls -l gs://m-lab/

# Copy a file from GCS locally.
$ gsutil cp gs://m-lab/ndt/2009/02/18/20090218T000000Z-mlab1-lga01-ndt-0000.tgz .
~~~

### Accessing data with common HTTP tools

The URLs shown in [M-Lab's GCS web interface](https://console.developers.google.com/storage/browser/m-lab/){:target="_blank"} require the user to be logged in, which can present challenges when attempting to access the data with common HTTP utilities like `curl` or `wget`.

You can access M-Lab files programmatically by replacing:

`storage.cloud.google.com/m/cloudstorage/`

with

`storage.googleapis.com`

in any GCS URL.

For example, if the URL of a raw NDT archive on the GCS web application is:

[https://storage.cloud.google.com/m/cloudstorage/b/m-lab/o/ndt/2015/12/28/20151228T000000Z-mlab1-lga04-ndt-0001.tgz](https://storage.cloud.google.com/m/cloudstorage/b/m-lab/o/ndt/2015/12/28/20151228T000000Z-mlab1-lga04-ndt-0001.tgz)

You can access it without authentication via this URL:

[https://storage.googleapis.com/m-lab/ndt/2015/12/28/20151228T000000Z-mlab1-lga04-ndt-0001.tgz](https://storage.googleapis.com/m-lab/ndt/2015/12/28/20151228T000000Z-mlab1-lga04-ndt-0001.tgz)

### GCS File Index

A list of all M-Lab files in GCS is available at:

[https://storage.googleapis.com/m-lab/list/all_mlab_tarfiles.txt.gz](http:///h)

This file provides gs:// URLs to M-Lab data.

To change these URLs to https:// URLs (compatible with common HTTP tools), you can convert the file using the following [bash](https://en.wikipedia.org/wiki/Bash_%28Unix_shell%29) script:

~~~ shell
$ curl https://storage.googleapis.com/m-lab/list/all_mlab_tarfiles.txt.gz | gunzip | \
while read; do echo ${REPLY/gs:\/\//https://storage.googleapis.com/}; done
~~~