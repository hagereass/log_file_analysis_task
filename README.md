Apache Log File Analysis

This project performs a comprehensive analysis of Apache access log files to extract insights and generate statistics related to traffic, errors, and system usage.

📊 Project Overview

The analysis includes:

Request counts (GET, POST)

Unique IP addresses

Status code distribution

Failure rates and peak failure times

Requests per hour and per day

Most active IP addresses

Security observations and system improvement suggestions

📝 Sample Output

Total Requests: 10000
GET Requests: 9952
POST Requests: 5
Failed Requests: 220
Failure Percentage: 2.20%
Most Active IP: 66.249.73.135 with 482 requests
Top Failure Days: 19/May/2015, 18/May/2015
Peak Request Hour: 14:00 (498 requests)

⚙️ Technologies Used

Bash / Shell scripting

Linux CLI tools (awk, grep, sort, uniq, cut)

Text-based log parsing

📁 Files

log_analysis.sh: Bash script for analyzing Apache logs

apache_logs.txt: Sample Apache access log file

report.pdf: Output report with statistics

README.md: Project documentation

🚀 How to Run

Clone the repository:

git clone https://github.com/your-username/log-analysis.git
cd log-analysis

Make the script executable:

chmod +x log_analysis.sh

Run the script and generate report:

./log_analysis.sh apache_logs.txt > report.txt

View the report:

cat report.txt

✅ Analysis Suggestions

1. Reduce Number of Failures

404 Errors: Check for missing pages or broken links. Fix routing or use proper redirects.

500 Errors: Indicates server-side issues. Review backend logs and monitor resource usage.

2. Focus Days & Hours

Highest failures occurred on 18th, 19th, and 20th May.

Failures spike during 05:00 – 09:00, requiring deeper inspection.

3. Security Concerns

IP 66.249.73.135 made 482 requests. May be a bot or crawler.

Apply rate limiting

Implement bot detection

Track GeoIP for unusual traffic origins

4. System Monitoring

Use tools like Prometheus, Grafana, or ELK Stack for:

Real-time monitoring

Alerting on anomalies (e.g., high failure rates)

Log centralization and visualization

5. GET vs. POST Balance

POST requests are minimal (only 5).

Investigate if forms or APIs are functioning correctly.

Secure POST endpoints using validation and CSRF protection.

6. Load Handling & Scalability

Implement auto-scaling for peak traffic hours

Use proper load balancing to distribute requests evenly

7. Logging Improvements

Switch to structured logs (e.g., JSON)

Add metadata (browser, user-agent, location)

Integrate with centralized logging (ELK Stack)

