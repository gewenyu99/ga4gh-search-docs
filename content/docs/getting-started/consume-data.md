---
title: "Consume Data"
weight: 3
draft: false
lastmod: 2020-11-5
# search related keywords
type: docs
layout: two-col
description: This section provides information about setting up GA4GH Search API to expose data.
---

{row-divider}
#### Queries

The Search API supports query operation through SQL statements.

The GA4GH Search API's SQL dialect has a familiar interface inspired by current major open source database platforms, including Presto SQL, PostgreSQL, MySQL, and BigQuery. If you have prior experience with these database platforms, you'll feel right at home with only minor adjustments.

[Supported SQL functions](https://github.com/ga4gh-discovery/ga4gh-search/blob/develop/SEARCHSPEC.md#sql-functions)

[Supported SQL grammar](https://github.com/ga4gh-discovery/ga4gh-search/blob/develop/SEARCHSPEC.md#appendix-a-sql-grammar)

{divider}
{{<code/float-window>}}
{{< tabs tabTotal="2" tabID="1" tabName1="Example #1" tabName2="Example #2">}}
{{% tab tabNum="1" %}}
This query returns all female patients from the `patient` table.
``` SQL
/* you can scroll on this tab */
SELECT * 
FROM   kidsfirst.ga4gh_tables.patient 
WHERE  Json_extract_scalar(patient, '$.gender') = 'female' 
LIMIT  5; 
```
{{% /tab %}}

{{% tab tabNum="2" %}}

This query returns all conditions observed in female patients from the `patient` table.
``` SQL
/* you can scroll on this tab */
SELECT Json_extract_scalar(ncpi_disease, '$.code.text')           AS disease, 
       Json_extract_scalar(ncpi_disease, '$.identifier[0].value') AS identifier 
FROM   kidsfirst.ga4gh_tables.ncpi_disease disease 
       INNER JOIN kidsfirst.ga4gh_tables.patient patient 
               ON patient.id = REPLACE(Json_extract_scalar(ncpi_disease, 
                                       '$.subject.reference'), 
                               'Patient/') 
WHERE  Json_extract_scalar(patient, '$.gender') = 'female' 
LIMIT  5; 
```
{{% /tab %}}
{{< /tabs >}}
{{</code/float-window>}}

{row-divider}

#### Issuing queries using the Search API

Search is a standard REST API. This means Search can be accessed through standard HTTP calls.

While Search API can be navigated using programs like cURL or Postman, it is best accessed programmatically. The results could return multiple pages, which is easier to navigate with programmatic access.

Once you've visited a page and consumed data from it, you can't go back to it or refresh.  

On the right, we provide examples to consume data from the Search API using the GA4GH Commandline Interface, the R client, Python, and cURL.

> [Need help installing client libraries?](../../../../docs/getting-started/intro/doc/)

{divider}
{{<code/float-window>}}
{{< tabs tabTotal="4" tabID="2" tabName1="Python" tabName2="R" tabName3="CLI" tabName4="cURL">}}

{{% tab tabNum="1" %}}
[Follow Along in Google Colab](https://colab.research.google.com/drive/1efGB5O68_dtMgyqCeIjLG8ezMzDBBQj9?usp=sharing)
```bash
# Installing the client library form PyPi
pip install search-python-client
# Installing from Github
pip install git+https://github.com/DNAstack/search-python-client --no-cache-dir
```
```python
# Building the query
from search_python_client.search import DrsClient, SearchClient
base_url = 'https://search-presto-public.staging.dnastack.com'
search_client = SearchClient(base_url=base_url)
query = """
SELECT Json_extract_scalar(ncpi_disease, '$.code.text')           AS disease, 
       Json_extract_scalar(ncpi_disease, '$.identifier[0].value') AS identifier 
FROM   kidsfirst.ga4gh_tables.ncpi_disease disease 
       INNER JOIN kidsfirst.ga4gh_tables.patient patient 
               ON patient.id = REPLACE(Json_extract_scalar(ncpi_disease, 
                                       '$.subject.reference'), 
                               'Patient/') 
WHERE  Json_extract_scalar(patient, '$.gender') = 'female' 
LIMIT  5 
"""
```
```python
# Executing the query
table_data_iterator = search_client.search_table(query)
for item in table_data_iterator:
  print(item)
```
```python
# Results
{'disease': 'Aortic atresia', 'identifier': 'Condition|SD_PREASA7S|272|Aortic atresia|None'}
{'disease': 'Mitral atresia', 'identifier': 'Condition|SD_PREASA7S|272|Mitral atresia|None'}
{'disease': 'Hypoplasia ascending aorta', 'identifier': 'Condition|SD_PREASA7S|272|Hypoplasia ascending aorta|None'}
{'disease': 'Hypoplastic left heart syndrome', 'identifier': 'Condition|SD_PREASA7S|272|Hypoplastic left heart syndrome|None'}
{'disease': 'Hypoplastic left ventricle (subnormal cavity volume)', 'identifier': 'Condition|SD_PREASA7S|272|Hypoplastic left ventricle (subnormal cavity volume)|None'}
```
{{% /tab %}}

{{% tab tabNum="2" %}}
[Follow Along in Google Colab](https://colab.research.google.com/drive/1Y6r1772AW-FWZ1OrOutNoDOvca8Osz3z?usp=sharing)
```R
# installing devtools
dir.create(path = Sys.getenv("R_LIBS_USER"), showWarnings = FALSE, recursive = TRUE)
install.packages("devtools", lib = Sys.getenv("R_LIBS_USER"), repos = "https://cran.rstudio.com/")
```
```R
# installing the R client
devtools::install_github("DNAstack/ga4gh-search-client-r")
```
```R
# Making the request
library(httr)
conditionsInFemalePatients <- ga4gh.search::ga4gh_search("https://search-presto-public.staging.dnastack.com", "select json_extract_scalar(ncpi_disease, '$.code.text') as disease, json_extract_scalar(ncpi_disease, '$.identifier[0].value') as identifier from kidsfirst.ga4gh_tables.ncpi_disease disease INNER JOIN kidsfirst.ga4gh_tables.patient patient ON patient.id=replace(json_extract_scalar(ncpi_disease, '$.subject.reference'), 'Patient/') WHERE json_extract_scalar(patient, '$.gender')='female' limit 5")
```
```R
# View the results
print(conditionsInFemalePatients)
```

Output:
``` bash
                                               disease
1                                       Aortic atresia
2                                       Mitral atresia
3                           Hypoplasia ascending aorta
4                      Hypoplastic left heart syndrome
5 Hypoplastic left ventricle (subnormal cavity volume)
                                                                           identifier
1                                       Condition|SD_PREASA7S|272|Aortic atresia|None
2                                       Condition|SD_PREASA7S|272|Mitral atresia|None
3                           Condition|SD_PREASA7S|272|Hypoplasia ascending aorta|None
4                      Condition|SD_PREASA7S|272|Hypoplastic left heart syndrome|None
5 Condition|SD_PREASA7S|272|Hypoplastic left ventricle (subnormal cavity volume)|None
```
{{% /tab %}}


{{% tab tabNum="3" %}}

``` bash
./dnastack-search query -q "select json_extract_scalar(ncpi_disease, '$.code.text') as disease, json_extract_scalar(ncpi_disease, '$.identifier[0].value') as identifier from kidsfirst.ga4gh_tables.ncpi_disease disease INNER JOIN kidsfirst.ga4gh_tables.patient patient ON patient.id=replace(json_extract_scalar(ncpi_disease, '$.subject.reference'), 'Patient/') WHERE json_extract_scalar(patient, '$.gender')='female' limit 5"
```
{{% /tab %}}
{{% tab tabNum="4" %}}
These requests
This query returns all female patients from the `patient` table.
``` bash
curl --request POST \
  --url https://search-presto-public.staging.dnastack.com/search \
  --header 'content-type: application/json' \
  --data '{ "query": "select * from kidsfirst.ga4gh_tables.patient WHERE json_extract_scalar(patient, '\''$.gender'\'')='\''female'\'' limit 5"}'
```

This query returns all conditions observed in female patients from the `patient` table.
``` bash
curl --request POST \
  --url https://search-presto-public.staging.dnastack.com/search \
  --header 'content-type: application/json' \
  --data '{ "query": "select json_extract_scalar(ncpi_disease, '\''$.code.text'\'') as disease, json_extract_scalar(ncpi_disease, '\''$.identifier[0].value'\'') as identifier from kidsfirst.ga4gh_tables.ncpi_disease disease INNER JOIN kidsfirst.ga4gh_tables.patient patient ON patient.id=replace(json_extract_scalar(ncpi_disease, '\''$.subject.reference'\''), '\''Patient/'\'') WHERE json_extract_scalar(patient, '\''$.gender'\'')='\''female'\'' limit 5"}'
```
{{% /tab %}}
{{< /tabs >}}
{{</code/float-window>}}



