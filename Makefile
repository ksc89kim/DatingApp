features:
	swift Scripts/MakeFeatures/GenerateFeatures.swift

generate-preview:
	TUIST_ROOT_DIR=${PWD} TUIST_FOR_PREVIEW=TRUE tuist generate

generate:
	TUIST_ROOT_DIR=${PWD} tuist generate
