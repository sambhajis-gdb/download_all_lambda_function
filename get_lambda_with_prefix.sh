download_code () {
    local OUTPUT=$1
	aws lambda get-function --function-name $OUTPUT --query 'Code.Location' | xargs wget -O ./lambda_functions/$OUTPUT.zip 
}

mkdir -p lambda_functions
for run in $(aws lambda list-functions --query 'Functions[?starts_with(FunctionName, `sambhaji_`) == `true`].FunctionName' --output text);
do
	download_code "$run" &
done

echo "done"
