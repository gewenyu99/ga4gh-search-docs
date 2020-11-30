run: build_api_docs
	cp -r ga4gh-search/docs content/api
	hugo serve -D

build_search_docs: build_api_docs
	rm -r ./docs/
	cp -r ./ga4gh-search/docs content/api
	hugo --minify

build_api_docs:
	cd ga4gh-search && npm install -g @redocly/openapi-cli && npm install -g redoc-cli && \
		npm install -g gh-openapi-docs &&\
		npm install -g @redocly/openapi-cli && npm install -g redoc-cli &&\
		gh-openapi-docs

	
