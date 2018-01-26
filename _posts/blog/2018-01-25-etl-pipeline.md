---
layout: blog
title: "New ETL Pipeline, Transition to New BigQuery Tables"
author: "Chris Ritzo"
date: 2018-01-25
breadcrumb: blog
categories:
  - pipeline
  - bigquery
  - versioning
---

# New ETL Pipeline, Transition to New BigQuery Tables
{% include post-meta.html %}

Since early summer, the M-Lab team has been working on an updated, open source pipeline, which pulls raw data from our servers, saves it to Google Cloud Storage, and then parses it into our BigQuery tables. The team is particularly excited about this update because it means that the pipeline no longer relies on closed source libraries.
<!--more-->

The new open source ETL pipeline is one project in a [larger initiative to update all components of the M-Lab platform]({{ site.baseurl }}/blog/modernizing-mlab/). In this post, we’ll talk about our expected timeline for transitioning to our new BigQuery datasets and tables, and invite you to explore the new tables, schema, metadata, and table features. We’ll also discuss future planned updates to the tables and their schemas, as we continue work to modernize and update the M-Lab platform software stack.

## Transitioning to New BigQuery Tables - Current Status and Anticipated Timeline

If you’ve been querying our data lately, you may have noticed some changes. In early May 2017 as a part of our pipeline transition work, our team instituted several changes:

* New raw test data is being published to a new storage bucket, [archive-mlab-oti](https://console.cloud.google.com/storage/browser/archive-mlab-oti)
  * Our team will complete a quality assurance process internally before moving all data to our documented storage bucket, [m-lab](https://console.cloud.google.com/storage/browser/m-lab)
* Data publication to the BigQuery table `plx.google:m_lab.ndt.all` was paused on May 10, 2017
* New test data is now being parsed into a new table: `measurement-lab.base_tables.ndt`
* Data from our previous “fast tables” has been copied to a pair of cloud BigQuery tables:
  * [measurement-lab.legacy.ndt](https://bigquery.cloud.google.com/table/measurement-lab:legacy.ndt) - contains all data from January 1, 2015 to May 10, 2017
  * [measurement-lab.legacy.ndt_pre2015](https://bigquery.cloud.google.com/table/measurement-lab:legacy.ndt_pre2015) - contains all data prior to 2015

Data in `measurement-lab.legacy.ndt` and `measurement-lab.legacy.ndt_pre2015` are identical to the data in `plx.google.m_lab.ndt.all`, but they use a schema that includes the new fields in `measurement-lab.base_tables.ndt`. The table had to be split in two because we are using "date partitioned tables" to improve query efficiency and ease of updates. Currently date-partitioned tables are limited to 2500 partitions, but GCS plans to lift this limit in the near future. M-Lab has created a unified view to allow querying of all data across legacy tables and our new table, which is discussed below.

## Implementing Semantic Versioning and for Datasets, Tables, and BigQuery Views

While working on completing the transition to new tables, we've begun organizing our publicly available datasets and tables using a semantic versioning strategy for our past, current, and future table schemas. This versioning will also apply to newly created BigQuery Views, to ensure users will have clarity on what version of our tables is being queried over time as schemas are updated.

### BigQuery Storage and Processing Datasets

With this upcoming release, M-Lab will publish more datasets, tables, and views. One group of datasets will be used primarily for storage and processing, and another group will be recommended for most researchers to query.

Four _storage and processing datasets_ will be published beginning with the v3.1 release:

* **base_tables**
  * Contains the new raw NDT, Sidestream, and Paris Traceroute tables.
  * This dataset will eventually hold all M-Lab data, from 2009 to present.

* **batch**
  * Destination for batch processed data prior to dedupping.

* **intermediate_vX_X_X**
  * Provides working, intermediate BigQuery Views for each release version
  * These views adapt data from tables in the **base_tables** dataset to make **release** views available.
  * Intermediate dataset views are publicly visible for transparency, but we discourage most people from using them directly.

* **legacy**
  * Contains exact copies of the data stored in `plx.google` tables, for use in the intermediate and release views.
  * Will be used in our internal quality assurance process, where we will compare the output of the old pipeline to the output of the new one.
  * A future blog post will address the quality assurance process used in preparing the new pipeline and tables.
  * Original legacy tables are still in `plx.google`, but will be retired ~6 months after the launch of the v3.1 release.

Researchers interested in querying unfiltered NDT, Sidestream, or Paris Traceroute data should use the **base_tables**:

* **base_tables**
  * ndt - `measurement-lab.base_tables.ndt`
  * sidestream - `measurement-lab.base_tables.sidestream`
  * traceroute - `measurement-lab.base_tables.traceroute`

### Recommended Datasets for Most Researcher Queries

The datasets in the previous section outline where raw M-Lab test data will be parsed and stored. While they are also queryable in the above locations, M-Lab will recommend that most researchers instead begin querying views in our **release** dataset.

To help researchers during this transition, and for future schema/table changes, we will also begin publishing the following datasets for each new release:

* **rc**
  * Beta test version of the next release of views.
  * These views represent the most recent _release-candidate_.

* **rc_X_X**
  * Recent stable releases.

* **release**
  * An alias to current supported release.
  * This is the set of views that most people should use.
  * These views will be updated to include any refinements to the recommended filtering, and may include changes to the schema over time.
  * If using the **release** alias, researchers should be subscribed to the [M-Lab Discuss group](), where we will announce new releases.
  * M-Lab staff will post upcoming change info to the [M-Lab Discuss group](https://groups.google.com/a/measurementlab.net/forum/#!forum/discuss), and update the view descriptions to reflect the planned changes. Since ALL views eventually either change, or are deprecated and removed, all users, whether using "release" or “rc_vX_X”, should either look at the view description for information on how long the views will be supported, or follow discuss list.

M-Lab recommends using the **release** dataset for most people. This will make future table schema transitions less impactful since queries can be pinned to the release views instead of to a specific table name.

Beginning with the upcoming v3.1 release, in the **rc**, **rc_vX_X**, and **release** datasets we will publish the following views:

* _ndt_all_
* _ndt_all_legacysql_
* _ndt_downloads_
* _ndt_downloads_legacysql_
* _ndt_uploads_
* _ndt_uploads_legacysql_

The views above ending in `_legacysql` require you to use [legacySQL](https://cloud.google.com/bigquery/docs/reference/legacy-sql) queries, and those labeled without it `(standardSQL)` require you the use of [standardSQL](https://cloud.google.com/bigquery/docs/reference/standard-sql/) queries. Additionally, the views which include '_uploads_' or '_downloads_' provide a subset of NDT data that are valid, completed tests which meet the criteria described on our page, [Calculating Common Metrics](https://www.measurementlab.net/data/docs/bq/ndtmetrics/). We highly recommend using standardSQL as this will be required to query all M-Lab tables in the future.

Our v3.1 tables will go into production for NDT, Paris Traceroute, and Sidestream in early 2018. Additionally, we will complete work on our [annotation service](https://github.com/m-lab/annotation-service), which will provide the blacklist_flags field, which tags test rows where infrastructure or other issues may have occurred. The annotation service provides geolocation information for all tests and has been developed as a separate service to be extensible for adding different types of metadata in the future.

A complete version history and changelog for our NDT, NPAD, Paris Traceroute, and Sidestream tables is published under [Data > Schema]({{ site.baseurl }}/data/docs/bq/schema).

## Summary of v3.1 Table/Schema and Feature Changes

There are a number of key differences between our current tables and the new tables.

### Only Final NDT Test Values are Queryable in BigQuery

Like the NDT "fast tables", the NDT v3.1 table will save only the last test row with the final results. A typical NDT test consists of about 1000 “snapshots” that are collected while running. These were previously available in the legacy tables, but not the fast table database. M-Lab saves all NDT test snapshots and final test results in our raw data archive, and we are experimenting with a repeated record format for a future update that will make all snapshots available using “deltas”.

### Anomalies

Fields in the anomalies section are being used to annotate anything that is unusual about the test files themselves (not the data). For example, the `no_meta` field indicates that the `*.meta` file was missing and the `num_snaps` field indicates the number of snapshots used, if there were fewer or more than normally expected. If `num_snaps > 2800`, then only the first 2800 snapshots are processed and reflected in the row.

### Additional Table/Schema Changes and Features

v3.1 will update the field `log_time` to an actual _timestamp_ formatted field. Due to a subtle rounding behavior in the new pipeline, values for log_time are +/- one second different than in the legacy tables, but our testing indicates that this should not affect analysis of the results.

Additionally, two new fields will be added in the table schema for v3.1:

* `task_filename` - the `gs://` archive file in M-Lab’s Google Cloud Storage bucket where the record originated
* `parse_time`  - indicates when the data row was parsed from raw storage

v3.1 tables are partitioned by day. This will not affect queries across multiple days, but can be used to interact with the dataset more efficiently. See Google’s BigQuery documentation on querying date-partitioned tables for more information. The views support the partitions efficiently using the virtual partition_date field.

## Additional Benefits from New Open Source Pipeline

Quality Assurance for NDT is built into the pipeline parser in that the new pipeline truncates the test after 14 seconds, which exceeds the expected duration of the NDT test, effectively removing data from tests that stall or were likely incomplete.

The publication latency between tests being conducted and their availability on M-Lab’s cloud services with the new ETL pipeline is approximately one day. Data is scraped and uploaded with a two-four hour latency window for busy sites, with a cleanup upload occurring at 8am UTC the next day. Busy sites and experiments should see a greatly reduced publication latency, and less-used sites and experiments should still see a latency of under 36 hours. This is a substantial improvement compared to the previous pipeline.

The new open source, cloud based pipeline will make it easier to add new M-Lab hosted experiments to BigQuery tables. M-Lab will be publishing more documentation on how to utilize the new pipeline for experiments that would like to take advantage of our cloud resources. Code is available at [https://github.com/m-lab/etl](https://github.com/m-lab/etl) in the default, "integration" branch.

## Future Work on the Horizon

Once the v3.1 tables are launched, M-Lab will continue working on our platform update, which will include a major change in 2018 in our next major table version (v4_X). One main focus of our broader platform update involves re-instrumenting all experiments and server software from web100 to tcp_info, which we expect to be completed in Q3 - Q4, 2018. This is a major platform change which has been in the planning phases for M-Lab for some time, and will be implemented with great care to maintain the longitudinal validity of our data. We also plan to extend the table annotation service provide the Autonomous System Name (ASN) of the network from which each test originated in upcoming versions. M-Lab uses the open IP to AS database provided by Maxmind to correlate users’ IP addresses to the ISP over which tests are conducted. M-Lab will also account for the date each test was run and the version of the Maxmind database for the corresponding month when re-parsing historical records new table versions.

Lastly, legacy monthly and fast tables will be retired ~6 months following the v3.1 release, which we hope provides researchers and other data users enough time to transition to using the new tables. The fast tables will still remain in our storage for historical record, but will no longer be supported after that time.  We will consult with users to determine whether the legacy monthly tables should be preserved.
