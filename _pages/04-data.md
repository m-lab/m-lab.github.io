---
layout: page
permalink: /data/
title: "Data"
page-title: "Overview"
menu-item: true
breadcrumb: data
---

# About M-Lab's Data  

M-Lab stores our canonical raw data in [Google Cloud Storage](https://console.developers.google.com/storage/browser/m-lab/). Google Cloud Storage contains all of our data in raw form (no parsing). Additionally, we parse a copy of our raw data for a subset of our tests into [BigQuery tables](https://bigquery.cloud.google.com/queries/measurement-lab), so that the data is queryable through a SQL interface. 

Raw data is updated hourly and BigQuery tables are updated every day with data from M-Lab logs collected the day before. As a consequence, there is typically at least a 24-hour delay between data collection and data publication.

## Data License and Citing M-Lab Data

All data collected by M-Lab tests are available to the public without restriction under a [No Rights Reserved Creative Commons Zero Waiver](http://creativecommons.org/about/cc0).

Please cite M-Lab datasets as follows:
 
- The M-Lab _test name_ Dataset, _date range used_. _M-Lab test URL_

For example:

- The M-Lab NDT Dataset 2009-02-11 - 2015-12-21. [https://measurementlab.net/tools/ndt](https://measurementlab.net/tools/ndt)

## Choose how you want to access M-Lab data

M-Lab data can be queried using BigQuery, using the command line tools available in the Google Cloud SDK, or by a custom application that uses the Google Cloud SDK.

For more information, please review our other documentation in this section:

-   [Google Cloud Storage](/data/gcs)
-   [BigQuery QuickStart](/data/bq/quickstart)
-   [BigQuery Examples](/data/bq/examples)
-   [BigQuery Schema](/data/bq/schema)