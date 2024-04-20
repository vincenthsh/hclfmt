default: build

main.go:
	curl -O https://raw.githubusercontent.com/hashicorp/hcl/hcl2/cmd/hclfmt/main.go
	awk '{gsub(/^const versionStr/,"var versionStr")}1' main.go > temp && mv temp main.go

build: main.go ## Build binary
	go build -o bin/hclfmt

# install goreleaser with
# brew install goreleaser/tap/goreleaser
snapshot: ## Build snapshot using goreleaser (requires goreleaser to be installed)
	goreleaser build --snapshot --clean

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
