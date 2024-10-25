project_id=$(gcloud config get-value project)

datasets=($(bq ls))
echo "Please select a dataset:"
select dataset in "${datasets[@]:2}"; do
    [[ -n $dataset ]] || { echo "Invalid choice. Please try again." >&2; continue; }
    break
done

schemas=($( ls *.json ))
echo "Please choose a schema:"
select schema in "${schemas[@]}"; do
    [[ -n $schema ]] || { echo "Invalid choice. Please try again." >&2; continue; }
    break
done
table=$(echo $schema | cut -d "." -f 1)

bq mk --table --schema=./$schema $project_id:$dataset.$table