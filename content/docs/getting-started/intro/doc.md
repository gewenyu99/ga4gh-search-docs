---
title: "Introduction"
weight: 1
draft: false
lastmod: 2020-11-5
# search related keywords
type: docs
layout: two-col
---
{row-divider}
### The GA4GH Search API
The GA4GH Search API specification describes a simple, uniform mechanism to publish, discover, query, and analyze biomedical data. Any “rectangular” data that fits into rows and columns can be represented by GA4GH Search. 

#### Search API for data custodians
Search API is a perfect solution for data custodians looking to make their biomedical data discoverable and searchable. 
- The API is minimalistic by design, which also means minimal resistance to adopt.
- Does not prescribe a particular data model. If it fits into rows and columns, you can publish it.
- Search serves as a general-purpose framework for building federatable search-based applications across multiple implementations.
- Search is backend agnostic. It is possible to implement the API across a large variety of backend datastores.

#### Search API for data consumers
Search API is a perfect solution for data consumers looking to discover and search biomedical data in an interoperable way.
- Search API is RESTful. Read our Open API 3 specification.
- Search API is discoverable and browsable. [See supported table operations](https://github.com/ga4gh-discovery/ga4gh-search/blob/develop/SEARCHSPEC.md#discovery-and-browsing)
- Search API is queryable and familiar. Search API's SQL dialect has a famililar interface insipired by current major open source database platforms.

{divider}
{{<code/float-window>}}
{{%content-textbox%}}
##### Quick Links
---
[Full API Specifications](/api)

[Installing Client Libraries](#installing-client-libraries)

[Placeholder for custodian examples](https://github.com/ga4gh-discovery/ga4gh-search)

[Data Consumption Examples](https://github.com/ga4gh-discovery/ga4gh-search)
{{%/content-textbox%}}
{{</code/float-window>}}

{row-divider}
### Installing Client Libraries
Search has client libraries for R and Python, as well as a command line interaface. We'll be using these client libraries in the following examples.
{divider}
{{<code/float-window>}}
{{< tabs tabTotal="3" tabID="1" tabName1="Python" tabName2="R" tabName3="CLI">}}
{{% tab tabNum="1" %}}
```bash
# Installing the client library form PyPi
pip install search-python-client
# Installing from Github
pip install git+https://github.com/DNAstack/search-python-client --no-cache-dir
```
{{% /tab %}}

{{% tab tabNum="2" %}}
```R
# Setup devtools
dir.create(path = Sys.getenv("R_LIBS_USER"), showWarnings = FALSE, recursive = TRUE)
install.packages("devtools", lib = Sys.getenv("R_LIBS_USER"), repos = "https://cran.rstudio.com/")
# installing the R client
devtools::install_github("DNAstack/ga4gh-search-client-r")
```
{{% /tab %}}

{{% tab tabNum="3" %}}
Download [tables-api-cli-executable.jar](). Make it executable (e.g.
`chmod +x tables-api-cli-executable.jar`)

Optionally create an executable `tables` script, with contents like this:

```bash
#!/bin/bash
/path/to/tables-api-cli-executable.jar $@
```
{{% /tab %}}
{{< /tabs >}}
{{</code/float-window>}}