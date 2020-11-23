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
The specification allows for a no-code implementation as a collection of files served statically. This is the easiest way to start experimenting with the GA4GH Search API. 

A concrete, example test implementation is [available](https://storage.googleapis.com/ga4gh-tables-example/tables) (list endpoint) with [documentation](https://storage.googleapis.com/ga4gh-tables-example/EXAMPLE.md).

{divider}
{{<code/float-window>}}
{{%content-textbox%}}
Here's what you'll need to have to get started with a codeless implementation.
- ```tables```: served in response to ```GET /tables```
- ```table/{table_name}/info```: served in response to ```GET /table/{table_name}/info```.  e.g. a table with the name ```mytable``` should have a corresponding file ```table/mytable/info```
- ```table/{table_name}/data```: served in response to ```GET /table/{table_name}/data```.  e.g. a table with the name ```mytable``` should have a corresponding file ```table/mytable/data```
- ```table/{table_name}/data_{pageNumber}```, which will be linked in the next_page_url of the first table  (e.g. ```mytable```).
- ```table/{table_name}/data_models/{schemaFile}```: Though not required, data models may be linked via [$ref](https://json-schema.org/latest/json-schema-core.html#rfc.section.8.3). Data models can also be stored as static JSON documents, and be referred to by relative or absolute URLs.
{{%/content-textbox%}}
{{</code/float-window>}}
