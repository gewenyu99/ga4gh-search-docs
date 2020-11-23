---
title: "At the data source"
weight: 1
draft: false
lastmod: 2020-11-5
# search related keywords
type: docs
layout: single-col
---
#### Securing the Search data sources
Search is backend agnostic by design, this means we do not suggest a specific implementation as correct. In this page, we will attempt to bring up some options for you to consider.

##### Using access controls of the data source
Whether you're data is stored in a database like MySQL and PostgreSQL, or in hosted solutions like Google Cloud Storage, the solution will likely offer some form of access control. The access control can be broad or fine grained extending to table/column/row level security. This is where your implementation will check the requesting user’s identity from their GA4GH Passport. 

[Click me if you're not familiar with GA4GH Passports and Visas](https://github.com/ga4gh-duri/ga4gh-duri.github.io/tree/master/researcher_ids)


##### Using Presto’s system access control
If your implementation uses Presto, you can use Preso's [system access control](https://prestodb.io/docs/current/security/built-in-system-access-control.html) to secure your data source.

##### Make a copy of your data
If you plan to share a select set of data, you can also considering making a copy of all the shared data in a different database/storage instance. If the plan is to share a certain dataset publically, this is the best option to avoid implementing complicated filters.
