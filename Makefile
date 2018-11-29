GITBOOK=$(CURDIR)/notes
DOCS=$(CURDIR)/docs

.PHONY: build
build: $(GITBOOK)
	gitbook build $(GITBOOK) $(DOCS)

