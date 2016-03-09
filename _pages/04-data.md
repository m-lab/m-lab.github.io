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
 
- The M-Lab `test name` Dataset, `date range used`. `M-Lab test URL`

For example:

- The M-Lab NDT Dataset 2009-02-11 - 2015-12-21 [https://measurementlab.net/tools/ndt](https://measurementlab.net/tools/ndt)

## Getting Started with M-Lab Data

### Subscribe to the M-Lab Discuss List to Whitelist Your Account

Whether you want to access M-Lab's raw data, search it using BigQuery, or build your own application using it, follow these quick steps to get started:

- Choose a Google account to use for your queries or application
- Subscribe that account to [M-Lab's Discuss group](https://groups.google.com/a/measurementlab.net/forum/#!forum/discuss). 
- Enable billing for the account in the [Google Cloud Platform Console](https://console.developers.google.com/)

Any Gmail, Google Apps account (Business, Non-profit, etc.), can be used, however developer "service accounts" are not supported. In any case, the email address you choose should be the one also used with your Google Cloud Platform Console.

Subscribing to [M-Lab's Discuss group](https://groups.google.com/a/measurementlab.net/forum/#!forum/discuss) whitelists the account so no query charges are incurred when searching the M-Lab dataset.

Because BigQuery is a part of the Google Cloud Platform, in order to use BigQuery you must have a Google account and enable billing from within [Google Cloud Platform Console](https://console.developers.google.com/).

You will **not** be charged for queries against tables in the M-Lab dataset. M-Lab is committed to open data and offering our data free of charge is part of that commitment.

## Choose how you want to access M-Lab data

M-Lab data can be queried using the BigQuery web interface, using the command line tools available in the Google Cloud SDK, or by a custom application that uses the Google Cloud SDK. Raw data is also available. 

### BigQuery Web Interface

M-Lab data is easily queried using Google’s web interface to BigQuery. Learn more on our [BigQuery QuickStart page](/data/bq/quickstart/). 

### BigQuery tools in the Google Cloud SDK

You may also run queries at the command line using BigQuery tools in the Google Cloud SDK.

Download and Install [Google’s Cloud SDK](https://cloud.google.com/sdk/) using the Installation and Quick Start instructions for your operating system. 

After installation, authentication and restarting your terminal, BigQuery’s command line tools are available in your shell. If you are new to BigQuery, we suggest that you next consult the resources below to get started: 

- [M-Lab's BigQuery QuickStart Guide](/data/bq/quickstart/)
- [Google’s BigQuery documentation](https://cloud.google.com/bigquery/what-is-bigquery)
- [Google's bq Command-Line Tool Quickstart documentation](https://cloud.google.com/bigquery/bq-command-line-tool-quickstart)

### Custom Google Cloud Application using the Big Query API

Given the resources and expertise, you can develop your own web application that uses M-Lab data and tools. To learn more about building your own custom application in the [Google Cloud Platform documentation](https://cloud.google.com/docs/).

**Telescope** is an example of an application that M-Lab developed which uses the BigQuery Python API to download M-Lab data.

[Telescope is available from M-Lab on Github](https://github.com/m-lab/telescope).
