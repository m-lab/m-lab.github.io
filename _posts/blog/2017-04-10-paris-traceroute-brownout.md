---
layout: blog
title: "Paris Traceroute Brownout"
author: "Chris Ritzo"
breadcrumb: blog
categories:
  - data
  - paris traceroute
---

# Paris Traceroute Brownout

## Summary:

In February 2017, M-Lab was notified of issues with the M-Lab data available in BigQuery. Upon investigation, a problem was identified with the Paris Traceroute collection daemon which resulted in a reduction in Paris Traceroute measurements beginning in June 2016. At the peak of the outage, fourth quarter 2016 - January 2017, approximately 5% of NDT tests had an associated Paris Traceroute test. Additionally, an issue within the data processing pipeline resulted in Paris Traceroute data that was measured and collected, not being inserted into the BigQuery tables and therefore available for use.<!--more-->

Both defects were resolved in mid-February, additional monitoring was added, and BigQuery has been brought up to date with the available data. 

## Details:

The bug was introduced in June 2016, when we deployed a new version of the Paris Traceroute tool. This new version was better in many respects, in that it would run the test for a larger fraction of NDT tests that M-Lab receives. The update was also intended to run those tests using the same source and destination TCP ports to ensure that any layer 4 load-balancers on the path would treat the Paris Traceroute packets the same way they treated the NDT test packets.

Paris Traceroute coverage of NDT jumped from 55-75%, which we had been seeing earlier in the year, to 85% shortly after the deployment.

Unfortunately, while the first installation and startup demonstrated that the Paris Traceroute tool was a huge improvement, it had a race condition that frequently prevented it from restarting successfully when a server rebooted. Maintenance and updates to the M-Lab platform typically results in 5% to 20% of the servers rebooting each week, so the number of machines with properly operating Paris Traceroute daemons gradually dropped over the following six months. By December, we were measuring less than 15,000 unique Paris Traceroutes per day, even though NDT test volume had grown to over 200,000 tests per day. 

In late January, a researcher brought to our attention that there was no Paris Traceroute data for Sydney, Australia since July 2016. We initially thought this was a BigQuery pipeline problem, but discovered on February 9 that the raw data was also missing from the BigStore files. This led to the discovery that the daemon was not functioning properly, and we soon discovered the race condition that was the root cause. A related pipeline problem also resulted in data that was collected only being pushed to BigStore, and not to BigQuery.

The collection problem has been rectified (github), and we have added monitoring and alerting to ensure that the Paris Traceroute jobs are running. The pipeline problem has also been addressed, and all available Paris traceroute data has been pushed to BigQuery. Our new processing pipeline (in development) will include monitoring of test counts, so this class of issues should no longer be able to persist for more than a few days without causing an alert.

The bad news is that Paris Traceroute data for the M-Lab platform is very sparse for the latter half of 2016 and early 2017. An accounting of daily NDT tests to unique client addresses, and daily Paris Traceroute tests to corresponding addresses shows the following weekly coverage. You can see the uptick in coverage in week 24 and 25, the gradual decrease in coverage in ensuing weeks, and the surge in NDT test counts starting around week 29. The issue was resolved in 2017 week 6 and 7, and you can see the corresponding restoration of test coverage.

<div class="table-responsive" markdown="1">

|  year	|  week  |  ndt_tests  |  pt_tests  |   %   |
| :-----|:------:|:-----------:|:----------:|:------|
| 2016  | 21     | 391624      | 220025     | 56.18 |
| 2016  | 22     | 406367      | 271845     | 66.90 |
| 2016  | 23     | 416730      | 275954     | 66.22 |
| 2016  | 24     | 412697      | 323775     | 78.45 |
| 2016  | 25     | 423601      | 358566     | 84.65 |
| 2016  | 26     | 402461      | 321197     | 79.81 |
| 2016  | 27     | 454424      | 336444     | 74.04 |
| 2016  | 28     | 468149      | 318792     | 68.10 |
| 2016  | 29     | 529151      | 291702     | 55.13 | 
| 2016  | 30     | 654513      | 309584     | 47.30 |
| 2016  | 31     | 884118      | 372715     | 42.16 |
| 2016  | 32     | 968719      | 377798     | 39.00 |
| 2016  | 33     | 992234      | 388339     | 39.14 |
| 2016  | 34     | 1042148     | 382655     | 36.72 |
| 2016  | 35     | 1086401     | 363672     | 33.47 |
| 2016  | 36     | 1125381     | 337876     | 30.02 |
| 2016  | 37     | 1116448     | 286531     | 25.66 |
| 2016  | 38     | 1259814     | 197173     | 15.65 |
| 2016  | 39     | 1310179     | 93825      | 7.16  |
| 2016  | 40     | 1329701     | 76366      | 5.74  |
| 2016  | 41     | 1293060     | 70755      | 5.47  |
| 2016  | 42     | 1243503     | 59420      | 4.78  |
| 2016  | 43     | 1176804     | 56772      | 4.82  |
| 2016  | 44     | 1026661     | 47130      | 4.59  |
| 2016  | 45     | 1181540     | 34044      | 2.88  |
| 2016  | 46     | 1205690     | 46432      | 3.85  |
| 2016  | 47     | 1303431     | 86086      | 6.60  |
| 2016  | 48     | 1329139     | 92356      | 6.95  |
| 2016  | 49     | 1449058     | 95055      | 6.56  |
| 2016  | 50     | 1583852     | 121391     | 7.66  |
| 2016  | 51     | 1654478     | 112102     | 6.78  |
| 2016  | 52     | 1578605     | 80632      | 5.11  |
| 2016  | 53     | 1742942     | 110150     | 6.32  |
| 2017  | 1      | 1811016     | 88584      | 4.89  |
| 2017  | 2      | 1844633     | 92833      | 5.03  |
| 2017  | 3      | 1772941     | 118736     | 6.70  |
| 2017  | 4      | 1762644     | 160980     | 9.13  |
| 2017  | 5      | 1790433     | 168677     | 9.42  |
| 2017  | 6      | 1808985     | 600434     | 33.19 |
| 2017  | 7      | 1788070     | 1550172    | 86.70 |
| 2017  | 8      | 1858179     | 1565195    | 84.23 |
| 2017  | 9      | 1862311     | 1663829    | 89.34 |
| 2017  | 10     | 1851940     | 1747511    | 94.36 |
| 2017  | 11     | 1969324     | 1864045    | 94.65 |
| 2017  | 12     | 1898877     | 1754154    | 92.38 |

</div>

![NDT tests and Paris Traceroute tests per week, June 2016 - Mar 2017]({{ site.baseurl }}/images/blog/pt-brownout-graph.png)

All Paris Traceroute data in BigStore and BigQuery is correct, but the bug did cause considerable data loss relative to what might have been measured and collected. From a statistical analysis point of view, it is further unfortunate that the data gaps are systematic rather than random. When a machine failed to start the daemon properly, the region of the Internet served by that site would become systematically less likely to be traced. The problem has been fixed, job count alerting has been added, and activity based alerting will soon be added to prevent problems like this in the future.

Thanks to Xiaohong Deng and Ben Dowling for bringing this problem to our attention!