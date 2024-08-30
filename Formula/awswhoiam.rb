class Awswhoiam < Formula
  desc "A CLI tool to get AWS STS caller identity"
  homepage "https://github.com/mohsen0/awswhoiam"
  license "Apache License"
  version "0.3.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/mohsen0/awswhoiam/releases/download/v#{version}/awswhoiam_darwin_arm64"
      sha256 "668c374937623ea41d9ab928bc2e6dc94ee2247854b92f8262829d0adcc1c256"
      def install
        bin.install "awswhoiam_darwin_arm64" => "awswhoiam"
      end
    else
      url "https://github.com/mohsen0/awswhoiam/releases/download/v#{version}/awswhoiam_darwin_amd64"
      sha256 "bea8d9127a0ed293da5035810ac4befa1aea28de21a34c3c646fdd1964d7db09"
      def install
        bin.install "awswhoiam_darwin_amd64" => "awswhoiam"
      end
    end
  end

  on_linux do
    url "https://github.com/mohsen0/awswhoiam/releases/download/v#{version}/awswhoiam_linux_amd64"
    sha256 "9106764aef1d769433495a83f52ba029e5a443f78e94fdb08037c568fc1485ff"
    def install
      bin.install "awswhoiam_linux_amd64" => "awswhoiam"
    end
  end

  test do
    assert_match "AWS STS GetCallerIdentity Tool", shell_output("#{bin}/awswhoiam --version")
  end
end
