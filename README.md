# SigiDoc

SigiDoc 1.0 - An XML-based and EpiDoc-compliant encoding standard for the scholarly edition of Byzantine lead seals and coin-like objects. Newest developments in the framework of the DFG-ANR project DigiByzSeal "Unlocking the Hidden Value of Seals: New Methodologies for Historical Research in Byzantine Studies" ANR: https://anr.fr/Project-ANR-21-FRAL-0008; DFG: https://gepris.dfg.de/gepris/projekt/469385434.

# Development

When there are authority lists in your project (stored in /webapps/ROOT/content/xml/authority) you can harvest RDF from them and that will give you the values in your facets and indices pages in EFES.

In order to make use of Kiln’s RDF capabilities, some setup is required. You need to create a repository in the Sesame server.

- Run ./docker.sh then open
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
