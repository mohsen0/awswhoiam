package main

import (
	"testing"

	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/service/sts"
	"github.com/stretchr/testify/assert"
)

// Mock the AWS STS client and responses for testing
func mockGetCallerIdentity() (*sts.GetCallerIdentityOutput, error) {
	return &sts.GetCallerIdentityOutput{
		UserId:  aws.String("test-user-id"),
		Account: aws.String("test-account-id"),
		Arn:     aws.String("arn:aws:iam::test-account-id:user/test-user"),
	}, nil
}

func TestGetCallerIdentity(t *testing.T) {
	result, err := mockGetCallerIdentity()
	assert.NoError(t, err)
	assert.NotNil(t, result)
	assert.Equal(t, "test-user-id", *result.UserId)
	assert.Equal(t, "test-account-id", *result.Account)
	assert.Equal(t, "arn:aws:iam::test-account-id:user/test-user", *result.Arn)
}

func TestHandleOutput(t *testing.T) {
	result, _ := mockGetCallerIdentity()

	// Test JSON output
	err := handleOutput(result, "json")
	assert.NoError(t, err)

	// Test table output
	err = handleOutput(result, "table")
	assert.NoError(t, err)

	// Test invalid format
	err = handleOutput(result, "invalid")
	assert.Error(t, err)
}
