---
layout: page
title: "BigQuery Examples"
permalink: /data/bq/examples/
breadcrumb: data
---

* Table of Contents
{:toc}

# BigQuery Examples

The examples below query the M-Lab data in various ways to demonstrate effective use of the M-Lab BigQuery data set. Please note that the examples presented here assume prior knowledge of database query languages such as [SQL](https://en.wikipedia.org/wiki/SQL){:target="_blank"} and some knowledge of computer networking terms and concepts such as [subnets](https://en.wikipedia.org/wiki/Subnetwork){:target="_blank"} and [IP addresses](https://en.wikipedia.org/wiki/IP_address){:target="_blank"}.

## Basic counting: How many users?

Let's start with something simple. How many distinct users (distinct IPs, for simplicity) have ever run an **NDT** test?

~~~sql
SELECT
  COUNT(DISTINCT web100_log_entry.connection_spec.remote_ip) AS num_clients
FROM{:target="_blank"}
  plx.google:m_lab.ndt.all
WHERE
  web100_log_entry.connection_spec.remote_ip IS NOT NULL;
~~~

**Result**

| num_clients |
|-------------|
| 110814220   |

## Computing statistics over time: How many users per day?

By slightly modifying the previous query, it is possible to compute how the number of users changed over time.

The multiplication by POW(10, 6) is due to the fact that STRFTIME_UTC_USEC expects a timestamp in microseconds, while web100_log_entry.log_time is in seconds. The [BigQuery Query Reference](https://cloud.google.com/bigquery/query-reference#datetimefunctions){:target="_blank"} describes the STRFTIME_UTC_USEC function.

~~~sql
SELECT
  STRFTIME_UTC_USEC(web100_log_entry.log_time * INTEGER(POW(10, 6)),
                    '%Y-%m-%d') AS day,
  COUNT(DISTINCT web100_log_entry.connection_spec.remote_ip) AS num_clients
FROM
  plx.google:m_lab.ndt.all
WHERE
  web100_log_entry.connection_spec.remote_ip IS NOT NULL
GROUP BY
  day
ORDER BY
  day ASC;
~~~

**Result**

|    day      | num_clients |
|-------------|-------------|
| 2009-02-18  |           1 |
| 2009-02-21  |          31 |
| 2009-02-22  |         115 |
| 2009-02-23  |          73 |
| 2009-02-24  |         105 |
| ...         |         ... |
| 2015-12-27  |       52995 |
| 2015-12-28  |       50751 |

## Dealing with IP addresses: How many users from distinct subnets?

BigQuery supports various functions to parse IP addresses in different formats. You can use such functions to aggregate the number of users per subnet and to compute how many subnets have ever initiated a test.

The query that follows aggregates the client IP addresses into /24s and counts the number of unique /24s that have ever initiated at least one NDT test.

`PARSE_IP(remote_ip) & INTEGER(POW(2, 32) - POW(2, 32 - 24))` computes a [bit-wise](https://en.wikipedia.org/wiki/Bitwise_operation){:target="_blank"} AND between web100_log_entry.connection_spec.remote_ip and 255.255.255.0. The [BigQuery Query Reference](https://cloud.google.com/bigquery/query-reference#ipfunctions){:target="_blank"} describes the `PARSE_IP` and `FORMAT_IP` functions.

~~~sql
SELECT
  COUNT(DISTINCT FORMAT_IP(PARSE_IP(web100_log_entry.connection_spec.remote_ip)
        & INTEGER(POW(2, 32) - POW(2, 32 - 24)))) AS num_subnets
FROM
  plx.google:m_lab.ndt.all
~~~

**Result**

| num_subnets |
|-------------|
| 4548859     |

## Comparing NDT and NPAD tests: How many users have run both NDT and NPAD tests?

This query computes the number of distinct IP addresses that have run tests using both NDT and NPAD. The inner query (in parentheses beginning with the second SELECT statement) is an inner join between the NDT and NPAD tables containing the rows where the remote IP field in both tables match.

The outer query simply counts the number of results from the inner query (i.e., the number of rows with matching remote IP addresses).

~~~sql
SELECT
  COUNT(*) AS num_ip_addresses
FROM
  (
  SELECT
    npad.web100_log_entry.connection_spec.remote_ip,
  FROM
    plx.google:m_lab.npad.all AS npad
  JOIN
    plx.google:m_lab.npad.all AS ndt
  ON
    (npad.web100_log_entry.connection_spec.remote_ip =
     ndt.web100_log_entry.connection_spec.remote_ip)
  GROUP BY
    npad.web100_log_entry.connection_spec.remote_ip
  )
~~~

**Result**

|num_ip_addresses|
|----------------|
|           74535|

## Computing distributions of tests across users: How many users have run a certain number of tests?

Some IP addresses may have many initiated tests, while others may have only a few tests. To assess the representation of each IP address, we can classify the IP address based on the number of tests it has initiated.

* The query that follows computes the number of NDT tests initiated by each client IP address, groups the IP addresses by the number of tests run, and returns the number of IP addresses in each group.
* The inner query (in parentheses beginning with the second SELECT statement) calculates the number of NDT tests that each client performed. The query uses the GROUP BY clause to collapse all the rows with the same remote IP address. The [BigQuery Query Reference](https://cloud.google.com/bigquery/docs/query-reference#groupby){:target="_blank"} describes the `GROUP BY` command.
* The outer query transforms the results of the inner query by grouping each client according to the number of tests it performed, and then calculating the number of clients in each bucket.

~~~sql
SELECT
  num_tests,
  COUNT(*) AS num_clients
FROM
  (
    SELECT
      COUNT(*) num_tests,
      web100_log_entry.connection_spec.remote_ip AS remote_ip
    FROM
      plx.google:m_lab.ndt.all
    WHERE
      web100_log_entry.log_time >= PARSE_UTC_USEC('2015-12-01 00:00:00') / POW(10, 6)
      AND web100_log_entry.log_time < PARSE_UTC_USEC('2016-01-01 00:00:00') / POW(10, 6)
    GROUP BY
      remote_ip
  )
GROUP BY
  num_tests
ORDER BY
  num_tests ASC;
~~~

**Result**

|num_tests|num_clients|
|---------|-----------|
|1        |267912     |
|2        |453058     |
|3        |94160      |
|4        |113948     |
|...      |...        |
|5557     |1          |
|5613     |1          |
|26717    |1          |