# `awswhoiam`

`awswhoiam` is a command-line tool designed to fetch AWS STS caller identity information. It’s particularly useful for debugging when you encounter difficulties installing `awscli`.

## Installation

### Using Homebrew (macOS)

You can easily install `awswhoiam` with Homebrew by following these steps:

```sh
brew tap mohsen0/awswhoiam https://github.com/mohsen0/awswhoiam.git
brew install awswhoiam
```

### Using Curl

For other environments, you can download the binary directly using curl. Replace 0.3.1 with the desired version if needed.

```sh
VERSION=0.3.1
curl -o ./awswhoiam -L "https://github.com/mohsen0/awswhoiam/releases/download/v${VERSION}/awswhoiam_linux_amd64"
chmod +x ./awswhoiam
./awswhoiam
{
    "UserId": "REDACTEDY471234567890:botocore-session-1632772568",
    "Account": "012345678912",
    "Arn": "arn:aws:sts::012345678912:assumed-role/your-iam-role/botocore-session-1632772568"
}
```

After downloading, make sure to set the executable permission on the binary.

### Usage

Once installed, you can run awswhoiam from your command line to get information about your AWS STS caller identity.

```sh
$ awswhoiam -h
Usage of awswhoiam:
  -o string
     Specify the output format: json or table (short flag) (default "json")
  -output string
     Specify the output format: json or table (default "json")
  -v Show the version of the program (short flag)
  -version
     Show the version of the program
```
