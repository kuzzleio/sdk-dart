const { readFileSync, writeFileSync } = require('fs');
const { resolve } = require('path');
const cheerio = require('cheerio');
const algolia = require('algoliasearch');
const c = require('chalk');

const { findRootNode, getParentNode } = require('./util.js');
const records = [];
const ALGOLIA_MAX_CONTENT_LENGTH = 8500;

module.exports = (options, ctx) => ({
  name: 'index-to-algolia',

  extendPageData($page) {
    const {
      _filePath, // file's absolute path
      _computed, // access the client global computed mixins at build time, e.g _computed.$localePath.
      _content, // file's raw content string
      _strippedContent, // file's content string without frontmatter
      key, // page's unique hash key
      frontmatter, // page's frontmatter object
      regularPath, // current page's default link (follow the file hierarchy)
      path: pagePath // current page's real link (use regularPath when permalink does not exist)
    } = $page;

    if (frontmatter.type !== 'page') {
      return;
    }

    const rootNode = findRootNode($page, ctx.pages);
    const parentNode = getParentNode($page, ctx.pages);
    records.push({
      objectID: key,
      title: frontmatter.title,
      description: frontmatter.description ? frontmatter.description : '',
      path: pagePath,
      basePath: ctx.base,
      breadcrumbs: computeBreadcrumbs(options.repoName, pagePath),
      _tags: [options.repoName],
      root: rootNode ? rootNode.title : '',
      parent: parentNode ? parentNode.title : '',
    });
  },

  ready() { },

  async generated(pagePaths) {
    enrichRecordsWithContent(records, ctx.outDir, true);
    await pushRecords(records, {
      appId: options.algoliaAppId,
      writeKey: options.algoliaWriteKey,
      index: options.algoliaIndex,
      clearIndex: options.clearIndex,
      repoName: options.repoName
    });
  }
});

function enrichRecordsWithContent(records, outDir, dump = false) {
  console.log(`${c.blue('Algolia')} Enriching ${records.length} records...`);
  records.forEach(record => {
    const generatedFilePath = resolve(
      outDir,
      record.path.replace(/^\//, ''), // Strip first slash so that this path is not considered as absolute
      'index.html'
    );
    const fileContent = readFileSync(generatedFilePath).toString();
    const $ = cheerio.load(fileContent, {
      normalizeWhitespace: true
    });
    const content = $('.md-content');

    // remove useless content
    $('h1, pre, .md-clipboard__message', content).remove();

    record.content = content.text();
    // TODO - should rather chunk the page into headers and create a record per header
    record.content = record.content.substring(0, ALGOLIA_MAX_CONTENT_LENGTH)
  });

  if (dump) {
    writeFileSync('./algolia-records.json', JSON.stringify(records, null, 4));
  }
}

async function pushRecords(records, algoliaOptions) {
  if (!algoliaOptions.writeKey) {
    throw new Error('Please provide a valid Algolia Write Key');
  }

  console.log(`\n${c.blue('Algolia')} Pushing ${records.length} records...`);

  const client = algolia(algoliaOptions.appId, algoliaOptions.writeKey);
  const index = client.initIndex(algoliaOptions.index);

  if (algoliaOptions.clearIndex) {
    console.log(`${c.blue('Algolia')} clearing the index...`);
    await index.clearIndex()
  }

  if (algoliaOptions.repoName) {
    console.log(`${c.blue('Algolia')} clearing records for ${algoliaOptions.repoName}`)
    index.deleteBy({ filters: `_tags:${algoliaOptions.repoName}` })
  }

  index.addObjects(records, (err, content) => {
    if (err) {
      return console.error(err);
    }
    console.log(`${c.blue('Algolia')} Successfully pushed records for ${algoliaOptions.repoName}!`);
  });
}

function computeBreadcrumbs(repoName, path) {
  const pathTags = path
    .split('/')
    .filter(t => t !== '')
    .slice(0, 4)
    .map(tag => {
      if (tag === 'sdk-reference') {
        return 'sdk';
      }
      if (/^[0-9]+$/.test(tag)) {
        return `${tag}.x`;
      }
      return tag;
    });

  if (repoName) {
    return [
      repoName,
      ...pathTags
    ]
  }

  return pathTags
}
