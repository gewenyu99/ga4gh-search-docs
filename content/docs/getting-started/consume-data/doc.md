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
#### Content structure

Clyde focuses on good, readable, responsive documentation. It's side bar indexes in only 2 levels. It's opinionated, because deeply nested manuals are hard to follow and takes much too long to navigate.

{divider}
{{<code/float-window>}}
{{< tabs tabTotal="3" tabID="1" tabName1="Files">}}
{{% tab tabNum="1" %}}
``` yaml
├── content
│   ├── category folder
│   │   ├── sub-category folder
│   │   │   └──_index.md
│   │   └── _index.md
│   ├── another category 
|
```
{{% /tab %}}
{{< /tabs >}}
{{</code/float-window>}}
**The code snippet is pulled from this page**

{row-divider}

#### Sidebar category indexing

Clyde indexes the first level of the sidebar manu by looking for `type: product`.

By default, we use feather icons, and the icon renders as specified by `icon: "icon-layers"`

The example provided is consistent with this example project.

{divider}
{{<code/float-window>}}
{{< tabs tabTotal="3" tabID="1" tabName1="Meta">}}
{{% tab tabNum="1" %}}
``` yaml
---
title: "Getting Started"
icon: "icon-layers"
type : "product"
---
```
{{% /tab %}}
{{< /tabs >}}
{{</code/float-window>}}
**The code snippet is pulled from this page**

{row-divider}

#### Sidebar sub-category indexing

Clyde indexes the second level of the sidebar manu by looking for `type: docs`.

The `layout: two-col` specifies the layout of the document. 

There is also the `layout: single-col` for a single column layout.

The ordering of the menu items can be found from `weight: 1`

{divider}
{{<code/float-window>}}
{{< tabs tabTotal="3" tabID="1" tabName1="Meta">}}
{{% tab tabNum="1" %}}
``` yaml
---
title: "Directory Structure"
weight: 1
draft: false
lastmod: 2020-11-5
# search related keywords
type: docs
layout: two-col
---
```
{{% /tab %}}
{{< /tabs >}}
{{</code/float-window>}}
**The code snippet is pulled from this page**
