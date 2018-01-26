---
layout: page
title: Calculating Common Metrics
permalink: /data/docs/bq/ndtmetrics/
breadcrumb: data
---

# Calculating Common Metrics for NDT Data

Commonly reported metrics such as upload or download speed, are calculated from data fields saved by the Network Diagnostic Tool. This document explains how those calculations are made in more detail.

The most commonly reported metrics are: _Download Throughput (Mbps)_, _Upload Throughput (Mbps)_, _Round Trip Time (ms)_. This page provides recommended queries for these metrics, limiting results to only valid tests. For the purposes of research, we consider valid NDT tests to be those that:

* Have exchanged more than 8 KB of data
* Have a test duration greater than 9 seconds and less than 15 seconds
* TCP congestion was greater than 0
* Were in a congestion limited state for at least 80% of the test duration
* Congestion has been caused by the client for less than 20% of the test duration
* Traffic queuing on the switch was not present at the time of the test

For each metric, this section includes the BigQuery queries used to compute the metrics. All the queries include conditions to filter out incomplete or invalid test results. Please note that the queries below are examples intended to illustrate how to calculate metrics during the query, and only return the first 100 results from the United States between 2017-01-01 and 2017-01-02. See [BigQuery Schema]({{ site.baseurl }}/data/docs/bq/schema) for additional fields that can be selected, as well as [BigQuery Examples]({{ site.baseurl }}/data/docs/bq/examples) for additional filtering options.

## NDT BigQuery Fields, Units, Formulas and Queries

Internet 2's NDT protocol specifies how to calculate these metrics using the data collected by the NDT test. NDT saves each of the variables that go into these metrics separately, and the values for each are important to know when calculating things like download and upload throughput, and displaying them in the desired format.

### Units of Measure, Converting to megabits per second (Mbps)

In the formulas and examples below, it is important to note the units of measure that NDT uses for fields that represent data sent and received, as well as for fields representing durations.

* **Data sent/recevied** fields are a count of **bytes**
* **Duration** fields are saved in **microseconds**

The formula below shows how we convert our final values to Mbps when calculating Download or Upload throughput, using **8** as a multiplier in our BigQuery clauses:

```bash
1 byte/microsecond * 8 bits/byte =
8 bits/microsecond * (1 / 1,000,000) megabits/bit =
8 / 1,000,000 megabits/microsecond * 1,000,000 microseconds/second =
8 megabits/second => 8 Mbps
```

## Download throughput

Download throughput is computed for every server-to-client test as the ratio of the data transmitted during the test and the duration of the test. Results of tests that ended during **slow start** are excluded.

Download throughput is calculated using this formula within the query:

```sql
8 *
(web100_log_entry.snap.HCThruOctetsAcked /
 (web100_log_entry.snap.SndLimTimeRwin +
 web100_log_entry.snap.SndLimTimeCwnd +
 web100_log_entry.snap.SndLimTimeSnd))
```

The complete BigQuery example is:

```sql
SELECT
  8 * (web100_log_entry.snap.HCThruOctetsAcked /
    (web100_log_entry.snap.SndLimTimeRwin +
    web100_log_entry.snap.SndLimTimeCwnd +
    web100_log_entry.snap.SndLimTimeSnd)) AS download_Mbps
FROM
  [measurement-lab:public.ndt]
WHERE
  _PARTITIONTIME BETWEEN TIMESTAMP('2017-01-01') AND TIMESTAMP('2017-08-28')
  AND web100_log_entry.deltas.is_last=true
  AND IS_EXPLICITLY_DEFINED(web100_log_entry.connection_spec.remote_ip)
  AND IS_EXPLICITLY_DEFINED (web100_log_entry.connection_spec.local_ip)
  AND IS_EXPLICITLY_DEFINED(web100_log_entry.snap.HCThruOctetsAcked)
  AND IS_EXPLICITLY_DEFINED(web100_log_entry.snap.SndLimTimeRwin)
  AND IS_EXPLICITLY_DEFINED(web100_log_entry.snap.SndLimTimeCwnd)
  AND IS_EXPLICITLY_DEFINED(web100_log_entry.snap.SndLimTimeSnd)
  AND IS_EXPLICITLY_DEFINED(connection_spec.data_direction)
  AND connection_spec.data_direction = 1
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
  AND anomalies.blacklist_flags == 0
  LIMIT 100
```

## Upload throughput

Upload throughput is computed for every client-to-server test as the ratio of the data transmitted during the test and the duration of the test.

It is not possible to exclude results of tests that ended during slow start, because the web100 variable `web100_log_entry.snap.CongSignals` is not updated during client-to-server tests.

Upload throughput is calculated using this formula within the query:

```sql
8 * (web100_log_entry.snap.HCThruOctetsReceived/web100_log_entry.snap.Duration) AS upload_Mbps
```

The complete BigQuery example is:

```sql
SELECT
 8 * (web100_log_entry.snap.HCThruOctetsReceived/web100_log_entry.snap.Duration) AS upload_Mbps
FROM
  [measurement-lab:public.ndt]
WHERE
  _PARTITIONTIME BETWEEN TIMESTAMP('2017-01-01') AND TIMESTAMP('2017-08-28')
  AND web100_log_entry.deltas.is_last=true
  AND IS_EXPLICITLY_DEFINED(web100_log_entry.connection_spec.remote_ip)
  AND IS_EXPLICITLY_DEFINED(web100_log_entry.connection_spec.local_ip)
  AND IS_EXPLICITLY_DEFINED(web100_log_entry.snap.HCThruOctetsReceived)
  AND IS_EXPLICITLY_DEFINED(web100_log_entry.snap.Duration)
  AND IS_EXPLICITLY_DEFINED(connection_spec.data_direction)
  AND connection_spec.data_direction = 0
  AND web100_log_entry.snap.HCThruOctetsReceived >= 8192
  AND web100_log_entry.snap.Duration >= 9000000
  AND web100_log_entry.snap.Duration < 3600000000
  AND (web100_log_entry.snap.State == 1
      OR (web100_log_entry.snap.State >= 5
      AND web100_log_entry.snap.State <= 11))
  AND anomalies.blacklist_flags == 0
  LIMIT 100
```

## Round Trip Time (RTT)

Server-to-client RTT is affected by TCP congestion. As a consequence, there are (at least) 2 ways to estimate the RTT using web100 data. These 2 ways provide different, non-equivalent information about the user connection.

### Server-client **(time) distance**

* Estimated using the **minimum RTT** measured during the test, which most likely happened before the test reached congestion.
* This value is reported by the web100 variable `web100_log_entry.snap.MinRTT`
* However, using this variable has the drawback that it might underestimate the connection RTT, because it might be measured in the SYC ACK exchange or some other tiny transaction which, for low speed links, does not represent the typical RTT for the full data segment.
* Note that using `PreCongSumRTT/PreCongCountRTT` does not provide a more accurate estimate, because both `PreCongSumRTT` and `PreCongCountRTT` are recorded right before the first congestion signal, which, in the worst case, occurs when the receiver queue is already full, which affects the RTT.

### Server-client **latency during data transfers** (with congestion)

* Estimated using the **average RTT**, uniformly averaged over an entire test.
* This value can be computed as `web100_log_entry.snap.SumRTT/web100_log_entry.snap.CountRTT`
* In this case, it makes sense to exclude results of tests with **10 or fewer round trip time samples**, because there are not enough samples to accurately estimate the RTT. This condition is expressed in BigQuery with:`web100_log_entry.snap.CountRTT > 10`

Given that the NDT server updates the web100 variables `web100_log_entry.snap.MinRTT` and `web100_log_entry.snap.CountRTT` only when it receives an acknowledgement and given that, during client-to-server tests the NDT server receives an ack only during the 3-way-handshake, RTT values are computed only for server-to-client tests.

The complete BigQuery example is:

```sql
SELECT
  web100_log_entry.snap.MinRTT AS min_rtt
FROM
  [measurement-lab:public.ndt]
WHERE
  _PARTITIONTIME BETWEEN TIMESTAMP('2017-01-01') AND TIMESTAMP('2017-08-28')
  AND web100_log_entry.deltas.is_last=true
  AND IS_EXPLICITLY_DEFINED(web100_log_entry.connection_spec.remote_ip)
  AND IS_EXPLICITLY_DEFINED(web100_log_entry.connection_spec.local_ip)
  AND IS_EXPLICITLY_DEFINED(web100_log_entry.snap.HCThruOctetsAcked)
  AND IS_EXPLICITLY_DEFINED(web100_log_entry.snap.SndLimTimeRwin)
  AND IS_EXPLICITLY_DEFINED(web100_log_entry.snap.SndLimTimeCwnd)
  AND IS_EXPLICITLY_DEFINED(web100_log_entry.snap.SndLimTimeSnd)
  AND IS_EXPLICITLY_DEFINED(connection_spec.data_direction)
  AND connection_spec.data_direction = 1
  AND web100_log_entry.snap.HCThruOctetsAcked >= 8192
  AND (web100_log_entry.snap.SndLimTimeRwin +
       web100_log_entry.snap.SndLimTimeCwnd +
       web100_log_entry.snap.SndLimTimeSnd) >= 9000000
  AND (web100_log_entry.snap.SndLimTimeRwin +
       web100_log_entry.snap.SndLimTimeCwnd +
       web100_log_entry.snap.SndLimTimeSnd) < 3600000000
  AND IS_EXPLICITLY_DEFINED(web100_log_entry.snap.MinRTT)
  AND IS_EXPLICITLY_DEFINED(web100_log_entry.snap.CountRTT)
  AND web100_log_entry.snap.CountRTT > 10
  AND (web100_log_entry.snap.State == 1
       OR (web100_log_entry.snap.State >= 5
       AND web100_log_entry.snap.State <= 11))
  AND anomalies.blacklist_flags == 0
  LIMIT 100
```