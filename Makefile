# Variables
APP_NAME := awswhoiam
SRC_DIR := .
BUILD_DIR := ./build
PLATFORMS := linux/amd64 windows/amd64 darwin/amd64 darwin/arm64
GO := go
GO_BUILD := $(GO) build
GO_CLEAN := $(GO) clean
GO_TEST := $(GO) test
GO_RUN := $(GO) run

# Build the Go project
.PHONY: build
build: $(PLATFORMS)
	@echo "Build complete for all specified platforms!"
	cd build; sha256sum * > sha256sum.txt

# Cross-compile for different platforms
$(PLATFORMS):
	@echo "Building for $@..."
	GOOS=$(word 1,$(subst /, ,$@)) GOARCH=$(word 2,$(subst /, ,$@)) $(GO_BUILD) -ldflags="-s -w" -o $(BUILD_DIR)/$(APP_NAME)_$(word 1,$(subst /, ,$@))_$(word 2,$(subst /, ,$@)) $(SRC_DIR)/main.go
	@echo "Build complete for $@"

# Run the application (current platform only)
.PHONY: run
run:
	@echo "Running the application..."
	$(GO_RUN) $(SRC_DIR)/main.go

# Test the application (Assumes test files are in the same directory)
.PHONY: test
test:
	@echo "Running tests..."
	$(GO_TEST) -v ./...

# Clean the build directory
.PHONY: clean
clean:
	@echo "Cleaning up..."
	$(GO_CLEAN)
	rm -rf $(BUILD_DIR)
	@echo "Clean complete!"

# Install dependencies
.PHONY: deps
deps:
	@echo "Installing dependencies..."
	$(GO) mod tidy
	@echo "Dependencies installed!"
