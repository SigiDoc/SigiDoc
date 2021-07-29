# SigiDoc_Latest

Latest SigiDoc Source Code AS - MF

# Development

When there are authority lists in your project (stored in /webapps/ROOT/content/xml/authority) you can harvest RDF from them and that will give you the values in your facets and indices pages in EFES.

In order to make use of Kiln’s RDF capabilities, some setup is required. You need to create a repository in the Sesame server.

1. Go to http://127.0.0.1:9999/openrdf-workbench/
2. Click the “New repository” link at
3. Set `Type` to `In Memory Store RDF Schema and Direct Type Hierarchy`.
4. Set `ID` to `kiln`

- Click `Next`
- Click `Create`

5. Go to http://127.0.0.1:9999/admin/

- Click the `Harvest all (RDF)` button
- Click the `Index all (search)`
