# web annotation curated atomized parsed documentation api cli directory

## Introduction

This is a set of my messages copy & pasted from chat. It was written mostly for myself. Not all of it may make sense to everyone, but do ask if you would like clarification or if you'd like to join the effort. It will be rewritten on a YAGNI basis.

## Notes

We already have lots of existing FOSS guides, some license compatible, some less so. Each individual command may be described by one or more separate documents. How about creating a "shellipedia" entry for each individual command (or option) and just link to the already existing documentation for it so you could read as much information about it as possible. As a wishlist item, we could do weekly hackathons together in choosing a command and fixing up its docs (for example, by unifying & merging multiple descriptions of it to its man page or extending it based on recent code changes)

If you know me, I love offline usable devices, hence why I prefer man pages as a single source of ground truth when possible (i.e., that's installed when you install the command itself), but some tools also install txt, markdown or HTML docs and code snippets inside the package (some PDF, but I view that as less hackable), so I'm flexible in this as long as it supports the DFSG island mode independence that I expect from a truly FOSS system.

We could create a completely new Wikibook for it also (I think many shell-themed wikibooks were already started, but they are still thin). A downloadable kiwix book could then be generated from it. Not sure whether I would like to duplicate or rewrite all docs already available elsewhere, though instead of extending the ones already shipping or linked to by others. We always have to weigh upstreaming our contributions vs. getting the choice of making liberal decisions. I think we could get the best of both worlds if for each command being viewed, the web page dynamically pulled in the existing man page, info, README, academy, TLDP, etc. sources and show them as separate paragraphs on the same page or side by side. And we ourselves would only need to add just a few little notes to the side (i.e., as an additional source) or control which paragraphs should be hidden (collapsed, to be rephrased differently or recombined from the different docs themselves). This would carry the advantage that if any of our sources were updated, the page would always be up to date

We just need to render and index each linked to FOSS source to host it on a CORS aware storage (e.g., gitlab or github Pages), script updates for it and come up with a proper format to diff/match/highlight sentences from different sources (maybe based on the scroll to anchor format, maybe based on `sed`).

If docs are generated, we should implement a parser for their markdown input present in their git repo in such cases usually, although we could actually have a version dropdown to show the difference between the upstream development version and one of the released version (per Linux distribution even).

## Plan

### Map all documentation sources

We have already listed a few of the most important FOSS documentation sources for shell development:

[../README.md](../README.md)

We should enumerate all available sources. Annotate which ones are still maintained and which ones are forks of others.

### Ephemeral storage

Design how to store the incremental "backend" state for the project. It should be possible to completely rebuild it from scratch trivially on any machine, but it should vastly improve efficiency to rerun it with this cache.

### Durable fixup storage

We should store our own annotations at our own place. As little novel text content should be stored here as possible. It should contain metadata about which sentences to highlight or collapse from which source and what order to present them in.

### Scraper

For each FOSS documentation source, we need to implement a scraper. Find an API that can be used to gather all of its content. It should be nice, not overload our upstream and support incremental and automatic updating.

### Parser

Parser for each source. Understand the directory structure. Understand file format. Figure out how sections are split.

Either tear them apart into sections per command, option, docs vs. examples if the source has such granularity. Otherwise automatically annotate with tags, such as when snippets demonstrate usage of multiple commands at once.

### Source mirror

Mirror a serialized (and/or statically rendered) version of each parsed source. Obey all licensing requirements. Give credit and links where credit is due. Allow CORS. Offload upstream.

### Combiner

Design the exact way how to remix the separate sources. This will impact the renderer and the API as well later.

Each resulting subpage (CLI invocation result) should ideally focus on a single use case for a single parameter of a single command within a single package (whichever level we can cut it at).

### Implement static web page

Reassemble the parsed atoms into the individual tiny subpages.

### Design client API

* exact command and parameter lookup
* fuzzy search
* search in description
* curator mode: improve fixup (highlight, collapse, reorder, annotate) or contribute to upstream (many are hosted on a VCS that already supports CORS!)

### Implement CLI client

### Manual curation

After the seed data and all tools are at a usable state, we can start producing value. Value is produced by remixing existing docs in a way that results in the most comprehensive and relevant guide and improving the upstream sources.
