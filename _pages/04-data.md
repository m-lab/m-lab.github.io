---
layout: page
permalink: /data/
title: "Data"
page-title: "Overview"
menu-item: true
breadcrumb: data
---

# Getting Started with M-Lab Data 

M-Lab stores our canonical data from all tools in Google's Big Query platform. We have prepared this guide to help new researchers to begin searching M-Lab data using Big Query's web interface or using the command line tools in Google's Cloud SDK. Data collected since January 2009 for three M-Lab tests is available in Big Query: [Network Diagnostic Tool (NDT)](https://console.developers.google.com/storage/browser/m-lab/ndt/), [Network Path and Application Diagnosis (NPAD)](https://console.developers.google.com/storage/browser/m-lab/npad/), and [Paris-Traceroute](https://console.developers.google.com/storage/browser/m-lab/paris-traceroute/). Big Query tables are updated every day with data from M-Lab logs collected the day before. As a consequence, there is typically at least a 24-hour delay between data collection and data publication.

## Subscribe to the M-Lab Discuss List to Whitelist Your Account

Before searching M-Lab data in Big Query, you first need to subscribe to the M-Lab Discuss List to whitelist your account.

When an account is subscribed to [M-Lab's Discuss group](https://groups.google.com/a/measurementlab.net/forum/#!forum/discuss), it is automatically whitelisted to query our data in Big Query. Any Gmail, Google Apps account (Business, Non-profit, etc.), can be used. Subscribe to the Discuss Google Group using the Gmail account or developer service account you wish to use to query M-Lab data.   

After subscribing to M-Lab Discuss, you will be able to query M-Lab's data at no cost.

## Choose how you want to access M-Lab data

M-Lab data can be queried using the Big Query web interface, using the command line tools available in the Google Cloud SDK, or by a custom application that uses the Google Cloud SDK. Raw data is also available. 

### Big Query Web Interface

M-Lab data is easily queried using Google’s web interface to Big Query. Learn more on our [BigQuery QuickStart page](/data/bq/quickstart/). 

### Big Query tools in the Google Cloud SDK

While M-Lab data is easily queried using Google’s web interface to Big Query, researchers may wish to run queries at the command line.

Download and Install [Google’s Cloud SDK](https://cloud.google.com/sdk/) using the Installation and Quick Start instructions for your operating system. 

After installation, authentication and restarting your terminal, Big Query’s command line tools are available in your shell. New to Big Query? We suggest that you next  consult [Google’s Big Query documentation](https://cloud.google.com/bigquery/what-is-bigquery) to get started.

Researchers should also use the [bq Command-Line Tool Quickstart](https://cloud.google.com/bigquery/bq-command-line-tool-quickstart) as reference documentation. 

#### Custom Google Cloud Application using the Big Query API

Given the resources and expertise, you can develop your own web application that uses M-Lab data and tools. To learn more about building your own custom application in the [Google Cloud Platform documentation](https://cloud.google.com/docs/).
