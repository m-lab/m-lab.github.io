---
layout: page
permalink: /data/
title: "Data"
page-title: "M-Lab Data"
menu-item: true
breadcrumb: data
---

# Data Publishing

M-Lab publishes its data in two forms:

* Google Cloud Storage
  * M-Lab publishes raw output from its measurement tools on Google Cloud Storage as file archives.
  * See [M-Lab Google Cloud Storage documentation]({{ site.baseurl }}/data/gcs) for more information.
* Google BigQuery
  * M-Lab parses data for a subset of its tools and publishes the data on BigQuery so that users can run SQL queries on the data.
  * See [M-Lab BigQuery QuickStart]({{ site.baseurl }}/data/bq/quickstart) for more information.

There is typically at least a 24-hour delay between data collection and data publication.

## Data License and Citing M-Lab Data

All data collected by M-Lab tests are available to the public without restriction under a [No Rights Reserved Creative Commons Zero Waiver](http://creativecommons.org/about/cc0){:target="_blank"}.

Please cite M-Lab data sets as follows:

The M-Lab *test name* Data Set, *date range used*. *M-Lab test URL*

For example:

The M-Lab NDT Data Set 2009-02-11–2015-12-21. [https://measurementlab.net/tools/ndt]({{ site.baseurl }}/tools/ndt)