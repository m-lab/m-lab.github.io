---
layout: page
permalink: /tests/ndt/views/migrate/
title: "Migrating Queries from Previous to Current NDT Unified Views"
breadcrumb: tests
---

# Migrating Queries from Previous to Current NDT Unified Views

In July 2020, M-Lab began publishing new ["Unified Views" for the NDT
dataset](blog-ndt-unified-views) in BigQuery. These views function just like
tables, but provide only NDT tests that meet our team's current, best
understanding of test completeness and research quality. Combined with our
related work to [standardize the columns provided in our BigQuery
datasets](blog-std-cols), M-Lab can better enable Long Term Support of stable schemas.

[blog-std-cols]: {{ site.baseurl }}/blog/long-term-schema-support-standard-columns/
[blog-ndt-unified-views]: {{ site.baseurl }}/blog/new-ndt-unified-views/

In the long term, this will reduce the number of breaking changes to your
queries from schema or field name changes. However, in the short term, this
document will aide users in migrating queries to the latest NDT Unified Views.

## NDT Protocols Reference

The NDT dataset now contains data from three different NDT protocol types:
[web100](web100), [ndt5](ndt5), & [ndt7](ndt7). Your past queries may contain
field names that were only present in the test results of one of these
protocols. More information about the [history of the NDT test and
protocols](ndt-evolution) hosted by M-Lab can be found on our blog. Our standard
columns approach and NDT unified views remove this issue.

[web100]: {{ site.baseurl }}/tests/ndt/web100/
[ndt5]: {{ site.baseurl }}/tests/ndt/ndt5/
[ndt7]: {{ site.baseurl }}/tests/ndt/ndt7/
[ndt-evolution]: {{ site.baseurl }}/blog/evolution-of-ndt/

## NDT Views Reference

We now publish two series of BigQuery Views for NDT data: "Faithful" and
"Helpful". [As described on the NDT page](ndt-page). The Helpful views are another
name for the Unified Views. Complete information about [how NDT views are
derived and published](ndt-views) is also available. **This document will focus on
migrating queries to use NDT "Helpful Views"**

[ndt-page]: {{ site.baseurl }}/tests/ndt/#current-bigquery-tablesviews
[ndt-views]: {{ site.baseurl }}/tests/ndt/views/

## NDT Unified Views Schema Crosswalk

Most of our users are interested in NDT tests that meet our team's current, best
understanding of test completeness and research quality. The NDT unified views
provide this, and also present a standard set of columns of interest to most
people. The current NDT unified views are:

* `measurement-lab.ndt.unified_downloads`
* `measurement-lab.ndt.unified_uploads`

Your queries may be based on several possible tables or views that we published
previously. Here we will focus on general strategies for updating your queries.
If you find that your queries contain fields not mentioned here, please consult
the schemas for each NDT protocol (see links above), or email support@measurementlab.net

### Updating Table Names in Queries

First, you'll need to update the tables/views in your queries. Below we list of
previously published tables and views, and which tables/views you should use
instead. If two tables are listed in the right column, this indicates that the original table included both upload and download tests.

<div class="table-responsive" markdown="1">

| Previously Published Tables/Views | Recommended Replacement |
| :---------------------------------|:------------------------|
| `measurement-lab.ndt.recommended` | `measurement-lab.ndt.unified_downloads`, `measurement-lab.ndt.unified_uploads`|
| `measurement-lab.ndt.downloads` | `measurement-lab.ndt.unified_downloads` |
| `measurement-lab.ndt.uploads` | `measurement-lab.ndt.unified_uploads`|
| `measurement-lab.release.ndt_all`| `measurement-lab.ndt.unified_downloads`, `measurement-lab.ndt.unified_uploads` |
| `measurement-lab.release.ndt_all`| `measurement-lab.ndt.unified_downloads`, `measurement-lab.ndt.unified_uploads` |
| `measurement-lab.release.ndt_downloads`| `measurement-lab.ndt.unified_downloads` |
| `measurement-lab.release.ndt_uploads`| `measurement-lab.ndt.unified_uploads` |
| `measurement-lab.release.ndt_downloads_legacysql`| `measurement-lab.ndt.unified_downloads` |
| `measurement-lab.release.ndt_uploads_legacysql`| `measurement-lab.ndt.unified_uploads` |

</div>

### Updating Desired Metrics in Queries

A goal of the NDT Unified Views is to present the most commonly needed test
metrics and metadata in the first part of the views' schemas. For quick
reference, those fields are listed below.

<div class="table-responsive" markdown="1">

| id | The Universally Unique Identifier assigned to this test |
| date | The date this test was run in UTC |
| a. UUID | The Universally Unique Identifier assigned to this test |
| a. TestTime  | The date and time this test was conducted in UTC |
| a. CongestionControl | The TCP congestion control algorithm used during this
measurement. One of: reno, cubic, bbr |
| a. MeanThroughputMbps | The download or upload throughput measured in Megabits
per second |
| a. MinRTT | The Minimum Round Trip Time in milliseconds |
| a. LossRate | The packet loss rate in milliseconds |
| node. _Instruments  | Indicates the server-side instrumentation that provided
measurements for this test. One of: web100, tcpinfo, ndt7 |

</div>

Previously some metrics like upload or download throughput had to be calculated
from component fields. For example in web100 NDT data, download throughput was
calculated in a query using this formula:

```~sql
(8 * web100_log_entry.snap.HCThruOctetsAcked/
(web100_log_entry.snap.SndLimTimeRwin +
web100_log_entry.snap.SndLimTimeCwnd +
web100_log_entry.snap.SndLimTimeSnd)
```
<br>

The new NDT Unified Views provide upload and download throughput as a single
field: `a.MeanThroughputMbps`. It is labelled "Mean" because it is the average
of each TCP snapshot that occurs during every NDT test. If you need upload
throughput, select `a.MeanThroughputMbps` from
`measurement-lab.ndt.unified_uploads`, or download throughput from
`measurement-lab.ndt.unified_downloads`

If your research requires access to additional metrics not present in the NDT
Unified Views, please review [Obtaining Additional Metrics from Intermediate or
Raw Tables & Views]({{ site.baseurl }}/tests/ndt/unified-views/migrate#obtaining-additional-metrics-from-intermediate-or-raw-tables-and-views),

### Name Changes to Annotated Fields

Many fields in our NDT tables and views are annotations based on the IP address
for each test. In most cases, these fields' names have not changed, or are
similar, but their full path in the schema structure has been simplified. Below
we provide a brief example of some of these fields from previous schemas, and
their equivalents in the NDT Unified Views:

<div class="table-responsive" markdown="1">

| connection_spec.client_geolocation.latitude | client.Geo.Latitude |
| connection_spec.client_geolocation.longitude | client.Geo.Longitude |
| connection_spec.client_geolocation.postal_code | client.Geo.PostalCode |
| connection_spec.client_geolocation.region | client.Geo.Region |
| connection_spec.client_geolocation.country_code | client.Geo.CountryCode |

</div>

### Obtaining Additional Metrics from Intermediate or Raw Tables and Views

Another goal of the NDT Unified Views is to simplify the schema to support the
majority of users. For researchers who need access to additional metrics from
the measurement, or TCP internal statistics that were gathered during the
measurement, a join or match is necessary to access the relevant fields from the
raw measurement tables or other related tables and views. 

If you don't see a field that you need in the unified views, the next step is to
see if the field is available in the Faithful view for the test protocol. The
entire list of fields collected by TCPINFO for an ndt7 test are available in:
`measurement-lab.ndt.ndt7` in the `raw` record. For example, if we wanted to
include the TCP Window Scale measured during an upload test, we could select the
field: `measurement-lab.ndt.ndt7.raw.Upload.ServerMeasurements.TCPInfo.WScale`

These can be pulled into your query by matching on the test UUID, for example:

`WHERE ndt.unified_downloads.a.UUID = ndt.ndt7.id`

The UUID field is a unique ID for each TCP connection to any of our servers, and is very useful for matching and joining generally. 

### Non-equivalent TCP Metrics Across NDT Protocol Types

One result of our change to the TCP Kernel Instrumention discussed in our blog
post, [The Evolution of NDT](ndt-evolution), is that some fields available in
the NDT web100 datatype are no longer provided or don't have equivalents from
TCP_INFO, which replaced web100 in Nov. 2019.

The NDT Unified Views present the metrics and fields common across all NDT
datatypes (web100, ndft5, ndt7). However, some additional metrics may be
available in one or two datatypes, but not all. For example, consider the query
below that returned data from the web100 NDT datatype:

```~sql
SELECT 
    web100_log_entry.snap.MaxRTT AS maxRTT,  
    web100_log_entry.snap.MinRTT AS minRTT 
FROM `measurement-lab.ndt.recommended` 
WHERE connection_spec.client_geolocation.city = 'Salt Lake City'
AND connection_spec.client_geolocation.region = 'UT'
AND web100_log_entry.snap.MaxRTT > 0
AND web100_log_entry.snap.MinRTT > 0
```
<br>
In the NDT Unified Views, `MaxRTT` is not present. However, for ndt5 and web100
datatypes, this field can still be accessed and compared.

For example, `MaxRTT` is available in:

* `measurement-lab.ndt.web100.web100_log_entry.snap.MaxRTT`
* `measurement-lab.ndt.ndt5.result.S2C.MaxRTT`

If you find that there are commonly used fields that should be included in the
NDT Unified Views, please email us at support@measurementlab.net.