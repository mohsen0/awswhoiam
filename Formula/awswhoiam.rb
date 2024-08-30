class Awswhoiam < Formula
  desc "A CLI tool to get AWS STS caller identity"
  homepage "https://github.com/mohsen0/awswhoiam"
  license "Apache License"
  version "0.3.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mohsen0/awswhoiam/releases/download/v#{version}/awswhoiam_darwin_arm64"
      sha256 "c21ce231d87cff6ae7446286e1e94ca19b791ab06423f18f4c918998224912ba"
      def install
        bin.install "awswhoiam_darwin_arm64" => "awswhoiam"
      end
    else
      url "https://github.com/mohsen0/awswhoiam/releases/download/v#{version}/awswhoiam_darwin_amd64"
      sha256 "579ba00f3c5dc952141981509afbbdbe348f5441cbe41d5e1298795ed94436b7"
      def install
        bin.install "awswhoiam_darwin_amd64" => "awswhoiam"
      end
    end
  end

  on_linux do
    url "https://github.com/mohsen0/awswhoiam/releases/download/v#{version}/awswhoiam_linux_amd64"
    sha256 "7e59036a86c7b4f014ab396e81e39d46c1442b3ac66e8562def24eade8f0d6f9"
    def install
      bin.install "awswhoiam_linux_amd64" => "awswhoiam"
    end
  end

  test do
    assert_match "AWS STS GetCallerIdentity Tool", shell_output("#{bin}/awswhoiam --version")
  end
end
