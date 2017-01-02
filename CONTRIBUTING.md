# Contributing

## Development Process

### Requirements
* [Java](https://java.com/en/download/) version 1.7 or later
* [Ant](http://ant.apache.org/bindownload.cgi) version 1.9 or later
* [Force.com Migration Tool (ant-salesforce.jar)](https://developer.salesforce.com/page/Force.com_Migration_Tool#Force.com_Migration_Tool_Download) Summer 16 or later
* [ApexDoc](https://github.com/SalesforceFoundation/ApexDoc/releases) version 1.1.7 or later

### Preparing a Pull Request
* Update package.xml if new files have been created
* Update build.xml if new test classes have been created
* Verify that all tests pass by running ````ant deployCode````
* Create updated ApexDoc's by running
````java -jar apexDoc.jar -s src/classes -g https://github.com/gsa/sf-sandbox-post-copy/tree/master/src/classes/ -t docs -h docs/homepage.html -a docs/header.html````
  * Once the docs have been created, copy the files from ApexDocumenation/ to docs/ folder. This is a workaround to ensure ApexDocs are served through GitHub Pages, http://gsa.github.io/sf-sandbox-post-copy/

#### Commit Messages
If you are building against an issue which is in our [backlog](https://github.com/GSA/sf-sandbox-post-copy/issues), include the issue number in your commit message. See [#11](https://github.com/GSA/sf-sandbox-post-copy/issues/11) for example commit messages. This allows a potential contributor to quickly identify the source and motivations behind a contribution.

## Public Domain
For detailed information see [LICENSE](LICENSE.md).

All contributions to this project will be released under the CC0 dedication. By submitting a pull request, you are agreeing to comply with this waiver of copyright interest.
