---
layout: page
title: "Migrating Queries to Use Current M-Lab Tables and Views"
permalink: /data/docs/bq/legacymigration/
breadcrumb: data
---

# Migrating to Current M-Lab Tables and Views

In March 2016, M-Lab launched new M-Lab BigQuery Fast tables which offered faster performance and a simpler data schema than the previous per-month legacy tables. In late 2017 to early 2018, M-Lab transitioned to new BigQuery tables as a part of updating to an open-source pipeline.

This guide walks users through the process of converting BigQuery SQL queries from **Legacy Monthly** or **Fast Tables** to take advantage of the new features of our most current tables and views. For reference, our past tables were stored in a special project `plx.google` and had the structure below:

* Fast Tables - Example: plx.google:m_lab.<TEST NAME>.all
* Legacy Monthly Tables - Example: plx.google:m_lab.2016_01.all

## Release Datasets and Views

M-Lab now publishes a series of three datasets for each version release:

* **rc**
  * Beta test version of the next release of views.
  * These views represent the most recent _release-candidate_.

* **release_vX_X**
  * Recent stable releases.

* **release**
  * An alias to current supported release.
  * This is the set of views that most people should use.

M-Lab recommends using the **release** dataset for querying NDT data. This will make future table schema transitions less impactful since queries can be pinned to the release views instead of to a specific table name.

Beginning with the upcoming v3.1 release, in the **rc**, **release_vX_X**, and **release** datasets we will publish the following views:

* _ndt_all_
* _ndt_all_legacysql_
* _ndt_downloads_
* _ndt_downloads_legacysql_
* _ndt_uploads_
* _ndt_uploads_legacysql_

The views above ending in `_legacysql` require you to use [legacySQL](https://cloud.google.com/bigquery/docs/reference/legacy-sql) queries, and those labeled without it `(standardSQL)` require you the use of [standardSQL](https://cloud.google.com/bigquery/docs/reference/standard-sql/) queries. Additionally, the views which include '_uploads_' or '_downloads_' provide a subset of NDT data that are valid, completed tests which meet the criteria described on our page, [Calculating Common Metrics](https://www.measurementlab.net/data/docs/bq/ndtmetrics/). M-Lab highly recommends using standardSQL as this will be required to query all M-Lab tables in the future.

## Sidestream and Paris Traceroute

If your queries are for Sidestream and Paris Traceroute data, please use the following tables:

* `measurement-lab:base_tables.sidestream`
* `measurement-lab:base_tables.traceroute`

## Converting Queries from Legacy Montly or Fast Tables to M-Lab's **release** Views

The converted examples below are written in standardSQL, indicated by `#standardSQL` at the top of the code block for full example queries. If you are querying using the [BigQuery website](https://bigquery.cloud.google.com/dataset/measurement-lab:release) M-Lab recommends adding `#standardSQL` at the top of your queries to set SQL Dialect option.

If your query uses the Legacy Monthly tables, the **FROM** portion of the query will look something like this:

~~~sql
FROM
  plx.google:m_lab.2016_01.all
~~~

If your query uses Fast Tables, the **FROM** portion of the query will look something like this:

~~~sql
FROM
  plx.google:m_lab.ndt.all
~~~

### Update the table name

Replace the table name with the M-Lab **release** of interest. For a query over NDT data, this becomes:

~~~sql
FROM
  `measurement-lab.release.ndt_all`
~~~

Note that there are multiple **release** views for your use, and provide the filtered results as described below:

* `measurement-lab.release.ndt_all`
  * all NDT data where `blacklist_flags` = 0 or NULL
  * StandardSQL syntax required.
* `measurement-lab.release.ndt_all_legacysql`
  * all NDT data where `blacklist_flags` = 0 or NULL
  * LegacySQL syntax required.
* `measurement-lab.release.ndt_downloads`
  * all NDT download tests where `blacklist_flags` = 0 or NULL
  * limited to tests [matching optimal measurement conditions]({{ site.baseurl }}/data/docs/bq/ndtmetrics/#download-throughput)
  * StandardSQL syntax required.
* `measurement-lab.release.ndt_downloads_legacysql`
  * all NDT download tests where `blacklist_flags` = 0 or NULL
  * limited to tests [matching optimal measurement conditions]({{ site.baseurl }}/data/docs/bq/ndtmetrics/#download-throughput)
  * LegacySQL syntax required.
* `measurement-lab.release.ndt_uploads`
  * all NDT download tests where `blacklist_flags` = 0 or NULL
  * limited to tests [matching optimal measurement conditions]({{ site.baseurl }}/data/docs/bq/ndtmetrics/#upload-throughput)
  * StandardSQL syntax required.
* `measurement-lab.release.ndt_uploads_legacysql`
  * all NDT download tests where `blacklist_flags` = 0 or NULL
  * limited to tests [matching optimal measurement conditions]({{ site.baseurl }}/data/docs/bq/ndtmetrics/#upload-throughput)
  * LegacySQL syntax required.

### Update `WHERE` statements to select data by date/time ranges

Legacy Monthly tables were published monthly, and making time series selection was done by querying multiple tables. Since v3.1, M-Lab's BigQuery tables are [date-partitioned](https://cloud.google.com/bigquery/docs/querying-partitioned-tables) making time series selection much easier.

Add a selector using the field `partition_date` to the `WHERE` portion of your query to limit selected data to a range of dates:

~~~sql
WHERE
  partition_date > '2018-01-01' AND partition_date < '2018-01-24'
~~~

### Limiting results to final test values

Many M-Lab tests gather TCP snapshots incrementally while running. While all interim snapshot values are available in our [raw data](https://console.cloud.google.com/storage/browser/m-lab?pli=1), we currently only parse the final test values into our BigQuery tables. This meets the needs of most researchers. In future releases, we are exploring how to best add a repeating record to provide interim snapshot values.

If your previous queries included statements such as the one below, they can be removed from your query to **release** views:

~~~sql
WHERE
  web100_log_entry.is_last_entry = TRUE
~~~

### Limit results using the blacklist_flags field

The `blacklist_flags` field was introduced to mark test results that could be impacted by site configuration issues, or otherwise communicate potentially relevant information about the state of the platform at the time of the test. This field was created to mark tests affected by the "switch discard issue" identified in 2015-2016, but M-Lab may use the field for other use cases in the future.

By default, M-Lab's **release** views limit results to tests where `blacklist_flags` is set to `0` or `NULL`. If you wish to query data where the blacklist_flag is another value, you will need to query the NDT base table directly, `measurement-lab:base_tables.ndt` and limit your results according to your needs.

### Remove deprecated fields from `WHERE` statements

M-Lab's legacy monthly tables combined data for several different M-Lab projects (NDT, NPAD, SideStream, and Paris Traceroute) into the same table. As such, queries for a particular project's data required the query author to add a `WHERE project=XX` clause to restrict the query to a particular project. The field `project` was deprecated in the transition to Fast tables in 2016, and our current tables deprecate additional fields as well.

Remove any reference to these deprecated fields in your queries:

* `project`
* `web100_log_entry.is_last_entry`
* `type`
* `web100_log_entry.group_name`

### Remove limits for optimal download/upload test conditions in `WHERE` statements

As mentioned above, you no longer need to check for optimal values for upload and download tests, as we describe on our page [Calculating Common Metrics]({{ site.baseurl }}/data/docs/bq/ndtmetrics/), if you are querying any of the following views:

* `measurement-lab.release.ndt_downloads`
* `measurement-lab.release.ndt_downloads_legacysql`
* `measurement-lab.release.ndt_uploads`
* `measurement-lab.release.ndt_uploads_legacysql`

If your query for _download tests_ contains the following `WHERE` conditions, these lines can be removed if you query the download views above:

~~~sql
  AND IS_EXPLICITLY_DEFINED(web100_log_entry.connection_spec.remote_ip)
  AND IS_EXPLICITLY_DEFINED (web100_log_entry.connection_spec.local_ip)
  AND IS_EXPLICITLY_DEFINED(web100_log_entry.snap.HCThruOctetsAcked)
  AND IS_EXPLICITLY_DEFINED(web100_log_entry.snap.SndLimTimeRwin)
  AND IS_EXPLICITLY_DEFINED(web100_log_entry.snap.SndLimTimeCwnd)
  AND IS_EXPLICITLY_DEFINED(web100_log_entry.snap.SndLimTimeSnd)
  AND project = 0
  AND IS_EXPLICITLY_DEFINED(connection_spec.data_direction)
  AND connection_spec.data_direction = 1
  AND IS_EXPLICITLY_DEFINED(web100_log_entry.is_last_entry)
  AND web100_log_entry.is_last_entry = True
  AND web100_log_entry.snap.HCThruOctetsAcked >= 8192
  AND (web100_log_entry.snap.SndLimTimeRwin +
    web100_log_entry.snap.SndLimTimeCwnd +
    web100_log_entry.snap.SndLimTimeSnd) >= 9000000
  AND (web100_log_entry.snap.SndLimTimeRwin +
    web100_log_entry.snap.SndLimTimeCwnd +
    web100_log_entry.snap.SndLimTimeSnd) < 3600000000
  AND IS_EXPLICITLY_DEFINED(web100_log_entry.snap.CongSignals)
  AND web100_log_entry.snap.CongSignals > 0
  AND (web100_log_entry.snap.State == 1 OR
    (web100_log_entry.snap.State >= 5 AND
    web100_log_entry.snap.State <= 11))
  AND blacklist_flags == 0
~~~

Similarly, if your query for _upload tests_ contains the following `WHERE` conditions, these lines can be removed if you query the upload views above:

~~~sql
  AND IS_EXPLICITLY_DEFINED(web100_log_entry.connection_spec.remote_ip)
  AND IS_EXPLICITLY_DEFINED(web100_log_entry.connection_spec.local_ip)
  AND IS_EXPLICITLY_DEFINED(web100_log_entry.snap.HCThruOctetsReceived)
  AND IS_EXPLICITLY_DEFINED(web100_log_entry.snap.Duration)
  AND IS_EXPLICITLY_DEFINED(connection_spec.data_direction)
  AND connection_spec.data_direction = 0
  AND IS_EXPLICITLY_DEFINED(web100_log_entry.is_last_entry)
  AND web100_log_entry.is_last_entry = True
  AND web100_log_entry.snap.HCThruOctetsReceived >= 8192
  AND web100_log_entry.snap.Duration >= 9000000
  AND web100_log_entry.snap.Duration < 3600000000
  AND (web100_log_entry.snap.State == 1
      OR (web100_log_entry.snap.State >= 5
      AND web100_log_entry.snap.State <= 11))
  AND blacklist_flags == 0
~~~

## Complete Example

To tie it all together, we will look at a complete example where we convert an existing query to take advantage of the new M-Lab **release** views.

The query below calculates the total number of NDT tests performed against M-Lab servers for each day in the last quarter of 2015.

### Original query

~~~sql
SELECT
  STRFTIME_UTC_USEC(web100_log_entry.log_time * 1000000,
                    '%Y-%m-%d') AS day,
  COUNT(*) AS num_tests
FROM
  [plx.google:m_lab.2015_10.all],
  [plx.google:m_lab.2015_11.all],
  [plx.google:m_lab.2015_12.all]
WHERE
  project = 0
  AND web100_log_entry.is_last_entry = TRUE
  AND web100_log_entry.log_time IS NOT NULL
GROUP BY
  day
ORDER BY
  day ASC
~~~

### Converted to use **release** view

~~~sql
#standardSQL
SELECT
  COUNT(test_id) AS numtests,
  partition_date AS day
FROM
  `measurement-lab.release.ndt_all`
WHERE
  partition_date >= '2015-10-01'
  AND partition_date <= '2015-12-31'
GROUP BY
  day
ORDER BY
  day
~~~

## Questions / Feedback

If you have questions or feedback about using M-Lab's ETL v1.0 tables, please send an email to [support@measurementlab.net](mailto:support@measurementlab.net).
