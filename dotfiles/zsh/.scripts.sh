#!/bin/bash

function dg() {
	datamodel-codegen --input "$1" --input-file-type "$2" --output "$3"
}
