---
layout: page
title: "BigQuery Schema"
permalink: /data/docs/bq/schema/
breadcrumb: data
---

# BigQuery Schema

## Background

* Each M-Lab tool consists of a **client** and a **server**.
* Whenever an M-Lab user starts a test, the client and server interact to measure different aspects of that user's connection.
* A single user request triggers one or more **tests** (e.g., client-to-server test, server-to-client test).
* For each test, a server collects a **log**, and the test can be uniquely identified by its log filename.

## BigQuery Storage and Processing Datasets

For each release, M-Lab publishes tables and views in two groups of datasets. One group of datasets is used primarily for storage and processing, and another group which we recommended that most researchers use to query for M-Lab data.

Four _storage and processing datasets_ are published for each release, beginning with v3.1:

* **base_tables**
  * Contains the raw NDT, Sidestream, and Paris Traceroute tables.
  * This dataset will eventually hold all M-Lab data, from 2009 to present.

* **batch**
  * Destination for batch processed data prior to dedupping.

* **intermediate_vX_X_X**
  * Provides working, intermediate BigQuery Views for each release version
  * These views adapt data from tables in the **base_tables** dataset to make **release** views available.
  * Intermediate dataset views are publicly visible for transparency, but we discourage most people from using them directly.

* **legacy**
  * Contains exact copies of the data stored in our previous project tables, for use in the intermediate and release views.

## Recommended Datasets for Most Researcher Queries

The datasets in the previous section outline where raw M-Lab test data is parsed and stored. While they are also queryable in the above locations, M-Lab recommends that most researchers instead begin querying the views published in our **release** dataset. This will make future table schema transitions less impactful since queries can be pinned to the release views instead of to a specific table name.

Three _researcher query datasets_ are published for each new release:

* **rc**
  * Beta test version of the next release of views.
  * These views represent the most recent _release-candidate_.

* **rc_vX_X**
  * Recent stable releases.

* **release**
  * An alias to current supported release.
  * This is the set of views that most people should use.
  * These views are updated to include any refinements to the recommended filtering, and may include changes to the schema over time.

Beginning with the upcoming v3.1 release, in the **rc**, **rc_vX_X**, and **release** datasets we will publish the following views:

* _ndt_all_
* _ndt_all_legacysql_
* _ndt_downloads_
* _ndt_downloads_legacysql_
* _ndt_uploads_
* _ndt_uploads_legacysql_

The views above ending in `_legacysql` require you to use [legacySQL](https://cloud.google.com/bigquery/docs/reference/legacy-sql) queries, and those labeled without it `(standardSQL)` require you the use of [standardSQL](https://cloud.google.com/bigquery/docs/reference/standard-sql/) queries. Additionally, the views which include '_uploads_' or '_downloads_' provide a subset of NDT data that are valid, completed tests which meet the criteria described on our page, [Calculating Common Metrics](https://www.measurementlab.net/data/docs/bq/ndtmetrics/). We highly recommend using standardSQL as this will be required to query all M-Lab tables in the future.

Researchers interested in querying unfiltered NDT, Sidestream, or Paris Traceroute data should use the appropriate table in the **base_tables** dataset:

* **base_tables**
  * ndt - `measurement-lab.base_tables.ndt`
  * sidestream - `measurement-lab.base_tables.sidestream`
  * traceroute - `measurement-lab.base_tables.traceroute`

## Summary of BigQuery Tables (v3.1)

The current version of M-Lab BigQuery tables is v3.1, and are listed below. Tables are **bolded** and table views are listed underneath where applicable.

### Historical Data and Current Data Base Tables

* **[measurement-lab.legacy.ndt](https://bigquery.cloud.google.com/table/measurement-lab:legacy.ndt)** (data ~ 2015-01-01 - 2017-05-10)
* **[measurement-lab.legacy.ndt_pre2015](https://bigquery.cloud.google.com/table/measurement-lab:legacy.ndt_pre2015)** (data ~ 2009-02-18 - 2014-12-31)
* **[measurement-lab.base_tables.ndt](https://bigquery.cloud.google.com/table/measurement-lab:base_tables.ndt)**
* **[measurement-lab.base_tables.sidestream](https://bigquery.cloud.google.com/table/measurement-lab:base_tables.sidestream)**
* **[measurement-lab.base_tables.traceroute](https://bigquery.cloud.google.com/table/measurement-lab:base_tables.traceroute)**

### Recommended Views for Research Queries

* **[measurement-lab.rc](https://bigquery.cloud.google.com/dataset/measurement-lab:rc)**
* **[measurement-lab.rc_v3_1](https://bigquery.cloud.google.com/dataset/measurement-lab:rc_v3_1)**
* **[measurement-lab.release](https://bigquery.cloud.google.com/dataset/measurement-lab:release)**
  * [_measurement-lab.release.ndt_all_](https://bigquery.cloud.google.com/table/measurement-lab:release.ndt_all)
  * [_measurement-lab.release.ndt_all_legacysql_](https://bigquery.cloud.google.com/table/measurement-lab:release.ndt_all_legacysql)
  * [_measurement-lab.release.ndt_downloads_](https://bigquery.cloud.google.com/table/measurement-lab:release.ndt_downloads)
  * [_measurement-lab.release.ndt_downloads_legacysql_](https://bigquery.cloud.google.com/table/measurement-lab:release.ndt_downloads_legacysql)
  * [_measurement-lab.release.ndt_uploads_](https://bigquery.cloud.google.com/table/measurement-lab:release.ndt_uploads)
  * [_measurement-lab.release.ndt_uploads_legacysql_](https://bigquery.cloud.google.com/table/measurement-lab:release.ndt_uploads_legacysql)

If you have queries that reference historical M-Lab tables, please review [Migrating Queries]({{ site.baseurl }}/data/docs/bq/legacymigration/) to learn how to convert them to use M-Lab's **release** views.

Please also review the table/view schema version history and changelog at the end of this page for more information.

## Equivalent BigQuery and Web100 Field Types

[tcp-kis.txt](https://cloud.google.com/bigquery/docs/tcp-kis.txt){:target="_blank"} defines each Web100 variable with a specific [SNMP type](http://tools.ietf.org/html/rfc4898){:target="_blank"}. This table shows how to map each SNMP type to a BigQuery type.

<div class="table-responsive" markdown="1">

| BigQuery Type |  Corresponding SNMP Type |
| ------------- | -------------------------|
| `integer`     |  `Integer32`, `Integer`, `INTEGER`, `Gauge32`, `ZeroBasedCounter32`, `Unsigned32`, `Unsigned16`, `Counter32`, `ZeroBasedCounter64` |
| `string`      |  `Ip_Address`            |
| `bool`        |  `TruthValue`            |

</div>

## Blacklist Flags Field

The ```anomalies.blacklist_flags``` field is used to mark test results that could be impacted by site configuration issues, or otherwise communicate potentially relevant information about the state of the platform at the time of the test. This field was created to mark tests affected by the "switch discard issue" identified in 2015-2016, but M-Lab may use the field for other use cases in the future.

Currently, the following values are present in our data in this field:

| Field Name | Value | Description |
| ---------- | ----- | ----------- |
| `blacklist_flags` | `0` or `NULL` | unaffected tests |
| | `1` | tests affected by switch discards |
| | `2` | tests not shown to be unaffected by switch discards |

## Table Schemas (v3.1)

The schemas for NDT, Sidestream, and Paris Traceroute are provided below. Note that the schemas for **release** views of NDT are largely the same as listed below with the exception of the date partition field.

### NDT `measurement-lab.base_tables.ndt`

<div class="table-responsive" markdown="1">

| Field name                                           |     Type     |  Description                              |
| :----------------------------------------------------|:------------:|:------------------------------------------|
| `_PARTITIONTIME`                                    | `timestamp`  |  This pseudo column contains a timestamp for the start of the day (in UTC) in which the data was loaded. For the YYYYMMDD partition, this pseudo column will contain the value TIMESTAMP('YYYY-MM-DD'). |
| `test_id`                                           |  `string`    |  ID of the test. It represents the filename of the log that contains the data generated during the test (e.g. `20090819T02:01:04.507508000Z_189.6.232.77:3859.c2s_snaplog.gz`). |
| `task_filename`                                      | `string`     |  The raw data file in Google Cloud Storage from which the test row was parsed. |
| `parse_time`                                         | `timestamp`  |  Timestamp of when test data was parsed into BigQuery from Google Cloud Storage. |
| `log_time`                                           | `timestamp`  |  Timestamp of when test log was created (in seconds since Unix epoch).<br><br>For NDT and NPAD, this is derived from the "Date/Time" field in the .meta file (for NDT and NPAD, prefer the `web100_log_entry.log_time` field, as it is more reliable).<br><br>For SideStream and Paris Traceroute, this is the timestamp as represented in the test log file's filename.  |
| `blacklist_flags`                                    |  `integer` |  Deprecated field formerly used to store blacklist flags. Superceded by `anomalies.blacklist_flags`. |
| `anomalies`                                          | `record`  | A sub-record section containing anomalies fields. |
| `anomalies.no_meta`                                  | `boolean` | If a test record did not contain a metadata file, this field is set to 1. |
| `anomalies.snaplog_error`                            | `boolean` | If there are erros in the snaplogs for a test, this field is set to 1. |
| `anomalies.num_snaps`                                | `integer` | A count of the number of snaplogs captured during a given test. |
| `anomalies.blacklist_flags`                          | `integer` | Used to mark test results that could be impacted by site configuration issues, or otherwise communicate potentially relevant information about the state of the platform at the time of the test. Please see the [blacklist_flags section]({{ site.baseurl }}/data/docs/bq/schema/#blacklist-flags-field) below for more information. |
| `connection_spec`                                   | `record`    | Sub-record section containing fields describing the client which initiated a test and the M-Lab server through which the test was conducted. |
| `connection_spec.client_af`                          | `integer`   |  Address family of the client's IP address. (This field is **optional**.) |
| `connection_spec.client_application`                 | `string`    |  Client application that ran the test. (This field is **optional**.) |
| `connection_spec.client_browser`                     | `string`    |  Client's browser. (This field is **optional**.) |
| `connection_spec.client_hostname`                    | `string`    |  Client's hostname. (This field is **optional**.) |
| `connection_spec.client_ip`                          | `string`    |  IP address of the user's client. (This field is **optional**. It's preferable to use `web100_log_entry.connection_spec.remote_ip`.) |
| `connection_spec.client_kernel_version`              | `string`    |  Client's kernel version. (This field is **optional**.) |
| `connection_spec.client_os`                          | `string`    |  Client's operating system. (This field is **optional**.) |
| `connection_spec.client_version`                     | `string`    |  Client's version. (This field is **optional**.) |
| `connection_spec.data_direction`                     | `integer` |  Direction of the data sent during the test:<br>CLIENT_TO_SERVER = `0`<br>SERVER_TO_CLIENT = `1` |
| `connection_spec.server_af`                          | `integer` |  Address family of the server's IP address. (This field is **optional**. It's preferable to use `web100_log_entry.connection_spec.local_af`.) |
| `connection_spec.server_hostname`                    | `string`    |  Server's hostname. (This field is **optional**.) |
| `connection_spec.server_ip`                          | `string`    |  Server's IP address. (This field is **optional**. It's preferable to use `web100_log_entry.connection_spec.local_ip`.) |
| `connection_spec.server_kernel_version`              | `string`    |  Server's kernel version. (This field is **optional**.) |
| `connection_spec.tls`                                | `boolean` |                                        |
| `connection_spec.websockets`                         | `boolean` |                                        |
| `connection_spec.client_geolocation`                 | `record`  | Sub-record section containing geolocation annotations for the client that initiated the test. Geolocation fields extracted from open dataset created by MaxMind and available at [www.maxmind.com](https://www.maxmind.com). (These fields are **optional**.)|
| `client_geolocation.area_code`                       | `integer` |  |
| `client_geolocation.city`                            | `string`    |                                        |
| `client_geolocation.continent_code`                  | `string`    |                                        |
| `client_geolocation.country_code`                    | `string`    |                                        |
| `client_geolocation.country_code3`                   | `string`    |                                        |
| `client_geolocation.country_name`                    | `string`    |                                        |
| `client_geolocation.latitude`                        | `float`     |                                        |
| `client_geolocation.longitude`                       | `float`     |                                        |
| `client_geolocation.metro_code`                      | `integer` |                                        |
| `client_geolocation.postal_code`                     | `string`    |                                        |
| `client_geolocation.region`                          | `string`    |                                        |
| `connection_spec.server_geolocation`                 | `record`  | Sub-record section containing geolocation annotations for the M-Lab server that received the test. Geolocation fields extracted from open dataset created by MaxMind and available at [www.maxmind.com](https://www.maxmind.com). (These fields are **optional**.)
| `server_geolocation.area_code`                       | `integer` |                                        |
| `server_geolocation.city`                            | `string`    |                                        |
| `server_geolocation.continent_code`                  | `string`    |                                        |
| `server_geolocation.country_code`                    | `string`    |                                        |
| `server_geolocation.country_code3`                   | `string`    |                                        |
| `server_geolocation.country_name`                    | `string`    |                                        |
| `server_geolocation.latitude`                        | `float`     |                                        |
| `server_geolocation.longitude`                       | `float`     |                                        |
| `server_geolocation.metro_code`                      | `integer` |                                        |
| `server_geolocation.postal_code`                     | `string`    |                                        |
| `server_geolocation.region`                          | `string`    |                                        |
| `web100_log_entry`                                   | `record`  | Sub-record section containing the web100 variables collected during the test. See [tcp-kis.txt](https://cloud.google.com/bigquery/docs/tcp-kis.txt){:target="_blank"} for more information about these fields. |
| `web100_log_entry.log_time`                          | `integer` |                                        |
| `web100_log_entry.version`                           | `string`    |                                        |
| `web100_log_entry.connection_spec.local_af`          | `integer` |   |
| `web100_log_entry.connection_spec.local_ip`          | `string`    |                                        |
| `web100_log_entry.connection_spec.local_port`        | `integer` |                                        |
| `web100_log_entry.connection_spec.remote_ip`         | `string`    |                                        |
| `web100_log_entry.connection_spec.remote_port`       | `integer` |                                        |
| `web100_log_entry.snap.AbruptTimeouts`               | `integer` |                                        |
| `web100_log_entry.snap.ActiveOpen`                   | `integer` |                                        |
| `web100_log_entry.snap.CERcvd`                       | `integer` |                                        |
| `web100_log_entry.snap.CongAvoid`                    | `integer` |                                        |
| `web100_log_entry.snap.CongOverCount`                | `integer` |                                        |
| `web100_log_entry.snap.CongSignals`                  | `integer` |                                        |
| `web100_log_entry.snap.CountRTT`                     | `integer` |                                        |
| `web100_log_entry.snap.CurAppRQueue`                 | `integer` |                                        |
| `web100_log_entry.snap.CurAppWQueue`                 | `integer` |                                        |
| `web100_log_entry.snap.CurCwnd`                      | `integer` |                                        |
| `web100_log_entry.snap.CurMSS`                       | `integer` |                                        |
| `web100_log_entry.snap.CurRTO`                       | `integer` |                                        |
| `web100_log_entry.snap.CurReasmQueue`                | `integer` |                                        |
| `web100_log_entry.snap.CurRetxQueue`                 | `integer` |                                        |
| `web100_log_entry.snap.CurRwinRcvd`                  | `integer` |                                        |
| `web100_log_entry.snap.CurRwinSent`                  | `integer` |                                        |
| `web100_log_entry.snap.CurSsthresh`                  | `integer` |                                        |
| `web100_log_entry.snap.CurTimeoutCount`              | `integer` |                                        |
| `web100_log_entry.snap.DSACKDups`                    | `integer` |                                        |
| `web100_log_entry.snap.DataSegsIn`                   | `integer` |                                        |
| `web100_log_entry.snap.DataSegsOut`                  | `integer` |                                        |
| `web100_log_entry.snap.DupAcksIn`                    | `integer` |                                        |
| `web100_log_entry.snap.DupAcksOut`                   | `integer` |                                        |
| `web100_log_entry.snap.Duration`                     | `integer` |                                        |
| `web100_log_entry.snap.ECN`                          | `integer` |                                        |
| `web100_log_entry.snap.FastRetran`                   | `integer` |                                        |
| `web100_log_entry.snap.HCDataOctetsIn`               | `integer` |                                        |
| `web100_log_entry.snap.HCDataOctetsOut`              | `integer` |                                        |
| `web100_log_entry.snap.HCThruOctetsAcked`            | `integer` |                                        |
| `web100_log_entry.snap.HCThruOctetsReceived`         | `integer` |                                        |
| `web100_log_entry.snap.LimCwnd`                      | `integer` |                                        |
| `web100_log_entry.snap.LimRwin`                      | `integer` |                                        |
| `web100_log_entry.snap.LocalAddress`                 | `string`    |                                        |
| `web100_log_entry.snap.LocalAddressType`             | `integer` |                                        |
| `web100_log_entry.snap.LocalPort`                    | `integer` |                                        |
| `web100_log_entry.snap.MSSRcvd`                      | `integer` |                                        |
| `web100_log_entry.snap.MaxAppRQueue`                 | `integer` |                                        |
| `web100_log_entry.snap.MaxAppWQueue`                 | `integer` |                                        |
| `web100_log_entry.snap.MaxMSS`                       | `integer` |                                        |
| `web100_log_entry.snap.MaxRTO`                       | `integer` |                                        |
| `web100_log_entry.snap.MaxRTT`                       | `integer` |                                        |
| `web100_log_entry.snap.MaxReasmQueue`                | `integer` |                                        |
| `web100_log_entry.snap.MaxRetxQueue`                 | `integer` |                                        |
| `web100_log_entry.snap.MaxRwinRcvd`                  | `integer` |                                        |
| `web100_log_entry.snap.MaxRwinSent`                  | `integer` |                                        |
| `web100_log_entry.snap.MaxSsCwnd`                    | `integer` |                                        |
| `web100_log_entry.snap.MaxSsthresh`                  | `integer` |                                        |
| `web100_log_entry.snap.MinMSS`                       | `integer` |                                        |
| `web100_log_entry.snap.MinRTO`                       | `integer` |                                        |
| `web100_log_entry.snap.MinRTT`                       | `integer` |                                        |
| `web100_log_entry.snap.MinRwinRcvd`                  | `integer` |                                        |
| `web100_log_entry.snap.MinRwinSent`                  | `integer` |                                        |
| `web100_log_entry.snap.MinSsthresh`                  | `integer` |                                        |
| `web100_log_entry.snap.Nagle`                        | `integer` |                                        |
| `web100_log_entry.snap.NonRecovDA`                   | `integer` |                                        |
| `web100_log_entry.snap.OctetsRetrans`                | `integer` |                                        |
| `web100_log_entry.snap.OtherReductions`              | `integer` |                                        |
| `web100_log_entry.snap.PostCongCountRTT`             | `integer` |                                        |
| `web100_log_entry.snap.PostCongSumRTT`               | `integer` |                                        |
| `web100_log_entry.snap.PreCongSumCwnd`               | `integer` |                                        |
| `web100_log_entry.snap.PreCongSumRTT`                | `integer` |                                        |
| `web100_log_entry.snap.QuenchRcvd`                   | `integer` |                                        |
| `web100_log_entry.snap.RTTVar`                       | `integer` |                                        |
| `web100_log_entry.snap.RcvNxt`                       | `integer` |                                        |
| `web100_log_entry.snap.RcvRTT`                       | `integer` |                                        |
| `web100_log_entry.snap.RcvWindScale`                 | `integer` |                                        |
| `web100_log_entry.snap.RecInitial`                   | `integer` |                                        |
| `web100_log_entry.snap.RemAddress`                   | `string`    |                                        |
| `web100_log_entry.snap.RemPort`                      | `integer` |                                        |
| `web100_log_entry.snap.RetranThresh`                 | `integer` |                                        |
| `web100_log_entry.snap.SACK`                         | `integer` |                                        |
| `web100_log_entry.snap.SACKBlocksRcvd`               | `integer` |                                        |
| `web100_log_entry.snap.SACKsRcvd`                    | `integer` |                                        |
| `web100_log_entry.snap.SampleRTT`                    | `integer` |                                        |
| `web100_log_entry.snap.SegsIn`                       | `integer` |                                        |
| `web100_log_entry.snap.SegsOut`                      | `integer` |                                        |
| `web100_log_entry.snap.SegsRetrans`                  | `integer` |                                        |
| `web100_log_entry.snap.SendStall`                    | `integer` |                                        |
| `web100_log_entry.snap.SlowStart`                    | `integer` |                                        |
| `web100_log_entry.snap.SmoothedRTT`                  | `integer` |                                        |
| `web100_log_entry.snap.SndInitial`                   | `integer` |                                        |
| `web100_log_entry.snap.SndLimBytesCwnd`              | `integer` |                                        |
| `web100_log_entry.snap.SndLimBytesRwin`              | `integer` |                                        |
| `web100_log_entry.snap.SndLimBytesSender`            | `integer` |                                        |
| `web100_log_entry.snap.SndLimTimeCwnd`               | `integer` |                                        |
| `web100_log_entry.snap.SndLimTimeRwin`               | `integer` |                                        |
| `web100_log_entry.snap.SndLimTimeSnd`                | `integer` |                                        |
| `web100_log_entry.snap.SndLimTransCwnd`              | `integer` |                                        |
| `web100_log_entry.snap.SndLimTransRwin`              | `integer` |                                        |
| `web100_log_entry.snap.SndLimTransSnd`               | `integer` |                                        |
| `web100_log_entry.snap.SndMax`                       | `integer` |                                        |
| `web100_log_entry.snap.SndNxt`                       | `integer` |                                        |
| `web100_log_entry.snap.SndUna`                       | `integer` |                                        |
| `web100_log_entry.snap.SndWindScale`                 | `integer` |                                        |
| `web100_log_entry.snap.SpuriousFrDetected`           | `integer` |                                        |
| `web100_log_entry.snap.StartTimeStamp`               | `integer` |                                        |
| `web100_log_entry.snap.StartTimeUsec`                | `integer` |                                        |
| `web100_log_entry.snap.State`                        | `integer` |                                        |
| `web100_log_entry.snap.SubsequentTimeouts`           | `integer` |                                        |
| `web100_log_entry.snap.SumRTT`                       | `integer` |                                        |
| `web100_log_entry.snap.TimeStamps`                   | `integer` |                                        |
| `web100_log_entry.snap.Timeouts`                     | `integer` |                                        |
| `web100_log_entry.snap.WinScaleRcvd`                 | `integer` |                                        |
| `web100_log_entry.snap.WinScaleSent`                 | `integer` |                                        |
| `web100_log_entry.snap.X_OtherReductionsCM`          | `integer` |                                        |
| `web100_log_entry.snap.X_OtherReductionsCV`          | `integer` |                                        |
| `web100_log_entry.snap.X_Rcvbuf`                     | `integer` |                                        |
| `web100_log_entry.snap.X_Sndbuf`                     | `integer` |                                        |
| `web100_log_entry.snap.X_dbg1`                       | `integer` |                                        |
| `web100_log_entry.snap.X_dbg2`                       | `integer` |                                        |
| `web100_log_entry.snap.X_dbg3`                       | `integer` |                                        |
| `web100_log_entry.snap.X_dbg4`                       | `integer` |                                        |
| `web100_log_entry.snap.X_rcv_ssthresh`               | `integer` |                                        |
| `web100_log_entry.snap.X_wnd_clamp`                  | `integer` |                                        |

</div>

### Sidestream `measurement-lab.base_tables.sidestream`

<div class="table-responsive" markdown="1">

| Field name                                           |     Type     |  Description                              |
| :----------------------------------------------------|:------------:|:------------------------------------------|
| `_PARTITIONTIME`                                    | `timestamp`  |  This pseudo column contains a timestamp for the start of the day (in UTC) in which the data was loaded. For the YYYYMMDD partition, this pseudo column will contain the value TIMESTAMP('YYYY-MM-DD'). |
| `test_id`                                           |  `string`    |  ID of the test. It represents the filename of the log that contains the data generated during the test (e.g. `20090819T02:01:04.507508000Z_189.6.232.77:3859.c2s_snaplog.gz`). |
| `project`                              | `integer` |                                        |
| `log_time`                             | `timestamp` |                                        |
| `type`                                | `integer` |                                        |
| `web100_log_entry.log_time`           | `integer` |                                        |
| `web100_log_entry.version`            | `string` |                                        |
| `web100_log_entry.group_name`         | `string` |                                        |
| `web100_log_entry.connection_spec.local_af` | `integer` |                                        |
| `web100_log_entry.connection_spec.local_ip` | `string` |                                        |
| `web100_log_entry.connection_spec.local_port` | `integer` |                                        |
| `web100_log_entry.connection_spec.remote_ip`  | `string` |                                        |
| `web100_log_entry.connection_spec.remote_port` | `integer` |                                        |
| `web100_log_entry.connection_spec.local_geolocation.area_code`  | `integer` |                                        |
| `web100_log_entry.connection_spec.local_geolocation.city`  | `string` |                                        |
| `web100_log_entry.connection_spec.local_geolocation.continent_code` | `string` |                                        |
| `web100_log_entry.connection_spec.local_geolocation.country_code` | `string` |                                        |
| `web100_log_entry.connection_spec.local_geolocation.country_code3` | `string` |                                        |
| `web100_log_entry.connection_spec.local_geolocation.country_name` | `string` |                                        |
| `web100_log_entry.connection_spec.local_geolocation.latitude` | `float` |                                        |
| `web100_log_entry.connection_spec.local_geolocation.longitude` | `float` |                                        |
| `web100_log_entry.connection_spec.local_geolocation.metro_code` | `integer` |                                        |
| `web100_log_entry.connection_spec.local_geolocation.postal_code` | `string` |                                        |
| `web100_log_entry.connection_spec.local_geolocation.region` | `string` |                                        |
| `web100_log_entry.connection_spec.remote_geolocation.area_code` | `integer` |                                        |
| `web100_log_entry.connection_spec.remote_geolocation.city` | `string` |                                        |
| `web100_log_entry.connection_spec.remote_geolocation.continent_code` | `string` |                                        |
| `web100_log_entry.connection_spec.remote_geolocation.country_code` | `string` |                                        |
| `web100_log_entry.connection_spec.remote_geolocation.country_code3` | `string` |                                        |
| `web100_log_entry.connection_spec.remote_geolocation.country_name` | `string` |                                        |
| `web100_log_entry.connection_spec.remote_geolocation.latitude` | `float` |                                        |
| `web100_log_entry.connection_spec.remote_geolocation.longitude` | `float` |                                        |
| `web100_log_entry.connection_spec.remote_geolocation.metro_code` | `integer` |                                        |
| `web100_log_entry.connection_spec.remote_geolocation.postal_code` | `string` |                                        |
| `web100_log_entry.connection_spec.remote_geolocation.region` | `string` |                                        |
| `web100_log_entry.snap.AbruptTimeouts` | `integer` |                                        |
| `web100_log_entry.snap.ActiveOpen` | `integer` |                                        |
| `web100_log_entry.snap.CERcvd` | `integer` |                                        |
| `web100_log_entry.snap.CongAvoid` | `integer` |                                        |
| `web100_log_entry.snap.CongOverCount` | `integer` |                                        |
| `web100_log_entry.snap.CongSignals`  | `integer` |                                        |
| `web100_log_entry.snap.CountRTT` | `integer` |                                        |
| `web100_log_entry.snap.CurAppRQueue1` | `integer` |                                        |
| `web100_log_entry.snap.CurAppWQueue`  | `integer` |                                        |
| `web100_log_entry.snap.CurCwnd` | `integer` |                                        |
| `web100_log_entry.snap.CurMSS`  | `integer` |                                        |
| `web100_log_entry.snap.CurRTO`  | `integer` |                                        |
| `web100_log_entry.snap.CurReasmQueue` | `integer` |                                        |
| `web100_log_entry.snap.CurRetxQueue`  | `integer` |                                        |
| `web100_log_entry.snap.CurRwinRcvd` | `integer` |                                        |
| `web100_log_entry.snap.CurRwinSent` | `integer` |                                        |
| `web100_log_entry.snap.CurSsthresh` | `integer` |                                        |
| `web100_log_entry.snap.CurTimeoutCount` | `integer` |                                        |
| `web100_log_entry.snap.DSACKDups`     | `integer` |                                        |
| `web100_log_entry.snap.DataOctetsIn`  | `integer` |                                        |
| `web100_log_entry.snap.DataOctetsOut` | `integer` |                                        |
| `web100_log_entry.snap.DataSegsIn`    | `integer` |                                        |
| `web100_log_entry.snap.DataSegsOut` | `integer` |                                        |
| `web100_log_entry.snap.DupAckEpisodes` | `integer` |                                        |
| `web100_log_entry.snap.DupAcksIn`     | `integer` |                                        |
| `web100_log_entry.snap.DupAcksOut`    | `integer` |                                        |
| `web100_log_entry.snap.Duration` | `integer` |                                        |
| `web100_log_entry.snap.ECESent`  | `integer` |                                        |
| `web100_log_entry.snap.ECN`  | `integer` |                                        |
| `web100_log_entry.snap.ECNNonceRcvd`  | `integer` |                                        |
| `web100_log_entry.snap.ECNsignals`    | `integer` |                                        |
| `web100_log_entry.snap.ElapsedMicroSecs` | `integer` |                                        |
| `web100_log_entry.snap.ElapsedSecs` | `integer` |                                        |
| `web100_log_entry.snap.FastRetran`    | `integer` |                                        |
| `web100_log_entry.snap.HCDataOctetsIn` | `integer` |                                        |
| `web100_log_entry.snap.HCDataOctetsOut` | `integer` |                                        |
| `web100_log_entry.snap.HCSumRTT`      | `integer` |                                        |
| `web100_log_entry.snap.HCThruOctetsAcked` | `integer` |                                        |
| `web100_log_entry.snap.HCThruOctetsReceived` | `integer` |                                        |
| `web100_log_entry.snap.InRecovery`    | `integer` |                                        |
| `web100_log_entry.snap.IpTosIn`       | `integer` |                                        |
| `web100_log_entry.snap.IpTosOut`      | `integer` |                                        |
| `web100_log_entry.snap.IpTtl`         | `integer` |                                        |
| `web100_log_entry.snap.LimCwnd`       | `integer` |                                        |
| `web100_log_entry.snap.LimMSS`        | `integer` |                                        |
| `web100_log_entry.snap.LimRwin`       | `integer` |                                        |
| `web100_log_entry.snap.LimSsthresh` | `integer` |                                        |
| `web100_log_entry.snap.LocalAddress`  | `string` |                                        |
| `web100_log_entry.snap.LocalAddressType` | `integer` |                                        |
| `web100_log_entry.snap.LocalPort`     | `integer` |                                        |
| `web100_log_entry.snap.MSSRcvd`       | `integer` |                                        |
| `web100_log_entry.snap.MSSSent`       | `integer` |                                        |
| `web100_log_entry.snap.MaxAppRQueue`  | `integer` |                                        |
| `web100_log_entry.snap.MaxAppWQueue`  | `integer` |                                        |
| `web100_log_entry.snap.MaxCaCwnd`     | `integer` |                                        |
| `web100_log_entry.snap.MaxMSS`        | `integer` |                                        |
| `web100_log_entry.snap.MaxPipeSize` | `integer` |                                        |
| `web100_log_entry.snap.MaxRTO`        | `integer` |                                        |
| `web100_log_entry.snap.MaxRTT`        | `integer` |                                        |
| `web100_log_entry.snap.MaxReasmQueue` | `integer` |                                        |
| `web100_log_entry.snap.MaxRetxQueue`  | `integer` |                                        |
| `web100_log_entry.snap.MaxRwinRcvd` | `integer` |                                        |
| `web100_log_entry.snap.MaxRwinSent` | `integer` |                                        |
| `web100_log_entry.snap.MaxSsCwnd`     | `integer` |                                        |
| `web100_log_entry.snap.MaxSsthresh` | `integer` |                                        |
| `web100_log_entry.snap.MinMSS`        | `integer` |                                        |
| `web100_log_entry.snap.MinRTO`        | `integer` |                                        |
| `web100_log_entry.snap.MinRTT`        | `integer` |                                        |
| `web100_log_entry.snap.MinRwinRcvd` | `integer` |                                        |
| `web100_log_entry.snap.MinRwinSent` | `integer` |                                        |
| `web100_log_entry.snap.MinSsthresh` | `integer` |                                        |
| `web100_log_entry.snap.Nagle`         | `integer` |                                        |
| `web100_log_entry.snap.NonRecovDA`    | `integer` |                                        |
| `web100_log_entry.snap.NonRecovDAEpisodes` | `integer` |                                        |
| `web100_log_entry.snap.OctetsRetrans` | `integer` |                                        |
| `web100_log_entry.snap.OtherReductions` | `integer` |                                        |
| `web100_log_entry.snap.PipeSize`      | `integer` |                                        |
| `web100_log_entry.snap.PostCongCountRTT`  | `integer` |                                        |
| `web100_log_entry.snap.PostCongSumRTT` | `integer` |                                        |
| `web100_log_entry.snap.PreCongSumCwnd` | `integer` |                                        |
| `web100_log_entry.snap.PreCongSumRTT` | `integer` |                                        |
| `web100_log_entry.snap.QuenchRcvd` | `integer` |                                        |
| `web100_log_entry.snap.RTTVar` | `integer` |                                        |
| `web100_log_entry.snap.RcvNxt` | `integer` |                                        |
| `web100_log_entry.snap.RcvRTT` | `integer` |                                        |
| `web100_log_entry.snap.RcvWindScale` | `integer` |                                        |
| `web100_log_entry.snap.RecInitial` | `integer` |                                        |
| `web100_log_entry.snap.RemAddress` | `integer` |                                        |
| `web100_log_entry.snap.RemPort` | `integer` |                                        |
| `web100_log_entry.snap.RetranThresh` | `integer` |                                        |
| `web100_log_entry.snap.SACK` | `integer` |                                        |
| `web100_log_entry.snap.SACKBlocksRcvd` | `integer` |                                        |
| `web100_log_entry.snap.SACKsRcvd` | `integer` |                                        |
| `web100_log_entry.snap.SampleRTT` | `integer` |                                        |
| `web100_log_entry.snap.SegsIn` | `integer` |                                        |
| `web100_log_entry.snap.SegsOut` | `integer` |                                        |
| `web100_log_entry.snap.SegsRetrans` | `integer` |                                        |
| `web100_log_entry.snap.SendStall` | `integer` |                                        |
| `web100_log_entry.snap.SlowStart` | `integer` |                                        |
| `web100_log_entry.snap.SmoothedRTT` | `integer` |                                        |
| `web100_log_entry.snap.SndInitial` | `integer` |                                        |
| `web100_log_entry.snap.SndLimBytesCwnd` | `integer` |                                        |
| `web100_log_entry.snap.SndLimBytesRwin` | `integer` |                                        |
| `web100_log_entry.snap.SndLimBytesSender` | `integer` |                                        |
| `web100_log_entry.snap.SndLimTimeCwnd` | `integer` |                                        |
| `web100_log_entry.snap.SndLimTimeRwin` | `integer` |                                        |
| `web100_log_entry.snap.SndLimTimeSnd` | `integer` |                                        |
| `web100_log_entry.snap.SndLimTransCwnd` | `integer` |                                        |
| `web100_log_entry.snap.SndLimTransRwin` | `integer` |                                        |
| `web100_log_entry.snap.SndLimTransSnd` | `integer` |                                        |
| `web100_log_entry.snap.SndMax` | `integer` |                                        |
| `web100_log_entry.snap.SndNxt` | `integer` |                                        |
| `web100_log_entry.snap.SndUna` | `integer` |                                        |
| `web100_log_entry.snap.SndWindScale` | `integer` |                                        |
| `web100_log_entry.snap.SoftErrorReason` | `integer` |                                        |
| `web100_log_entry.snap.SoftErrors` | `integer` |                                        |
| `web100_log_entry.snap.SpuriousFrDetected` | `integer` |                                        |
| `web100_log_entry.snap.SpuriousRtoDetected` | `integer` |                                        |
| `web100_log_entry.snap.StartTimeStamp` | `integer` |                                        |
| `web100_log_entry.snap.State` | `integer` |                                        |
| `web100_log_entry.snap.SubsequentTimeouts` | `integer` |                                        |
| `web100_log_entry.snap.SumOctetsReordered` | `integer` |                                        |
| `web100_log_entry.snap.SumRTT` | `integer` |                                        |
| `web100_log_entry.snap.ThruOctetsAcked` | `integer` |                                        |
| `web100_log_entry.snap.ThruOctetsReceived` | `integer` |                                        |
| `web100_log_entry.snap.TimeStampRcvd` | `integer` |                                        |
| `web100_log_entry.snap.TimeStampSent` | `integer` |                                        |
| `web100_log_entry.snap.TimeStamps` | `integer` |                                        |
| `web100_log_entry.snap.Timeouts` | `integer` |                                        |
| `web100_log_entry.snap.WAD_CwndAdjust` | `integer` |                                        |
| `web100_log_entry.snap.WAD_IFQ` | `integer` |                                        |
| `web100_log_entry.snap.WAD_MaxBurst` | `integer` |                                        |
| `web100_log_entry.snap.WAD_MaxSsthresh` | `integer` |                                        |
| `web100_log_entry.snap.WAD_NoAI` | `integer` |                                        |
| `web100_log_entry.snap.WillSendSACK` | `integer` |                                        |
| `web100_log_entry.snap.WillUseSACK` | `integer` |                                        |
| `web100_log_entry.snap.WinScaleRcvd` | `integer` |                                        |
| `web100_log_entry.snap.WinScaleSent` | `integer` |                                        |
| `web100_log_entry.snap.X_OtherReductionsCM` | `integer` |                                        |
| `web100_log_entry.snap.X_OtherReductionsCV` | `integer` |                                        |
| `web100_log_entry.snap.X_Rcvbuf` | `integer` |                                        |
| `web100_log_entry.snap.X_Sndbuf` | `integer` |                                        |
| `web100_log_entry.snap.X_dbg1` | `integer` |                                        |
| `web100_log_entry.snap.X_dbg2` | `integer` |                                        |
| `web100_log_entry.snap.X_dbg3` | `integer` |                                        |
| `web100_log_entry.snap.X_dbg4` | `integer` |                                        |
| `web100_log_entry.snap.X_rcv_ssthresh` | `integer` |                                        |
| `web100_log_entry.snap.X_wnd_clamp` | `integer` |                                        |
| `web100_log_entry.snap.ZeroRwinRcvd` | `integer` |                                        |
| `web100_log_entry.snap.ZeroRwinSent` | `integer` |                                        |

</div>

### Paris Traceroute `measurement-lab.base_tables.traceroute`

<div class="table-responsive" markdown="1">

| Field name                                           |     Type     |  Description                              |
| :----------------------------------------------------|:------------:|:------------------------------------------|
| `_PARTITIONTIME`                                    | `timestamp`  |  This pseudo column contains a timestamp for the start of the day (in UTC) in which the data was loaded. For the YYYYMMDD partition, this pseudo column will contain the value TIMESTAMP('YYYY-MM-DD'). |
| `test_id`                                           |  `string`    |  ID of the test. It represents the filename of the log that contains the data generated during the test (e.g. `20090819T02:01:04.507508000Z_189.6.232.77:3859.c2s_snaplog.gz`). |
| `project`                              | `integer` | |
| `log_time`  | `integer` |                                        |
| `connection_spec.client_af` | `integer` |                                        |
| `connection_spec.client_application` | `string` |                                        |
| `connection_spec.client_browser` | `string` |                                        |
| `connection_spec.client_hostname`  | `string` |                                        |
| `connection_spec.client_ip` | `string` |                                        |
| `connection_spec.client_kernel_version` | `string` |                                        |
| `connection_spec.client_os` | `string` |                                        |
| `connection_spec.client_version` | `string` |                                        |
| `connection_spec.data_direction` | `integer` |                                        |
| `connection_spec.server_af` | `integer` |                                        |
| `connection_spec.server_hostname` | `string` |                                        |
| `connection_spec.server_ip` | `string` |                                        |
| `connection_spec.server_kernel_version` | `string` |                                        |
| `connection_spec.client_geolocation.area_code` | `integer` |                                        |
| `connection_spec.client_geolocation.city` | `string` |                                        |
| `connection_spec.client_geolocation.continent_code` | `string` |                                        |
| `connection_spec.client_geolocation.country_code` | `string` |                                        |
| `connection_spec.client_geolocation.country_code3` | `string` |                                        |
| `connection_spec.client_geolocation.country_name` | `string` |                                        |
| `connection_spec.client_geolocation.latitude` | `float` |                                        |
| `connection_spec.client_geolocation.longitude` | `float` |                                        |
| `connection_spec.client_geolocation.metro_code` | `integer` |                                        |
| `connection_spec.client_geolocation.postal_code` | `string` |                                        |
| `connection_spec.client_geolocation.region` | `string` |                                        |
| `connection_spec.server_geolocation.area_code` | `integer` |                                        |
| `connection_spec.server_geolocation.city` | `string` |                                        |
| `connection_spec.server_geolocation.continent_code` | `string` |                                        |
| `connection_spec.server_geolocation.country_code` | `string` |                                        |
| `connection_spec.server_geolocation.country_code3` | `string` |                                        |
| `connection_spec.server_geolocation.country_name` | `string` |                                        |
| `connection_spec.server_geolocation.latitude` | `float` |                                        |
| `connection_spec.server_geolocation.longitude` | `float` |                                        |
| `connection_spec.server_geolocation.metro_code` | `integer` |                                        |
| `connection_spec.server_geolocation.postal_code` | `string` |                                        |
| `connection_spec.server_geolocation.region` | `string` |                                        |
| `paris_traceroute_hop.protocol` | `string` |                                        |
| `paris_traceroute_hop.src_ip` | `string` |                                        |
| `paris_traceroute_hop.src_af` | `integer` |                                        |
| `paris_traceroute_hop.src_hostname` | `string` |                                        |
| `paris_traceroute_hop.src_geolocation.area_code` | `integer` |                                        |
| `paris_traceroute_hop.src_geolocation.city` | `string` |                                        |
| `paris_traceroute_hop.src_geolocation.continent_code` | `string` |                                        |
| `paris_traceroute_hop.src_geolocation.country_code` | `string` |                                        |
| `paris_traceroute_hop.src_geolocation.country_code3` | `string` |                                        |
| `paris_traceroute_hop.src_geolocation.country_name` | `string` |                                        |
| `paris_traceroute_hop.src_geolocation.latitude` | `float` |                                        |
| `paris_traceroute_hop.src_geolocation.longitude` | `float` |                                        |
| `paris_traceroute_hop.src_geolocation.metro_code` | `integer` |                                        |
| `paris_traceroute_hop.src_geolocation.postal_code` | `string` |                                        |
| `paris_traceroute_hop.src_geolocation.region` | `string` |                                        |
| `paris_traceroute_hop.dest_ip` | `string` |                                        |
| `paris_traceroute_hop.dest_af` | `integer` |                                        |
| `paris_traceroute_hop.dest_hostname` | `string` |                                        |
| `paris_traceroute_hop.dest_geolocation.area_code` | `integer` |                                        |
| `paris_traceroute_hop.dest_geolocation.continent_code` | `string` |                                        |
| `paris_traceroute_hop.dest_geolocation.country_code` | `string` |                                        |
| `paris_traceroute_hop.dest_geolocation.country_code3` | `string` |                                        |
| `paris_traceroute_hop.dest_geolocation.country_name` | `string` |                                        |
| `paris_traceroute_hop.dest_geolocation.latitude` | `float` |                                        |
| `paris_traceroute_hop.dest_geolocation.longitude` | `float` |                                        |
| `paris_traceroute_hop.dest_geolocation.metro_code` | `integer` |                                        |
| `paris_traceroute_hop.dest_geolocation.postal_code` | `string` |                                        |
| `paris_traceroute_hop.dest_geolocation.region` | `string` |                                        |
| `paris_traceroute_hop.dest_geolocation.rtt` | `float (repeated)` |                                        |

</div>

## M-Lab BigQuery Schema/Table Version History and Changelog

**v1 - January 2009**

* Initial publication of m_lab monthly tables containing data for NDT, NPAD, Paris Traceroute, and Sidestream
  * `plx.google:m_lab.YYYY_MM.all`

**v2 - March 2016**

* Began the publication of per project "fast tables" for NDT, NPAD, Paris Traceroute, and Sidestream.
  * `plx.google:m_lab.ndt.all`
  * `plx.google:m_lab.npad.all`
  * `plx.google:m_lab.paris-traceroute.all`
* Continued the publication of v1 monthly tables, and published a [migration guide]({{ site.baseurl }}/data/docs/bq/legacymigration/).
* Deprecated fields in v2 "fast tables":
  * `type`
  * `project`
  * `web100_log_entry.is_last_entry`
  * `web100_log_entry.group_name`

**v2.1 - November 2016**

* The field `blacklist_flags` was added to v2 per project "fast tables", and all historical data was re-parsed to add this annotation, due to a [switch discard issue related to traffic microbursts]({{ site.baseurl }}/blog/traffic-microbursts-and-their-effect-on-internet-measurement/).

**v3 - May 2017**

* Began publication to new date partitioned table and updated schema to support the new, open source, ETL pipeline.
* Data publication to v2 tables stopped at this time.

**v3.0.1 - October / November 2017**

* The schema for v3.0.1 tables was updated, removing an alpha feature called deltas, which attempted to log the differences between test snaplogs instead of the final test values. This feature will be revisited in future schema updates.
* Newly released data annotation engine added geolocation and some metadata to tests from 2016 to present.
* Published a series of beta BigQuery views for NDT data,  to allow data queries across both v2 and v3.0.x tables.
* Published traceroute and sidestream table to replace v2 versions, migrated data, re-annotated data.

**v3.0.2 - December 2017**

* Standardized the naming scheme for BigQuery table and view names to be consistent with new semantic versioning.
* All tables and views must be queried using StandardSQL, except for views with “legacysql” in the name.
* Views for tests other than NDT may be published in the future using the same format:
  * `<test>_all_<version>` (standardSQL)
  * `<test>_all_legacysql_<version>`
* Complete documentation for tables, views, the contents of views, and what data they limit (where applicable) will be published on this page.
* Views will be published concurrently with new table schemas, such that all table versions will have corresponding views.
* Previous versions of our tables will be referenced by versions 1.0, 2.0, etc. in our documentation but actual table names will not be changed.
* Re-ran historical annotations for traceroute, npad, and sidestream data due to a bug where some geolocation annotations was not present in all past test data.

**v3.1 - January 2018**

* First official release of v3 tables, with all historical data re-parsed, and annotated with geolocation and blacklist flags metadata.

Published **tables** and views are:

* **measurement-lab.legacy.ndt** (data ~ 2015-01-01 - 2017-05-10)
* **measurement-lab.legacy.ndt_pre2015** (data ~ 2009-02-18 - 2014-12-31)
* **measurement-lab.base_tables.ndt**
* **measurement-lab.base_tables.sidestream**
* **measurement-lab.base_tables.traceroute**

* **measurement-lab.rc**
* **measurement-lab.release_v3_1**
* **measurement-lab.release**
  * _measurement-lab.release.ndt_all_
  * _measurement-lab.release.ndt_all_legacysql_
  * _measurement-lab.release.ndt_downloads_
  * _measurement-lab.release.ndt_downloads_legacysql_
  * _measurement-lab.release.ndt_uploads_
  * _measurement-lab.release.ndt_uploads_legacysql_
