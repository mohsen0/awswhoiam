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
	output := flag.String("output", "json", "Specify the output format: json or table")
	flag.StringVar(output, "o", "json", "Specify the output format: json or table (short flag)")
	showVersion := flag.Bool("version", false, "Show the version of the program")
	flag.BoolVar(showVersion, "v", false, "Show the version of the program (short flag)")
	flag.Parse()

	if *showVersion {
		fmt.Println("AWS STS GetCallerIdentity Tool, version", version)
		return
	}

	result, err := getCallerIdentity()
	if err != nil {
		fmt.Println("Error", err)
		os.Exit(1)
	}

	err = handleOutput(result, *output)
	if err != nil {
		fmt.Println("Error", err)
		os.Exit(1)
	}
}

// getCallerIdentity retrieves the caller identity from AWS STS
func getCallerIdentity() (*sts.GetCallerIdentityOutput, error) {
	sess := session.Must(session.NewSession())
	svc := sts.New(sess)
	return svc.GetCallerIdentity(&sts.GetCallerIdentityInput{})
}

// handleOutput handles the result based on the output format
func handleOutput(result *sts.GetCallerIdentityOutput, outputFormat string) error {
	switch outputFormat {
	case "json":
		printJSON(result)
	case "table":
		printHorizontalTable(result)
	default:
		return fmt.Errorf("Invalid output format. Use 'json' or 'table'.")
	}
	return nil
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
