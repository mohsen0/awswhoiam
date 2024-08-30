package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"os"
	"text/tabwriter"

	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/sts"
)

// Define the version of the program
const version = "0.2.1"

func main() {
	// Define the output and version flags
	output := flag.String("output", "json", "Specify the output format: json or table")
	flag.StringVar(output, "o", "json", "Specify the output format: json or table (short flag)")
	showVersion := flag.Bool("version", false, "Show the version of the program")
	flag.BoolVar(showVersion, "v", false, "Show the version of the program (short flag)")
	flag.Parse()

	// Handle the version flag
	if *showVersion {
		fmt.Println("AWS STS GetCallerIdentity Tool, version", version)
		return
	}

	// Create a new session
	sess := session.Must(session.NewSession())

	// Create a new STS client
	svc := sts.New(sess)

	// Call GetCallerIdentity API
	result, err := svc.GetCallerIdentity(&sts.GetCallerIdentityInput{})
	if err != nil {
		fmt.Println("Error", err)
		os.Exit(1)
	}

	// Output in the requested format
	switch *output {
	case "json":
		printJSON(result)
	case "table":
		printHorizontalTable(result)
	default:
		fmt.Println("Invalid output format. Use 'json' or 'table'.")
		os.Exit(1)
	}
}

// printJSON outputs the result in JSON format
func printJSON(result *sts.GetCallerIdentityOutput) {
	jsonOutput, err := json.MarshalIndent(result, "", "  ")
	if err != nil {
		fmt.Println("Error formatting JSON", err)
		os.Exit(1)
	}
	fmt.Println(string(jsonOutput))
}

// printHorizontalTable outputs the result in a horizontal table format with -- as borders
func printHorizontalTable(result *sts.GetCallerIdentityOutput) {
	writer := tabwriter.NewWriter(os.Stdout, 0, 0, 2, ' ', 0)
	fmt.Fprintln(writer, "Field\tValue")
	fmt.Fprintln(writer, "----------------------------------------")
	fmt.Fprintf(writer, "UserId\t%s\n", *result.UserId)
	fmt.Fprintln(writer, "----------------------------------------")
	fmt.Fprintf(writer, "Account\t%s\n", *result.Account)
	fmt.Fprintln(writer, "----------------------------------------")
	fmt.Fprintf(writer, "Arn\t%s\n", *result.Arn)
	fmt.Fprintln(writer, "----------------------------------------")
	writer.Flush()
}
