class Awswhoiam < Formula
  desc "A CLI tool to get AWS STS caller identity"
  homepage "https://github.com/mohsen0/awswhoiam"
  license "Apache License"
  version "0.2.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mohsen0/awswhoiam/releases/download/v#{version}/awswhoiam_darwin_arm64"
      sha256 "97efa13e2f919b6ebf4fca8faf364462fa1e9b58a023e2f46a80f51bf85a4fbd"
      def install
        bin.install "awswhoiam_darwin_arm64" => "awswhoiam"
      end
    else
      url "https://github.com/mohsen0/awswhoiam/releases/download/v#{version}/awswhoiam_darwin_amd64"
      sha256 "9df9a11ce3ef09e54588c48361758c7fedb82e1920af007ba7256133dccea783"
      def install
        bin.install "awswhoiam_darwin_amd64" => "awswhoiam"
      end
    end
  end

  on_linux do
    url "https://github.com/mohsen0/awswhoiam/releases/download/v#{version}/awswhoiam_linux_amd64"
    sha256 "a1f7f99c33ad0bff6e7f46e2fefc7e43c6f60f266436ed8feaf123720c421909"
    def install
      bin.install "awswhoiam_linux_amd64" => "awswhoiam"
    end
  end

  test do
    assert_match "AWS STS GetCallerIdentity Tool", shell_output("#{bin}/awswhoiam --version")
  end
end
