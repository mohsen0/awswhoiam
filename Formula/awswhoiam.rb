class AwsWhoIAm < Formula
  desc "A CLI tool to get AWS STS caller identity"
  homepage "https://github.com/mohsen0/awswhoiam"
  license "Apache License"
  version "0.1.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mohsen0/awswhoiam/releases/download/v#{version}/awswhoiam_darwin_arm64"
      sha256 "fdc96c0c57d4fb7bdac0c47956487f493b54f2867cf2ec79eafed7f6de090154"
      def install
        bin.install "awswhoiam_darwin_arm64" => "awswhoiam"
      end
    else
      url "https://github.com/mohsen0/awswhoiam/releases/download/v#{version}/awswhoiam_darwin_amd64"
      sha256 "29ff834dd18030774096f930e9a80799d4000f164cadb891f08145a412c6799c"
      def install
        bin.install "awswhoiam_darwin_amd64" => "awswhoiam"
      end
    end
  end

  on_linux do
    url "https://github.com/mohsen0/awswhoiam/releases/download/v#{version}/awswhoiam_linux_amd64"
    sha256 "fa048484b4649524a2bacf8e8551f1994790b60352ba8c15cb059502ac86d97a"
    def install
      bin.install "awswhoiam_linux_amd64" => "awswhoiam"
    end
  end

  test do
    assert_match "AWS STS GetCallerIdentity Tool", shell_output("#{bin}/awswhoiam --version")
  end
end
