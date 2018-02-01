#!/usr/bin/env bash

erraform destroy -force resources

echo
echo "Run this command to clear your shell environment variables:"
echo
echo "   unset TF_VAR_username TF_VAR_password TF_VAR_gcp_project_id GCR_KEY"
echo
