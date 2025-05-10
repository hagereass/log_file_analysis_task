#!/bin/bash
 
log_file="apache_logs.txt"
 
echo "================ Log File Analysis ================"
 
# 1. Request Counts
total_requests=$(wc -l < "$log_file")
get_requests=$(grep -c '"GET' "$log_file")
post_requests=$(grep -c '"POST' "$log_file")
 
echo "Total Requests: $total_requests"
echo "GET Requests: $get_requests"
echo "POST Requests: $post_requests"
echo "---------------------------------------------------"
 
# 2. Unique IPs
unique_ips=$(awk '{print $1}' "$log_file" | sort | uniq | wc -l)
echo "Unique IP Addresses: $unique_ips"
echo "Requests per IP (GET/POST):"
awk '{ip=$1; method=$6; gsub(/"/,"",method); count[ip][method]++}
     END {
         for (ip in count)
             print ip, "GET:", count[ip]["GET"]+0, "POST:", count[ip]["POST"]+0
     }' "$log_file"
echo "---------------------------------------------------"
 
# 3. Failed Requests
failures=$(awk '$9 ~ /^[45]/ {count++} END {print count+0}' "$log_file")
if [ "$total_requests" -ne 0 ]; then
    fail_percent=$(awk -v f="$failures" -v t="$total_requests" 'BEGIN {printf "%.2f", (f/t)*100}')
else
    fail_percent="0.00"
fi
echo "Failed Requests: $failures"
echo "Failure Percentage: $fail_percent%"
echo "---------------------------------------------------"
 
# 4. Most Active IP
top_ip=$(awk '{print $1}' "$log_file" | sort | uniq -c | sort -nr | head -1)
echo "Most Active IP: $top_ip"
echo "---------------------------------------------------"
 
# 5. Average Requests per Day
total_days=$(awk -F: '{print $1}' "$log_file" | awk -F'[' '{print $2}' | uniq | wc -l)
avg_per_day=$(awk -v t="$total_requests" -v d="$total_days" 'BEGIN {printf "%.2f", t/d}')
echo "Average Requests Per Day: $avg_per_day"
echo "---------------------------------------------------"
 
# 6. Days with Highest Failures
echo "Top 5 Days with Most Failures:"
awk '$9 ~ /^[45]/ {split($4, t, ":"); gsub("\\[", "", t[1]); fails[t[1]]++}
     END {for (day in fails) print fails[day], day}' "$log_file" | sort -nr | head -5
echo "---------------------------------------------------"
 
# Request by Hour
echo "Requests Per Hour:"
awk '{split($4, t, ":"); print t[2]}' "$log_file" | sort | uniq -c | sort -k2n
echo "---------------------------------------------------"
 
# Request Trends
echo "Request Trend (Hourly):"
awk '{split($4, t, ":"); print t[2]}' "$log_file" | sort | uniq -c | sort -k2n
echo "---------------------------------------------------"
 
# Status Code Breakdown
echo "Status Code Breakdown:"
awk '{print $9}' "$log_file" | grep -E '^[0-9]{3}$' | sort | uniq -c | sort -nr
echo "---------------------------------------------------"
 
# Most Active IP by Method
echo "Most Active IP (GET):"
grep '"GET' "$log_file" | awk '{print $1}' | sort | uniq -c | sort -nr | head -1
 
echo "Most Active IP (POST):"
grep '"POST' "$log_file" | awk '{print $1}' | sort | uniq -c | sort -nr | head -1
echo "---------------------------------------------------"
 
# Failure Patterns
echo "Failures by Hour:"
awk '$9 ~ /^[45]/ {split($4, t, ":"); print t[2]}' "$log_file" | sort | uniq -c | sort -k2n
 
echo "Failures by Day:"
awk '$9 ~ /^[45]/ {split($4, t, ":"); gsub("\\[", "", t[1]); print t[1]}' "$log_file" | sort | uniq -c | sort -nr
echo "==================================================="