---
layout: page
permalink: /visualizations/
title: "Visualizations"
page-title: "Performance"
menu-item: true
breadcrumb: visualizations
---

# Visualizations of Network Performance

M-Lab's **open measurement data** means that developers and researchers don’t have to ask permission to use the data before doing meaningful analysis. Some of the ways in which smart people have turned open data into powerful visualizations follow.

## Broadband Performance Statistics Using NDT Data

The charts graphics presented in this section visualize data collected by the Network Diagnostic Tool ([NDT]({{ site.baseurl }}/tools/ndt)). Of the many measurements collected by NDT, these particular visualizations show  **download throughput**, **upload throughput**, **round- trip time**, and **packet retransmission**.

The measurements are aggregated by:

* **Geography** (country > region > city)
* **Internet Service Provider** (ISP)
* **Vantage point** (i.e., M-Lab site)

These visualizations can show one or more metrics at different levels of aggregation at the same time. A few examples of how metrics and aggregation criteria can be combined to provide interesting visualizations are provided in the following pages. If you're interested, you can find a detailed description of how the aggregated statistics are computed at [https://github.com/m-lab/mlab-wikis/blob/master/PDEChartsNDT.md](https://github.com/m-lab/mlab-wikis/blob/master/PDEChartsNDT.md).

## Global Map of Median Download Throughput

Each bubble on the map that follows corresponds to a country. When your mouse is placed over a bubble, the name of the corresponding country is displayed. The color of any bubble represents the median download throughput of a country, while the size of the bubble is proportional to the number of tests run in that country.

<p><iframe class="customIframe" style="font-size: 11px; line-height: 24px;" src="https://www.google.com/publicdata/embed?ds=e9krd11m38onf_&amp;ctype=m&amp;strail=false&amp;bcs=d&amp;nselm=s&amp;met_s=number_of_tests&amp;scale_s=lin&amp;ind_s=false&amp;met_c=download_throughput&amp;scale_c=lin&amp;ind_c=false&amp;ifdim=country&amp;hl=en_US&amp;dl=en_US&amp;ind=false&amp;xMax=180&amp;xMin=-180&amp;yMax=-79.97571094413946&amp;yMin=84.17339026552769&amp;mapType=t&amp;icfg&amp;iconSize=0.5" name="customIframe_0" width="960" height="500" frameborder="0" marginwidth="960" marginheight="500"></iframe></p>

## Timeline of Median Download Throughput of Arbitrarily Selected Countries and Cities

Each line in the chart that follows represents the median download throughput of a country over time.

<p><iframe class="customIframe" src="https://www.google.com/publicdata/embed?ds=e9krd11m38onf_&amp;ctype=l&amp;strail=false&amp;bcs=d&amp;nselm=h&amp;met_y=download_throughput&amp;scale_y=lin&amp;ind_y=false&amp;rdim=country&amp;idim=country:40:208:250:276&amp;idim=city:36_nsw_sydney&amp;idim=region:840_ca:840_ny&amp;ifdim=country&amp;hl=en_US&amp;dl=en_US&amp;ind=false&amp;icfg" name="customIframe_2" width="960" height="500" frameborder="0" marginwidth="960" marginheight="500"></iframe></p>

## Bar Chart of Median Download Throughput of Countries Worldwide

Each bar in the chart that follows corresponds to a country. When your mouse is placed over any bar, the chart displays the name of the corresponding country. The height of each bar represents the median download throughput of a country, while the color of the bar represents the number of tests run in that country.

<p><iframe class="customIframe" src="https://www.google.com/publicdata/embed?ds=e9krd11m38onf_&amp;ctype=c&amp;strail=false&amp;bcs=d&amp;nselm=s&amp;met_y=download_throughput&amp;scale_y=lin&amp;ind_y=false&amp;idim=country:36:40:208:203:250:276:300:56&amp;ifdim=country&amp;hl=en_US&amp;dl=en_US&amp;ind=false&amp;icfg" name="customIframe_4" width="960" height="500" frameborder="0" marginwidth="960" marginheight="500"></iframe></p>

## Packet Retransmission vs. Download Throughput for ISPs in the United States

In the following chart, each bubble corresponds to an ISP. When your mouse is placed over a bar, the name of the corresponding ISP is shown. The size of any bubble is proportional to the number of tests run from connections within the ISP's networks, while the color of the bubble represents the round-trip time measurement of that ISP.

<p><iframe class="customIframe" src="https://www.google.com/publicdata/embed?ds=e9krd11m38onf_&amp;ctype=b&amp;strail=false&amp;bcs=d&amp;nselm=s&amp;met_s=number_of_tests&amp;scale_s=lin&amp;ind_s=false&amp;met_y=download_throughput&amp;scale_y=log&amp;ind_y=false&amp;met_x=segretrans_datasegsout&amp;scale_x=log&amp;ind_x=false&amp;met_c=rtt&amp;scale_c=lin&amp;ind_c=false&amp;ifdim=country_isp:country:840&amp;hl=en_US&amp;dl=en_US&amp;ind=false&amp;icfg&amp;iconSize=0.5" name="customIframe_5" width="960" height="500" frameborder="0" marginwidth="960" marginheight="500"></iframe></p>

## Network- vs. Client-limited Tests

Each bubble in the chart that follows corresponds to a country. When your mouse is placed over a bubble, the name of the corresponding country is displayed. The color of any bubble represents the median download throughput of a country, while the size of the bubble is proportional to the number of tests run in that country. Consider the top left corner of the chart. Note that bubbles in the top left corner correspond to countries where throughput is mostly limited by network congestion, while bubbles at the bottom right correspond to countries where throughput is mostly limited by the user's device.

<p><iframe class="customIframe" src="https://www.google.com/publicdata/embed?ds=e9krd11m38onf_&amp;ctype=b&amp;strail=false&amp;bcs=d&amp;nselm=s&amp;met_s=number_of_tests&amp;scale_s=lin&amp;ind_s=false&amp;met_c=download_throughput&amp;scale_c=lin&amp;ind_c=false&amp;met_y=network_limited&amp;scale_y=lin&amp;ind_y=false&amp;met_x=receiver_limited&amp;scale_x=lin&amp;ind_x=false&amp;ifdim=country&amp;hl=en_US&amp;dl=en_US&amp;ind=false&amp;icfg&amp;iconSize=0.5" name="customIframe_6" width="960" height="500" frameborder="0" marginwidth="960" marginheight="500"></iframe></p>

## Packet Loss Video Using NDT Data

The following image is taken from an animation that shows each NDT test run between February 2009 and November 2012 as a small dot. For more information about how the chart was created, see [http://dominichamon.com/blog/2012/12/visualizing-m-lab-data-with-bigquery-part-two/](http://dominichamon.com/blog/2012/12/visualizing-m-lab-data-with-bigquery-part-two/).

<p><iframe class="customIframe" src="https://docs.google.com/file/d/0B0dPEIVgbGveU1JjcnU3LXNNYXM/preview" name="customIframe_0" width="800" height="400" frameborder="0" marginwidth="800" marginheight="400"></iframe></p>