---
layout: blog
title: "Monitoring Interconnection Performance Since the Open Internet Order"
author: "Collin Anderson"
date: 2017-08-09
breadcrumb: blog
categories:
  - interconnection
  - research
  - observatory
  - data
  - data analysis
  - research
---

# Monitoring Interconnection Performance Since the Open Internet Order
{% include post-meta.html %}

## Introduction

As a platform committed to producing empirical data for the public, Measurement Lab (M-Lab) has [historically supplied regulators and other governmental entities](https://www.measurementlab.net/publications/#government--regulatory-filings) with technical facts pertinent rule-making processes. In our [February 2015 submission to the FCC’s Open Internet docket](https://www.measurementlab.net/publications/M-Lab_Interconnection_Study_US.pdf), we committed to research on the state of broadband and performance impact of interconnection in the United States. Earlier this year, the FCC began the process of re-evaluating its authority over broadband Internet services, and [opened a Notice of Proposed Rulemaking](https://apps.fcc.gov/edocs_public/attachmatch/DOC-344614A1.pdf). This blogpost is a shortened version [comments that M-Lab filed in the docket](https://www.fcc.gov/ecfs/filing/10715748225796) regarding its continued research on the impact of interconnection on consumer broadband. The full filing in the FCC docket includes an elaboration of our research with additional supporting evidence and charts.

<!--more-->

In this post, we review historical interconnection congestion episodes that appeared to have had a negative impact on consumer broadband and followed how these relationships had changed since the Open Internet Order. Since our [last blogpost on interconnection over two years ago](https://www.measurementlab.net/blog/interconnection_and_measurement_update/), the relationships between operators have changed, resulting in overall improvement in consumer performance and a notable remediation of congestion episodes covered in our initial reports. Often the improvements are sudden, reversing months long underperformance within days. The remediation of congestion parallels an overall improvement across networks in performance for broadband users, and in our analysis we do not find the same patterns of sustained degradation described in past reports. Our research has demonstrated that interconnection congestion can have a sustained, deleterious impact on consumers that is often reversed as soon as operators resolve the underlying business factors that led to insufficient capacity. The transparency provided by measurement will continue to be important tool in understanding how interconnection will evolve in the United States independent of the outcome of the FCC decision-making process.

## M-Lab’s Interconnection Research

In October 2014, Measurement Lab released the report ["ISP Interconnection and its Impact on Consumer Internet Performance"](https://www.measurementlab.net/publications/isp-interconnection-impact.pdf), which was a first-of-its-kind, wide-scale study on the effects of interconnection disputes on consumer broadband in the United States. This research is made possible by the volume of M-Lab’s data collection, which contains over eight years of network measurements from a large population users across a diverse set of networks. The networks that M-Lab has hosted sites within are typically those used to host content and interconnect other networks. Therefore, degraded performance to these transit ISPs can create barriers to accessing the services within these networks and overall impact Internet usability for consumers.

M-Lab’s focus on interconnection was initially inspired by our observation of relative underperformance in cities where the platform maintained multiple measurement sites. Using a straightforward research method and open data, M-Lab compared trends across the US to identify patterns of performance degradation that occurred between prominent access and transit ISPs. We defined “degradation” as a drop in download throughput, an increase in round trip time, or an increase in packet retransmission rate, relative to past performance of that network and other networks in the same location. To avoid spurious reports, the incidents described were those where substantial degradation occurred, rather than minor disruptions. These episodes had clear fingerprints: observed degradation was nearly always diurnal, with significantly worse performance during peak use hours (defined by the FCC as between 7pm and 11pm local time). Degraded performance co-occurring with peak usage suggested that network load was causing congestion that lead to poor performance. These episodes of poor performance frequently continued every day for months without being fixed, which further pointed towards systemic network under-provisioning as a cause.

In the Interconnection Study, we found a consistent theme across multiple access ISPs and transit ISPs: the interconnection relationships between network operators have a significant impact on broadband performance. M-Lab observed sustained degradation experienced by customers of the most prominent American broadband access ISPs: AT&T, Comcast, CenturyLink, Time Warner Cable, and Verizon. The degradation documented in the publication occurred when traffic passed over interconnections with transit ISPs Cogent Communications (Cogent), Level 3 Communications (Level 3), and XO Communications (XO) – networks where M-Lab had hosted measurement endpoints. We observed similar patterns of performance degradation whenever and wherever specific pairs of access and transit ISPs interconnected. While the onset of congestion and end consumer impact differed between each access and transit provider relationship, the sustained episodes documented in the report typically began in early 2013, and continued into the following year.

<table style="width: 100%;">
  <tr>
    <td><a href="https://viz.measurementlab.net/compare/location?end=2014-01-01&filter1=AS10796x_AS11486x_AS32953&filter2=AS29791_AS174&selected=nausny&start=2013-01-01"><img alt="Verizon across Internap and Cogent in New York, January 2013 - January 2014, Download Throughput" title="Verizon across Internap and Cogent in New York, January 2013 - January 2014, Download Throughput" src="{{ site.baseurl }}/images/blog/interconnection_update-Verizon-Internap_Cogent-NY.png"></a></td>
  </tr>
  <tr>
    <td style="font-style: italic;">Verizon across Internap and Cogent in New York, January 2013 - January 2014, Download Throughput - <a href="https://viz.measurementlab.net/compare/location?end=2014-01-01&filter1=AS10796x_AS11486x_AS32953&filter2=AS29791_AS174&selected=nausny&start=2013-01-01">Source</a>
    </td>
  </tr>
</table>

M-Lab has since invested resources to build up its presence in the United States to monitor more networks and to support further research on the state of interconnection. M-Lab has continued to expand its measurement infrastructure and data collection volume. The increase in the volume of tests paired with our expanded network presence has enabled M-Lab to make more assessments based on more diverse datasets. The platform now maintains fifty-six measurement sites in the United States, covering a number of transit ISPs in key peering locations across the country. Following on from the Interconnection Study, in June 2015 M-Lab published the blogpost ["New Opportunities for Test Deployment and Continued Analysis of Interconnection Performance"](https://www.measurementlab.net/blog/interconnection_and_measurement_update/) that documented more congestion episodes detected on additional transit networks. In the months leading up to the first report, Measurement Lab expanded its infrastructure presence, covering new transit networks and diversifying the locations where it had sites in existing networks. This build out of infrastructure was paralleled with an emphasis on new partnerships and measurement tools to increase the amount of tests collected. After months of data collection from these new locations and networks, M-Lab found patterns of degradation that matched those of the Interconnection Report beyond the original transit ISPs.

<table style="width: 100%;">
  <tr>
    <td><a href="https://viz.measurementlab.net/compare/location?breakdownBy=filter2&end=2015-06-01&filter1=AS11486x_AS10796x_AS13367x_AS11398x_AS10774x&filter2=AS3257&selected=naus&start=2014-01-01"><img alt="Verizon across GTT, January 2014 - June 2015, Download Throughput" title="Verizon across GTT, January 2014 - June 2015, Download Throughput" src="{{ site.baseurl }}/images/blog/interconnection_update-Verizon-GTT.png"></a>
    </td>
    <td><a href="https://viz.measurementlab.net/compare/location?breakdownBy=filter2&end=2015-06-01&filter1=AS11486x_AS10796x_AS13367x_AS11398x_AS10774x&filter2=AS3257&selected=naus&start=2014-01-01"><img alt="AT&T across GTT, January 2014 - June 2015, Download Throughput" title="AT&T across GTT, January 2014 - June 2015, Download Throughput" src="{{ site.baseurl }}/images/blog/interconnection_update-Verizon-ATT.png"></a>
    </td>
    <td><a href="https://viz.measurementlab.net/compare/location?breakdownBy=filter2&end=2015-06-01&filter1=AS11486x_AS10796x_AS13367x_AS11398x_AS10774x&filter2=AS3257&selected=naus&start=2014-01-01"><img alt="Cox across GTT, January 2014 - June 2015, Download Throughput" title="Cox across GTT, January 2014 - June 2015, Download Throughput" src="{{ site.baseurl }}/images/blog/interconnection_update-Verizon-Cox.png"></a>
    </td>
  </tr>
  <tr>
    <td colspan="3" style="font-style: italic;">Verizon, AT&T, and Cox across GTT, January 2014 - June 2015, Download Throughput - <a href="https://viz.measurementlab.net/compare/location?breakdownBy=filter2&end=2015-06-01&filter1=AS11486x_AS10796x_AS13367x_AS11398x_AS10774x&filter2=AS3257&selected=naus&start=2014-01-01">Source</a>
    </td>
  </tr>
</table>

Our updated findings showed persistent degradation experienced by customers of a number of major access ISPs across the United States during the first half of 2015. While the ISPs involved in each case differ, the symptoms and patterns of degradation are similar to those detailed in Interconnection Study: decreased download throughput, increased latency, and increased packet loss (compared to the performance through different access ISPs in the same region). In nearly all cases degradation was worse during peak use hours. The congestion events included:

* AT&T, Comcast, Time Warner Cable, and Verizon with GTT Communications (GTT)
* CenturyLink with Tata Communications (Tata)

In the most severe cases, degradation represented a substantial impediment to accessing certain content for several prominent access ISPs, lasting for months and leading to download throughput speed well below the definition of broadband (at that time, 4 Mbps). While the cases differed in end user impact, the trends were national and were observed on several different transit ISPs, rather than being one problematic network.

## Since the Open Internet Order, Significant, Detectable Congestion Episodes Have Declined

Since the issuance of the Open Internet Order in February 2015, Measurement Lab has found a significant overall improvement in performance in broadband access in the United States and a subsidence of interconnection-related degradation. Based on review of the congestion episodes documented in the Interconnection Study and a new analysis of the M-Lab data, the problems identified in previous reports are often alleviated in the months after second quarter of 2015 and onward. Whereas we also noted cases of intermittent, medium-term congestion episodes in past publications, such as with XO and Comcast, the restoration of performance has been sustained. Such issues are more rare than in the past. A broad search of the dataset only identifies a small numbers of cases where interconnection relationships exhibit indications of congestion. M-Lab has also observed an overall improvement in the performance of broadband across all metrics. These finding demonstrate that since our original research the Internet in the United States has become more reliable and better performing, with interconnection conditions less likely to be the bottleneck in consumers’ access to content than in the past.

The most significant degradation identified in our search was for Comcast users to M-Lab sites located in the transit ISPs Tata and GTT. Underperformance appears from the outset of M-Lab hosting sites in GTT, therefore predating September 2014. The degradation for Comcast customers across Tata appears later, beginning around September 2015. While M-Lab had identified underperformance with Tata for multiple access ISPs in our June 2015 blogpost describing additional cases of congestion, those patterns were alleviated shortly after our research on the episode (notably with CenturyLink). Comcast is an exception: underperformance appears in the M-Lab data as a decrease of download throughput during peak hours that aligns with an increased packet loss at that time. The degradation represents a substantial overall change in performance from Comcast to both transit ISPs, well beyond half of the performance compared to earlier in the day. During the same period, other access ISPs, such as AT&T or Verizon, no longer exhibit patterns of degradation to Tata and GTT. Likewise, Comcast users [do not show the same underperformance](http://viz.measurementlab.net/compare/location?aggr=month&end=2017-06-01&filter1=AS10774x_AS11486x_AS13367x&filter2=AS6453_AS3257_AS174_AS6461_AS6939&metric=download&selected=naus&start=2016-01-01) to other sites, such as those on Cogent, Zayo, or Hurricane Electric. A review of collected data related to Comcast and Tata from May and June 2017 shows less degradation, which tentatively suggests that remediative measures may have been taken recently to improve performance.

<table style="width: 100%;">
  <tr>
    <td><a href="https://viz.measurementlab.net/compare/location?aggr=month&end=2017-06-01&filter1=AS13367x&filter2=AS6453_AS3257_AS174&metric=download&selected=naus&start=2016-01-01"><img alt="Comcast across TATA, January 2016 - April 2017, Diurnal Pattern, Download Throughput" title="Comcast across TATA, January 2016 - April 2017, Diurnal Pattern, Download Throughput" src="{{ site.baseurl }}/images/blog/interconnection_update-Comcast-TATA.png" style="cursor:pointer;"></a>
    </td>
    <td><a href="https://viz.measurementlab.net/compare/location?aggr=month&end=2017-06-01&filter1=AS13367x&filter2=AS6453_AS3257_AS174&metric=download&selected=naus&start=2016-01-01"><img alt="Comcast across GTT, January 2016 - April 2017, Diurnal Pattern, Download Throughput" title="Comcast across GTT, January 2016 - April 2017, Diurnal Pattern, Download Throughput" src="{{ site.baseurl }}/images/blog/interconnection_update-Comcast-GTT.png"></a>
    </td>
  </tr>
  <tr>
    <td colspan="3" style="font-style: italic;">Comcast across Tata and GTT (respectively), January 2016 - April 2017, Diurnal Pattern, Download Throughput - <a href="https://viz.measurementlab.net/compare/location?aggr=month&end=2017-06-01&filter1=AS13367x&filter2=AS6453_AS3257_AS174&metric=download&selected=naus&start=2016-01-01">Source</a>
    </td>
  </tr>
</table>

<table style="width: 100%;">
  <tr>
    <td><a href="https://viz.measurementlab.net/compare/location?end=2016-01-01&filter1=AS11486x&filter2=AS10753x&selected=naus&start=2015-01-01"><img alt="Verizon across Level 3, January 2014 - December 2014, Diurnal Pattern, Download Throughput" title="Verizon across Level 3, January 2014 - December 2014, Diurnal Pattern, Download Throughput" src="{{ site.baseurl }}/images/blog/interconnection_update-Verizon_Level3-1.png"></a>
    </td>
    <td><a href="https://viz.measurementlab.net/compare/location?end=2016-01-01&filter1=AS11486x&filter2=AS10753x&selected=naus&start=2015-01-01"><img alt="Verizon across Level 3, January 2015 - December 2015, Diurnal Pattern, Download Throughput" title="Verizon across Level 3, January 2015 - December 2015, Diurnal Pattern, Download Throughput" src="{{ site.baseurl }}/images/blog/interconnection_update-Verizon_Level3-2.png"></a>
    </td>
  </tr>
  <tr>
    <td style="font-style: italic;">Verizon across Level 3, January 2014 - December 2014, Diurnal Pattern, Download Throughput - <a href="https://viz.measurementlab.net/compare/location?end=2016-01-01&filter1=AS11486x&filter2=AS10753x&selected=naus&start=2015-01-01">Source</a>
    </td>
    <td style="font-style: italic;">Verizon across Level 3, January 2015 - December 2015, Diurnal Pattern, Download Throughput - <a href="https://viz.measurementlab.net/compare/location?end=2016-01-01&filter1=AS11486x&filter2=AS10753x&selected=naus&start=2015-01-01">Source</a>
    </td>
  </tr>
</table>

Overall, the M-Lab data shows a decline in the instances of interconnection-related underperformance and evidence of the remediation of previous congestion episodes. The improvement contrasts substantially with the situation described in previous interconnection research, where multiple access ISPs and transit ISPs showed sustained underperformance between each others’ networks.

In several of the episodes covered by M-Lab’s research, the parties involved later published press releases announcing upgrades to interconnection capacity, which would have potentially addressed congestion due to under-provisioned capacity. The disclosures provide a point of comparison that was not previously available. In all cases, these announced upgrades result in demonstrable change in performance, alleviating previous issues. For example, in April 2015, Verizon and Level 3 [announced](http://www.verizon.com/about/news/level-3-and-verizon-enter-interconnection-agreement) a “long-term, bilateral interconnection agreement related to their public IP networks.” Verizon and Level 3 were identified in the original Interconnection Study as having a diurnal performance variation during 2014 that resulted in a more than 50% decrease in median download throughput during peak hours. This underperformance changed within months of the announcement of the agreement, and performance between Verizon and Level 3 continues to improve since.

<table style="width: 100%;">
  <tr>
    <td><a href="https://viz.measurementlab.net/compare/location?aggr=month&breakdownBy=filter1&end=2016-01-01&filter1=AS10774x&filter2=AS3257&metric=download&selected=naus&start=2015-01-01"><img alt="AT&T across GTT, January 2015 - January 2016, Download Throughput" title="AT&T across GTT, January 2015 - January 2016, Download Throughput" src="{{ site.baseurl }}/images/blog/interconnection_update-ATT_GTT.png"></a>
    </td>
  </tr>
  <tr>
    <td style="font-style: italic;">AT&T across GTT, January 2015 - January 2016, Download Throughput - <a href="https://viz.measurementlab.net/compare/location?aggr=month&breakdownBy=filter1&end=2016-01-01&filter1=AS10774x&filter2=AS3257&metric=download&selected=naus&start=2015-01-01">Source</a>
    </td>
  </tr>
</table>

This is a repeated and common pattern for other access and transit ISPs over the latter half of 2015: the improvement of quality of service for customers of access ISPs that M-Lab had identified in potential congestion episodes in 2013-2014. In another example, in June 2015, GTT and AT&T [announced a bilateral agreement](http://about.att.com/newsroom/level_3_and_att_enter_into_interconnection_agreement.html) to provide their clients with additional capacity. Both networks were identified in a blogpost published by M-Lab that found that peak hour performance was frequently less than 0.1 Mbps. As with other cases, alternative access ISPs and transit ISPs did not display as substantial degradation to those same sites during the same period. The announcement of added capacity is followed shortly by a dramatic improvement in performance between the two providers, leading to an increase in the median throughput result from 1.6 Mbps for July to 5.1 Mbps in the following month. The improvement is sustained to present day, and performance has continued to improve overall. Over the following months, nearly all congestion issues identified within M-Lab’s research on interconnection showed demonstrable improvements.

## Conclusion

A review of the M-Lab performance measurement dataset based on the parties and patterns identified in the Interconnection Study has shown that the widespread degradation experienced by American broadband users in 2013-2014 has not recurred since the Open Internet Order was enacted. In several relationships where M-Lab had previously identified underperformance, press releases announcing upgrades to the interconnection between ISPs provided additional indication of changes in the relationship between networks and support our analysis of the dataset. These press releases were followed within days by substantial improvements to the performance of broadband consumers. No similar degradation has occurred between the affected providers since, and few further degradations episodes have arisen since the Open Internet Order.

The Interconnection Study, and subsequent research, affirms that network management practices and congestion associated with interconnection relationships can be independently measured by an objective third party. Our research has demonstrated that interconnection congestion can have a sustained, deleterious impact on consumers. These incidents were not one-off events, and their resolution often appeared quickly when additional capacity was added to the interconnection points. Through Measurement Lab, and other open performance measurement efforts, the Commission has the tools available to conduct continuous, independent assessment of interconnection health with objective methodologies and tested platforms. We believe that only through the transparency provided by open measurement will the Commission achieve its objectives to promote greater access for all Americans, and will continue to provide data on our findings as it considers interconnection and the development of broadband in the United States.
