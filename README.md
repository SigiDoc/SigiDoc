# SigiDoc_Latest

Latest SigiDoc Source Code AS - MF

# Development

When there are authority lists in your project (stored in /webapps/ROOT/content/xml/authority) you can harvest RDF from them and that will give you the values in your facets and indices pages in EFES.

In order to make use of Kiln’s RDF capabilities, some setup is required. You need to create a repository in the Sesame server.

- Go to http://127.0.0.1:9999/openrdf-workbench/
- Click the “New repository” link at

  - Set `Type` to `In Memory Store RDF Schema and Direct Type Hierarchy`.
  - Set `ID` to `kiln`
  - Click `Next`
  - Click `Create`

- Go to http://127.0.0.1:9999/admin/

  - Click the `Harvest all (RDF)` button
  - Click the `Index all (search)`

- Go to http://127.0.0.1:9999 and you should see the data in the indecies.
