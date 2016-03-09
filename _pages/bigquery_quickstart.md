---
layout: page
title: "BigQuery QuickStart"
permalink: /data/bq/quickstart/
breadcrumb: data
---

## BigQuery QuickStart - Using M-Lab Data

Whether you want to access M-Lab's raw data, search it using BigQuery, or build your own application using it, follow these quick steps to get started:

-   Choose a Google account to use for your queries or application
-   Subscribe that account to [M-Lab's Discuss group](https://groups.google.com/a/measurementlab.net/forum/#!forum/discuss). 
-   Enable billing for the account in the [Google Cloud Platform Console](https://console.developers.google.com/)

Any Gmail, Google Apps account (Business, Non-profit, etc.), can be used, however developer "service accounts" are not supported. In any case, the email address you choose should be the one also used with your Google Cloud Platform Console.

Subscribing to [M-Lab's Discuss group](https://groups.google.com/a/measurementlab.net/forum/#!forum/discuss) whitelists the account so no query charges are incurred when searching the M-Lab dataset.

Because BigQuery is a part of the Google Cloud Platform, in order to use BigQuery you must have a Google account and enable billing from within [Google Cloud Platform Console](https://console.developers.google.com/).

You will **not** be charged for queries against tables in the M-Lab dataset. M-Lab is committed to open data and offering our data free of charge is part of that commitment.

## BigQuery Web Interface

M-Lab data is easily queried using Google’s web interface to BigQuery. Learn more on our [BigQuery QuickStart page](/data/bq/quickstart/). 

## BigQuery tools in the Google Cloud SDK

You may also run queries at the command line using BigQuery tools in the Google Cloud SDK.

Download and Install [Google’s Cloud SDK](https://cloud.google.com/sdk/) using the Installation and Quick Start instructions for your operating system. 

After installation, authentication and restarting your terminal, BigQuery’s command line tools are available in your shell. If you are new to BigQuery, we suggest that you next consult the resources below to get started: 

-   [M-Lab's BigQuery QuickStart Guide](/data/bq/quickstart/)
-   [Google’s BigQuery documentation](https://cloud.google.com/bigquery/what-is-bigquery)
-   [Google's bq Command-Line Tool Quickstart documentation](https://cloud.google.com/bigquery/bq-command-line-tool-quickstart)

## Custom Google Cloud Application using the Big Query API

Given the resources and expertise, you can develop your own web application that uses M-Lab data and tools. To learn more about building your own custom application in the [Google Cloud Platform documentation](https://cloud.google.com/docs/).

**Telescope** is an example of an application that M-Lab developed which uses the BigQuery Python API to download M-Lab data.

[Telescope is available from M-Lab on Github](https://github.com/m-lab/telescope).