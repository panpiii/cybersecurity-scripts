analyze_csv(){
	
	csv_file=$1
	printf "\nCyber security index for some country in the world\n"
	# 1.Count the number of records exclude the header
	total_records=$(awk 'NR>1' "$csv_file" | wc -l)
	echo "Number of records:  $total_records" 

	# 2.Country with worst CEI
	worst_CEI_record=$(awk -F',' 'NR>1' $csv_file | sort -t',' -k3,3nr |head -n1)
	worst_CEI_country=$(echo $worst_CEI_record | awk -F',' '{print $1}')
	worst_CEI_value=$(echo $worst_CEI_record | awk -F',' '{print $3}')
	echo "Country with the worst CEI is $worst_CEI_country with CEI $worst_CEI_value"

	# 3. Country with best NCSI
	best_NCSI_record=$(awk -F',' 'NR>1' $csv_file | sort -t',' -k5,5nr |head -n1)
	best_NCSI_country=$(echo $best_NCSI_record | awk -F',' '{print $1}')
	best_NCSI_value=$(echo $best_NCSI_record | awk -F',' '{print $5}')
	echo "Country with the best NCSI is $best_NCSI_country with NCSI $best_NCSI_value"

	# 4.Canada's record in cybersecurity index
	echo "Canada's Cybersecurity indexes:"
	canada_record=$(awk -F',' '/Canada/ {print}' $csv_file)
	# Extract each value
	can_CEI=$(echo $canada_record | awk -F',' '{print $3}')
        can_GCI=$(echo $canada_record | awk -F',' '{print $4}')
	can_NCSI=$(echo $canada_record | awk -F',' '{print $5}')
	can_DLL=$(echo $canada_record | awk -F',' '{print $6}')
	can_DLL=$(echo "$can_DLL" | tr -d '[:space:]')

	# Print the results
	printf "\tCybersecurity Exposure Index (CEI): %.3f\n" "$can_CEI"
	printf "\tGlobal Cybersecurity Index (GCI): %.2f\n" "$can_GCI"
	printf "\tNational Cybersecurity Index (NCSI): %.2f\n" "$can_NCSI"
	printf "\tDigital Development Level (DLL): %.2f\n" "$can_DLL"

	# 5.Average index value for each region
	printf "\nThe average record per region in CEI, GCI, NCSI and DDL: \n"
        
	# Unique regions
        awk -F',' 'NR>1 {print $2}' "$csv_file" | sort | uniq > unique_regions.txt
	# Read unique_regions.txt as array
        mapfile -t regions < unique_regions.txt

	for region in "${regions[@]}"; do
	    country_data=$(grep ",$region," "$csv_file")
	    country_count=$(echo "$country_data" | wc -l)

	    # Calculate the average of index value
	    avg_CEI=$(echo "$country_data" | awk -F',' '{sum+=$3} END {print sum/NR}')
	   
	    avg_GCI=$(echo "$country_data" | awk -F',' '{sum+=$4} END {print sum/NR}')

	    avg_NCSI=$(echo "$country_data" | awk -F',' '{sum+=$5} END {print sum/NR}')

	    avg_DLL=$(echo "$country_data" | awk -F',' '{sum+=$6} END {print sum/NR}')
	    # Print
	    printf "\t%-38s %10.3f %5.3f %5.3f %5.3f\n" "Region $region with $country_count countries" "$avg_CEI" "$avg_GCI" "$avg_NCSI" "$avg_DLL"
	done

}
