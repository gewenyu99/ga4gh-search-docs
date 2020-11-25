---
title: "Provision Data"
weight: 2
draft: false
lastmod: 2020-11-5
# search related keywords
type: docs
layout: two-col
---

{row-divider}
#### Implementation

The GA4GH API requires the [table operations](/api/#tag/tables) to be implemented to specification for basic discovery and browsing. 

Optional but not required, [query operations](/api/#tag/search) may be implemented to support querying with SQL.

The Search API is backend agnostic, which means any solution that implementation the [API Specification](/api) is valid. You can use your favorite REST application frameworks to implement GA4GH Search, or write no code at all with a tables-in-a-bucket implementation.

The following examples will get you started experimenting with search.
{divider}
{{<code/float-window>}}
{{%content-textbox%}}
##### Quick Links
---
[Full API Specifications](/api)

[Placeholder for custodian examples](https://github.com/ga4gh-discovery/ga4gh-search)
{{%/content-textbox%}}
{{</code/float-window>}}
{row-divider}
#### Tables-in-a-bucket example
The specification allows for a no-code implementation as a collection of files served statically. This is the easiest way to start experimenting with the GA4GH Search API. As long as your storage bucket conforms to the correct file structure and it has the correct sharing permissions, it is a valid Search implementation.

A concrete, example implementation is [available](https://storage.googleapis.com/ga4gh-tables-example/tables).

Test the implementation out:
{{< tabs tabTotal="3" tabID="2" tabName1="Python" tabName2="R" tabName3="CLI">}}
{{% tab tabNum="1" %}}
[Follow along in Colab](https://colab.research.google.com/drive/1NytWLzQFWwGc3pqTaL0HD81S5B3zznLj?usp=sharing)
``` python
# init search client
from search_python_client.search import DrsClient, SearchClient
base_url_tiab = 'https://storage.googleapis.com/ga4gh-tables-example/'
search_client_tiab = SearchClient(base_url=base_url_tiab)
# get tables
tables_iterator = search_client_tiab.get_table_list()
tables = [next(tables_iterator, None) for i in range(10)]
tables = list(filter(None, tables))
print(tables)
# get table info
table_name = tables[0]['name']
table_info = search_client_tiab.get_table_info(table_name)
print(table_info)
# get table data
table_name = tables[0]['name']
table_data_iterator = search_client_tiab.get_table_data(table_name)
table_data = [next(table_data_iterator, None) for i in range(10)]
table_data = list(filter(None, table_data))
print(table_data)
```
{{% /tab %}}
{{% tab tabNum="2" %}}
``` 
https://colab.research.google.com/drive/1VOP2IcPjsX4U-DfuiTs7Tr0SVlAD0IMh?usp=sharing <= doesn't work right now.
```
{{% /tab %}}
{{% tab tabNum="3" %}}
``` 
place holder
```
{{% /tab %}}

{{< /tabs >}}


{divider}
{{<code/float-window>}}
{{%content-textbox%}}
Here's how you'll need to organize your folders
- ```tables```: served in response to ```GET /tables```
- ```table/{table_name}/info```: served in response to ```GET /table/{table_name}/info```.  e.g. a table with the name ```mytable``` should have a corresponding file ```table/mytable/info```
- ```table/{table_name}/data```: served in response to ```GET /table/{table_name}/data```.  e.g. a table with the name ```mytable``` should have a corresponding file ```table/mytable/data```
- ```table/{table_name}/data_{pageNumber}```, which will be linked in the next_page_url of the first table  (e.g. ```mytable```).
- ```table/{table_name}/data_models/{schemaFile}```: Though not required, data models may be linked via [$ref](https://json-schema.org/latest/json-schema-core.html#rfc.section.8.3). Data models can also be stored as static JSON documents, and be referred to by relative or absolute URLs.
{{%/content-textbox%}}
{{</code/float-window>}}

{row-divider}
#### Trying out a reference implementation
This example was shown as a demo during the 2020 GA4GH Plenary. This app will run an example Search implementation on docker and use an instance of Presto hosted by DNAstack as the datasource. 

You'll need docker set up on your system to run the Spring app and you'll need to have one of the client libraries installed from the [Introduction Section](/docs/getting-started/).

The Docker commands will download and start a PostgreSQL container and the reference Search implementation. If you would like to experiment with the application futher, you can checkout the source code and configuration options [here](https://github.com/dnastack/ga4gh-search-adapter-presto).
{divider}
{{<code/float-window>}}
{{< tabs tabTotal="1" tabID="2" tabName1="30 second quick start">}}
{{% tab tabNum="1" %}}
``` bash
docker pull postgres:latest
docker run -d --rm --network="host" --name dnastack-ga4gh-search-db -e POSTGRES_USER=ga4ghsearchadapterpresto -e POSTGRES_PASSWORD=ga4ghsearchadapterpresto postgres
docker pull dnastack/ga4gh-search-adapter-presto:latest
docker run --rm --name dnastack-ga4gh-search -p 8089:8089 -e PRESTO_DATASOURCE_URL=https://presto-public.prod.dnastack.com -e SPRING_PROFILES_ACTIVE=no-auth dnastack/ga4gh-search-adapter-presto:latest
```
{{% /tab %}}

{{< /tabs >}}
{{</code/float-window>}}
{{<code/float-window>}}
{{< tabs tabTotal="3" tabID="2" tabName1="Python" tabName2="R" tabName3="CLI">}}
{{% tab tabNum="1" %}}
``` 
place holder
```
{{% /tab %}}
{{% tab tabNum="2" %}}
``` 
place holder
```
{{% /tab %}}
{{% tab tabNum="3" %}}
``` 
place holder
```
{{% /tab %}}

{{< /tabs >}}
{{</code/float-window>}}

